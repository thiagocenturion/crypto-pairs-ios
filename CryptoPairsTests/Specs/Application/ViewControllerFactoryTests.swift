//
//  ViewControllerFactoryTests.swift
//  CryptoPairsTests
//
//  Created by Thiago Centurion on 12/06/2022.
//

import XCTest

@testable import CryptoPairs
@testable import Domain

final class ViewControllerFactoryTests: XCTestCase {

    func testMakeTodoListViewController() {
        let viewControllerFactory = ViewControllerFactory(tickerUseCase: TickerUseCase(tickersRepository: TickersRepositoryStub()),
                                                          cryptoCurrencyUseCase: CryptoCurrencyUseCase(cryptoCurrenciesRepository: CryptoCurrenciesRepositoryStub()))

        let viewController = viewControllerFactory.makeTickersListViewController()

        XCTAssertTrue(viewController is TickersListViewController)
    }
}
