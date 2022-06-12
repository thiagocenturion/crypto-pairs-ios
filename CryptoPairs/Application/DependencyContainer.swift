//
//  DependencyContainer.swift
//  CryptoPairs
//
//  Created by Thiago Centurion on 12/06/2022.
//

import Networking
import Domain

final class DependencyContainer {

    static let shared = DependencyContainer()

    let viewControllerFactory: ViewControllerFactory

    init(networkingService: NetworkingServiceProtocol = NetworkingService()) {
        let tickersRepository = DefaultTickersRepository(networkingServices: networkingService)
        let tickerUseCase = TickerUseCase(tickersRepository: tickersRepository)

        let cryptoCurrenciesRepository = DefaultCryptoCurrenciesRepository()
        let cryptoCurrencyUseCase = CryptoCurrencyUseCase(cryptoCurrenciesRepository: cryptoCurrenciesRepository)

        self.viewControllerFactory = ViewControllerFactory(tickerUseCase: tickerUseCase,
                                                           cryptoCurrencyUseCase: cryptoCurrencyUseCase)
    }
}
