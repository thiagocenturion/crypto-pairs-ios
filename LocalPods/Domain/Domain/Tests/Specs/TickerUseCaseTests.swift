//
//  TickerUseCaseTests.swift
//  Domain-Unit-Tests
//
//  Created by Thiago Centurion on 11/06/2022.
//

import XCTest
import RxSwift
import RxCocoa

@testable import Domain

final class TickerUseCaseTests: XCTestCase {

    // MARK: Contants
    enum Constants {
        static let timeout: TimeInterval = 1
    }

    // MARK: Properties
    var disposeBag: DisposeBag!

    // MARK: Mocks
    static let currencySymbols: [String] = {
        return [
            "BTC",
            "ETH",
            "CHSB",
            "LTC",
            "XRP",
            "DSH",
            "RRT",
            "EOS",
            "SAN",
            "DAT",
            "SNT",
            "DOGE",
            "LUNA",
            "MATIC",
            "NEXO",
            "OCEAN",
            "BEST",
            "AAVE",
            "PLU",
            "FIL"
        ]
    }()

    static let pairSymbol: String = { "USD" }()

    enum TickerRepositorySuccessTestError: Error {
        case failedFetching
    }

    // MARK: - Test Lifecycle
    override func setUp() {
        super.setUp()

        self.disposeBag = DisposeBag()
    }

    override func tearDown() {
        self.disposeBag = nil

        super.tearDown()
    }

    // MARK: - Tests
    func testTickersSuccess() {

        // Given
        let expectation = expectation(description: #function)

        let expectedTickers: [Ticker] = .mock()
        let stub = TickersRepositoryStub(result: .just(expectedTickers))
        let useCases = TickerUseCase(tickersRepository: stub)
        var result: SingleEvent<[Ticker]>?

        // When
        useCases.tickers(currencySymbols: Self.currencySymbols, pairWith: Self.pairSymbol)
            .subscribe { result = $0 }
            .disposed(by: self.disposeBag)

        // Then
        switch result {
        case .success(let tickers):
            XCTAssertEqual(tickers, expectedTickers)
            expectation.fulfill()

        default:
            XCTFail("Expecting success")
        }

        wait(for: [expectation], timeout: Constants.timeout)
    }

    func testTickersFailure() {

        // Given
        let expectation = expectation(description: #function)

        let expectedError: TickerRepositorySuccessTestError = .failedFetching
        let stub = TickersRepositoryStub(result: .error(expectedError))
        let useCases = TickerUseCase(tickersRepository: stub)
        var result: SingleEvent<[Ticker]>?

        // When
        useCases.tickers(currencySymbols: Self.currencySymbols, pairWith: Self.pairSymbol)
            .subscribe { result = $0 }
            .disposed(by: self.disposeBag)

        // Then
        switch result {
        case .failure(let error):
            XCTAssertEqual(error as? TickerRepositorySuccessTestError, expectedError)
            expectation.fulfill()

        default:
            XCTFail("Expecting failure")
        }

        wait(for: [expectation], timeout: Constants.timeout)
    }
}

// MARK: - Mocks
private extension Array where Element == Ticker {

    static func mock() -> [Ticker] {
        [
            .mock(symbol: "tBTCUSD"),
            .mock(symbol: "tETHUSD"),
            .mock(symbol: "tCHSB:USD"),
            .mock(symbol: "tLTCUSD")
        ]
    }
}

private extension Ticker {

    static func mock(symbol: String = "tBTCUSD",
                     bid: Float = 29109,
                     bidSize: Float = 19.55053378,
                     ask: Float = 29110,
                     askSize: Float = 30.90551801,
                     dailyChange: Float = -1056.76751271,
                     dailyChangeRelative: Float = -0.035,
                     lastPrice: Float = 29110,
                     volume: Float = 4684.85182071,
                     high: Float = 30395,
                     low: Float = 28864) -> Ticker {

        .init(symbol: symbol,
                bid: bid,
                bidSize: bidSize,
                ask: ask,
                askSize: askSize,
                dailyChange: dailyChange,
                dailyChangeRelative: dailyChangeRelative,
                lastPrice: lastPrice,
                volume: volume,
                high: high,
                low: low)
    }
}
