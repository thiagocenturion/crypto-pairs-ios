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
//        let viewModel = TickersListViewModel(networkingService: networkingService)
//        return TickersListViewController(viewModel: viewModel)
        return UIViewController()
    }
}
