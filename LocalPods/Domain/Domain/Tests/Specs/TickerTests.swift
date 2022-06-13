//
//  TickerTests.swift
//  
//
//  Created by Thiago Centurion on 10/06/2022.
//

import XCTest

@testable import Domain

final class TickerTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    func testTradingPair() throws {

        let jsonData = try XCTUnwrap(Self.tickerJSON().data(using: .utf8))

        let ticker = try JSONDecoder().decode(Ticker.self, from: jsonData)

        XCTAssertEqual(ticker.symbol, "tBTCUSD")
        XCTAssertEqual(ticker.bid, 29109)
        XCTAssertEqual(ticker.bidSize, 19.55053378)
        XCTAssertEqual(ticker.ask, 29110)
        XCTAssertEqual(ticker.askSize, 30.90551801)
        XCTAssertEqual(ticker.dailyChange, -1056.76751271)
        XCTAssertEqual(ticker.dailyChangeRelative, -0.035)
        XCTAssertEqual(ticker.lastPrice, 29110)
        XCTAssertEqual(ticker.volume, 4684.85182071)
        XCTAssertEqual(ticker.high, 30395)
        XCTAssertEqual(ticker.low, 28864)
    }
}

private extension TickerTests {

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
}
