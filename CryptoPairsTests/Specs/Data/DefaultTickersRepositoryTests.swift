//
//  DefaultTickersRepositoryTests.swift
//  CryptoPairsTests
//
//  Created by Thiago Centurion on 12/06/2022.
//

import XCTest
import Networking

@testable import CryptoPairs

final class DefaultTickersRepositoryTests: XCTestCase {

    func testFetchTickersList() {

        // Given
        let spy = NetworkingServiceSpy()
        let tickersRepository = DefaultTickersRepository(networkingServices: spy)
        let expectedSymbols = ["tBTCUSD", "tETHUSD"]

        // When
        _ = tickersRepository.fetchTickersList(symbols: expectedSymbols)

        // Then
        XCTAssertFalse(spy.calls.isEmpty)

        let requestCall = spy.calls[0]

        switch requestCall.endpoint {
        case .tickers(let symbols):
            XCTAssertEqual(symbols, expectedSymbols)
        }
    }
}
