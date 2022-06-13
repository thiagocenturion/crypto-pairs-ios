//
//  ViewControllerFactory.swift
//  CryptoPairs
//
//  Created by Thiago Centurion on 12/06/2022.
//

import UIKit
import Domain

protocol ViewControllerFactoryProtocol {
    func makeTickersListViewController() -> UIViewController
}

final class ViewControllerFactory: ViewControllerFactoryProtocol {

    let tickerUseCase: TickerUseCaseProtocol
    let cryptoCurrencyUseCase: CryptoCurrencyUseCaseProtocol

    init(tickerUseCase: TickerUseCaseProtocol,
         cryptoCurrencyUseCase: CryptoCurrencyUseCaseProtocol) {

        self.tickerUseCase = tickerUseCase
        self.cryptoCurrencyUseCase = cryptoCurrencyUseCase
    }

    func makeTickersListViewController() -> UIViewController {
        // Static Locale to display only a list of crypto trading pairs with USD, but it can be any
        let locale = Locale(identifier: "en_US")

        let viewModel = TickersListViewModel(locale: locale,
                                             tickerUseCase: tickerUseCase,
                                             cryptoCurrencyUseCase: cryptoCurrencyUseCase)

        return TickersListViewController(viewModel: viewModel)
    }
}
