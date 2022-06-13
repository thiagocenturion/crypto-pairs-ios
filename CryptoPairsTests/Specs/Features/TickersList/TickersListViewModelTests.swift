//
//  TickersListViewModelTests.swift
//  CryptoPairsTests
//
//  Created by Thiago Centurion on 13/06/2022.
//

import XCTest
import Domain
import RxSwift
import RxCocoa
import RxTest
import RxBlocking

@testable import CryptoPairs

final class TickersListViewModelTests: XCTestCase {

    // MARK: Constants

    enum Constants {
        static let tickersMockFile = "tickers_mock"
        static let cryptoCurrenciesMockFile = "crypto_currencies_mock"
        static let jsonFileTypeExtension = "json"
    }

    // MARK: Properties

    private var cryptoCurrenciesRepositoryStub: CryptoCurrenciesRepositoryStub!
    private var tickersRepositoryStub: TickersRepositoryStub!
    private var disposeBag: DisposeBag!

    private var viewModel: TickersListViewModel!

    // MARK: - Test Lifecycle

    override func setUp() {
        super.setUp()

        cryptoCurrenciesRepositoryStub = CryptoCurrenciesRepositoryStub(result: .just(self.cryptoCurrenciesMock()))
        tickersRepositoryStub = TickersRepositoryStub(result: .just(self.tickersMock()))

        let tickerUseCase = TickerUseCase(tickersRepository: tickersRepositoryStub)
        let cryptoCurrencyUseCase = CryptoCurrencyUseCase(cryptoCurrenciesRepository: cryptoCurrenciesRepositoryStub)

        viewModel = TickersListViewModel(locale: Locale(identifier: "en_US"),
                                   tickerUseCase: tickerUseCase,
                                   cryptoCurrencyUseCase: cryptoCurrencyUseCase)

        disposeBag = DisposeBag()
    }

    override func tearDown() {
        tickersRepositoryStub = nil
        cryptoCurrenciesRepositoryStub = nil
        disposeBag = nil
        viewModel = nil

        super.tearDown()
    }

    // MARK: - Tests

    func testStart() {
        // Given
        let expectedSymbols = self.tickersMock().map(\.symbol)

        // When
        viewModel.start()

        // Then
        XCTAssertEqual(cryptoCurrenciesRepositoryStub.calls.count, 1)
        XCTAssertEqual(tickersRepositoryStub.calls.count, 1)

        guard case .fetchTickersList(let symbols) = tickersRepositoryStub.calls.last else {
            XCTFail("Expecting .fetchTickersList(symbols:)")
            return
        }

        XCTAssertEqual(symbols, expectedSymbols)
    }

    func testCellViewModelsSuccess() {
        // Given
        let expectedCellViewModels = self.tickersMock().compactMap { ticker -> TickerCellViewModel? in
            guard let cryptoCurrency = self.cryptoCurrenciesMock().first(where: { ticker.symbol.contains($0.symbol) }) else { return nil }
            return TickerCellViewModel(ticker: ticker, cryptoCurrency: cryptoCurrency, locale: Locale(identifier: "en_US"))
        }

        // When
        viewModel.start()

        // Then
        XCTAssertEqual(try viewModel.cellViewModels.toBlocking().first(), expectedCellViewModels)
    }

    func testCellViewModelsError() throws {
        // Given
        let error = NSError.init(domain: "Expecting error toast", code: 404)
        let expectedErrorMessage = error.localizedDescription
        tickersRepositoryStub.result = .error(error)

        // When
        viewModel.start()

        // Then
        let errorMessage = try viewModel.errorToast.toBlocking().first()??.message.text
        XCTAssertEqual(errorMessage, expectedErrorMessage)
    }

    func testPollingObservable() {
        // Given
        cryptoCurrenciesRepositoryStub.result = .just(self.cryptoCurrenciesMock())
        let tickerUseCase = TickerUseCase(tickersRepository: tickersRepositoryStub)
        let cryptoCurrencyUseCase = CryptoCurrencyUseCase(cryptoCurrenciesRepository: cryptoCurrenciesRepositoryStub)

        let scheduler = TestScheduler(initialClock: 0)

        let viewModel = TickersListViewModel(locale: Locale(identifier: "en_US"),
                                             tickerUseCase: tickerUseCase,
                                             cryptoCurrencyUseCase: cryptoCurrencyUseCase,
                                             scheduler: scheduler)

        let result = scheduler.start(created: 0, subscribed: 0, disposed: 21) { viewModel.pollingObservable }

        // When
        viewModel.start()

        // Then
        let correct = Recorded.events(
            .next(5, 0), // output 1 call at 5 seconds
            .next(10, 1), // output 2 calls at 10 seconds
            .next(15, 2), // output 3 calls at 15 seconds
            .next(20, 3) // output 4 calls at 20 seconds
        )

        XCTAssertEqual(result.events, correct)
    }

    func testQuery() {
        // Given
        let scheduler = TestScheduler(initialClock: 0)
        let cellViewModelsObserver = scheduler.createObserver([TickerCellViewModel].self)

        viewModel.start()

        viewModel.cellViewModels
            .bind(to: cellViewModelsObserver)
            .disposed(by: disposeBag)

        // When
        scheduler.createColdObservable([
            .next(10, "B"),
            .next(20, "Bitcoin"),
            .next(30, "CHSB"),
            .next(40, "")])
        .bind(to: viewModel.query)
        .disposed(by: disposeBag)

        scheduler.start()

        // Then
        let correct: [Recorded<Event<[TickerCellViewModel]>>] = Recorded.events(
            .next(0, self.cellViewModelsMock()), // Initial state
            .next(10, self.cellViewModelsMock().filter("B")), // "Bitcoin", "SwissBorg"
            .next(20, self.cellViewModelsMock().filter("Bitcoin")), // "Bitcoin" by name
            .next(30, self.cellViewModelsMock().filter("CHSB")), // "SwissBorg" by symbol
            .next(40, self.cellViewModelsMock()) // Returns to initial state
        )

        XCTAssertEqual(cellViewModelsObserver.events, correct)
    }

    func testCancelFilter() {
        // Given
        viewModel.start()
        viewModel.query.accept("Bitcoint") // Filtered
        XCTAssertEqual(viewModel.cellViewModels.value, self.cellViewModelsMock().filter("Bitcoint"))

        // When
        viewModel.cancelFilter.accept(())

        // Then
        XCTAssertEqual(viewModel.cellViewModels.value, self.cellViewModelsMock())
    }
}

private extension TickersListViewModelTests {

    func cellViewModelsMock() -> [TickerCellViewModel] {
        self.tickersMock().compactMap { ticker -> TickerCellViewModel? in
            guard let cryptoCurrency = self.cryptoCurrenciesMock().first(where: { ticker.symbol.contains($0.symbol) }) else { return nil }

            return TickerCellViewModel(ticker: ticker, cryptoCurrency: cryptoCurrency, locale: Locale(identifier: "en_US"))
        }
    }

    func cryptoCurrenciesMock() -> [CryptoCurrency] {

        guard let model: [CryptoCurrency] = try? self.loadFromJson(named: Constants.cryptoCurrenciesMockFile) else {
            return []
        }

        return model
    }

    func tickersMock() -> [Ticker] {
        guard let model: [Ticker] = try? self.loadFromJson(named: Constants.tickersMockFile) else {
            return []
        }

        return model
    }

    func loadFromJson<T: Decodable>(named fileName: String) throws -> T {
        let bundle = Bundle(for: TickersListViewModelTests.self)
        let url = try XCTUnwrap(bundle.url(forResource: fileName, withExtension: Constants.jsonFileTypeExtension))
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(T.self, from: data)
    }
}

private extension Array where Element == TickerCellViewModel {

    func filter(_ query: String) -> [TickerCellViewModel] {
        filter { cellViewModel in
            return cellViewModel.title.text?.lowercased().contains(query.lowercased()) == true ||
            cellViewModel.subtitle.text?.lowercased().contains(query.lowercased()) == true
        }
    }
}
