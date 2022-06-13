//
//  TickerCellViewModelTests.swift
//  CryptoPairsTests
//
//  Created by Thiago Centurion on 13/06/2022.
//

import XCTest

@testable import CryptoPairs
@testable import Domain

final class TickerCellViewModelTests: XCTestCase {

    func testTickerCellViewModel() throws {
        // Given
        let locale = Locale(identifier: "en_US")

        let tickerData = try XCTUnwrap(Self.tickerJSON().data(using: .utf8))
        let ticker = try JSONDecoder().decode(Ticker.self, from: tickerData)

        let cryptoCurrencyData = try XCTUnwrap(Self.cryptoCurrencyJSON().data(using: .utf8))
        let cryptoCurrency = try JSONDecoder().decode(CryptoCurrency.self, from: cryptoCurrencyData)

        // When
        let cellViewModel = TickerCellViewModel(ticker: ticker, cryptoCurrency: cryptoCurrency, locale: locale)

        // Then
        XCTAssertEqual(cellViewModel.title, .init(text: cryptoCurrency.name, type: .heading))
        XCTAssertEqual(cellViewModel.subtitle, .init(text: cryptoCurrency.symbol, type: .body))
        XCTAssertEqual(cellViewModel.price, .init(locale: locale, value: ticker.lastPrice))
        XCTAssertEqual(cellViewModel.percentage, .init(percent: ticker.dailyChangeRelative * 100))
        XCTAssertEqual(cellViewModel.iconURL, cryptoCurrency.icon)
    }
}

// MARK: - Mocks

private extension TickerCellViewModelTests {

    static func tickerJSON() -> String {
        """
        [
            "tBTCUSD",
            29109,
            19.55053378,
            29110,
            30.90551801,
            -1056.76751271,
            -0.035,
            29110,
            4684.85182071,
            30395,
            28864
        ]
        """
    }

    static func cryptoCurrencyJSON() -> String {
        """
        {
            "symbol": "BTC",
            "name": "Bitcoin",
            "icon": "https://s2.coinmarketcap.com/static/img/coins/64x64/1.png"
        }
        """
    }
}
