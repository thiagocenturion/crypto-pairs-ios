//
//  TickersListViewModel.swift
//  CryptoPairs
//
//  Created by Thiago Centurion on 12/06/2022.
//

import Foundation
import Domain
import RxSwift
import RxCocoa
import Reachability
import RxReachability
import UIComponents

final class TickersListViewModel {

    // MARK: Constants

    enum Constants {
        static let timeIntervalPolling: RxTimeInterval = .seconds(5)
        static let timeout: RxTimeInterval = .seconds(30)
    }

    // MARK: Properties

    var title: String { "Crypto Marketplace" }
    var searchBarPlaceholder: String { "Type to search" }

    let errorToast = PublishRelay<ErrorToastViewModel?>()
    let cancelFilter = PublishRelay<Void>()
    let query: BehaviorRelay<String> = .init(value: "")
    var cellViewModels: BehaviorRelay<[TickerCellViewModel]> = .init(value: [])

    private let numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        return numberFormatter
    }()

    private let locale: Locale
    private let tickerUseCase: TickerUseCaseProtocol
    private let cryptoCurrencyUseCase: CryptoCurrencyUseCaseProtocol

    private var pollingObservable: Disposable?

    private var cryptoCurrencies: [CryptoCurrency] = []
    private let tickers: BehaviorRelay<[Ticker]> = .init(value: [])
    private var filteredTickers: [Ticker] = []
    private var isFiltering: Bool = false
    private let reloadData = PublishRelay<Void>()

    private let disposeBag = DisposeBag()

    // MARK: - Initialization

    init(locale: Locale,
         tickerUseCase: TickerUseCaseProtocol,
         cryptoCurrencyUseCase: CryptoCurrencyUseCaseProtocol) {

        self.locale = locale
        numberFormatter.locale = locale

        self.tickerUseCase = tickerUseCase
        self.cryptoCurrencyUseCase = cryptoCurrencyUseCase

        bind()
    }
}

// MARK: - Methods

extension TickersListViewModel {

    func start() {
        // Fetch all crypto currencies and request for tickers
        fetchCryptoCurrencies()
            .bind(to: fetchTickers)
            .disposed(by: disposeBag)
    }

    private func fetchCryptoCurrencies() -> Observable<[CryptoCurrency]> {
        return cryptoCurrencyUseCase.cryptoCurrencies()
            .do(onSuccess: { [weak self] in self?.cryptoCurrencies = $0 })
            .asObservable()
    }
}

// MARK: - Binding

private extension TickersListViewModel {

    func bind() {

        // Polling to automatically update tickers based on a specific time range
        pollingObservable = Observable<Int>
            .interval(Constants.timeIntervalPolling, scheduler: MainScheduler.instance)
            .compactMap { [weak self] _ in self?.cryptoCurrencies }
            .bind(to: fetchTickers)

        // Reload data for any updates like filtering or disabling search
        reloadData
            .withLatestFrom(tickers)
            .bind(to: tickers)
            .disposed(by: disposeBag)

        // Create all cell view models and send them to the view based on whether it's filtering or not.
        tickers
            .compactMap { [weak self] in self?.isFiltering == true ? self?.filteredTickers : $0 }
            .map { $0.compactMap(self.cellViewModel) }
            .bind(to: cellViewModels)
            .disposed(by: disposeBag)

        query
            .bind(to: searchQuery)
            .disposed(by: disposeBag)

        // Cancel the filter state by removing all filtered tickers
        cancelFilter
            .subscribe(onNext: { [weak self] _ in
                self?.filteredTickers.removeAll()
                self?.isFiltering = false
            })
            .disposed(by: disposeBag)

        // Reachability handling
        Reachability.rx.isDisconnected
            .map { .init(message: "No Internet Connection Available") }
            .bind(to: errorToast)
            .disposed(by: disposeBag)

        Reachability.rx.isConnected
            .map { nil }
            .bind(to: errorToast)
            .disposed(by: disposeBag)
    }
}

// MARK: - Tickers

private extension TickersListViewModel {

    var fetchTickers: Binder<[CryptoCurrency]> {
        Binder(self) { base, cryptoCurrencies in
            guard let pairSymbol = base.numberFormatter.currencyCode else { return }

            base.tickerUseCase.tickers(currencySymbols: cryptoCurrencies.map(\.symbol), pairWith: pairSymbol)
                .subscribe(
                    onSuccess: { tickers in
                        base.tickers.accept(tickers)
                    },
                    onFailure: { error in
                        base.errorToast.accept(.init(message: error.localizedDescription))
                    }
                ).disposed(by: base.disposeBag)
        }
    }

    var searchQuery: Binder<String> {
        Binder(self) { base, query in
            if query.isEmpty {
                self.isFiltering = false
            } else {
                base.isFiltering = true
                base.filteredTickers = base.filter(tickers: base.tickers.value, query: query)
            }

            base.reloadData.accept(())
        }
    }

    func filter(tickers: [Ticker], query: String) -> [Ticker] {
        tickers.filter { ticker in
            guard let cryptoCurrency = cryptoCurrency(ticker) else { return false }

            return cryptoCurrency.name.lowercased().contains(query.lowercased()) ||
            ticker.symbol.lowercased().contains(query.lowercased())
        }
    }
}

// MARK: - Helpers

private extension TickersListViewModel {

    func cellViewModel(_ ticker: Ticker) -> TickerCellViewModel? {
        guard let cryptoCurrency = self.cryptoCurrency(ticker) else { return nil }

        return .init(title: cryptoCurrency.name,
                     subtitle: cryptoCurrency.symbol,
                     locale: self.locale,
                     price: ticker.lastPrice,
                     percent: ticker.dailyChangeRelative * 100,
                     iconURL: cryptoCurrency.icon)
    }

    func ticker(_ cellViewModel: TickerCellViewModel) -> Ticker? {
        return tickers.value.first { $0.symbol.contains(cellViewModel.subtitle.text ?? "") }
    }

    func cryptoCurrency(_ ticker: Ticker) -> CryptoCurrency? {
        cryptoCurrencies.first(where: { ticker.symbol.contains($0.symbol) })
    }
}
