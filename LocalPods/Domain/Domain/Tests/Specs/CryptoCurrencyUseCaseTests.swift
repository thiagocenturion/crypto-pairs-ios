//
//  CryptoCurrencyUseCaseTests.swift
//  Domain-Unit-Tests
//
//  Created by Thiago Centurion on 11/06/2022.
//

import XCTest
import RxSwift
import RxCocoa

@testable import Domain

final class CryptoCurrencyUseCaseTests: XCTestCase {

    // MARK: Contants
    enum Constants {
        static let timeout: TimeInterval = 1
    }

    // MARK: Properties
    var disposeBag: DisposeBag!

    // MARK: Mocks
    enum CryptoCurrencySuccessTestError: Error {
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
    func testCryptoCurrenciesSuccess() {

        // Given
        let expectation = expectation(description: #function)

        let expectedCurrencies: [CryptoCurrency] = .mock()
        let stub = CryptoCurrenciesRepositoryStub(result: .just(expectedCurrencies))
        let useCases = CryptoCurrencyUseCase(cryptoCurrenciesRepository: stub)
        var result: SingleEvent<[CryptoCurrency]>?

        // When
        useCases.cryptoCurrencies()
            .subscribe { result = $0 }
            .disposed(by: self.disposeBag)

        // Then
        switch result {
        case .success(let currencies):
            XCTAssertEqual(currencies, expectedCurrencies)
            expectation.fulfill()

        default:
            XCTFail("Expecting success")
        }

        wait(for: [expectation], timeout: Constants.timeout)
    }

    func testCryptoCurrenciesFailure() {

        // Given
        let expectation = expectation(description: #function)

        let expectedError: CryptoCurrencySuccessTestError = .failedFetching
        let stub = CryptoCurrenciesRepositoryStub(result: .error(expectedError))
        let useCases = CryptoCurrencyUseCase(cryptoCurrenciesRepository: stub)
        var result: SingleEvent<[CryptoCurrency]>?

        // When
        useCases.cryptoCurrencies()
            .subscribe { result = $0 }
            .disposed(by: self.disposeBag)

        // Then
        switch result {
        case .failure(let error):
            XCTAssertEqual(error as? CryptoCurrencySuccessTestError, expectedError)
            expectation.fulfill()

        default:
            XCTFail("Expecting failure")
        }

        wait(for: [expectation], timeout: Constants.timeout)
    }
}

// MARK: - Mocks
private extension Array where Element == CryptoCurrency {

    static func mock() -> [CryptoCurrency] {
        [
            .mock(symbol: "BTC", name: "Bitcoin"),
            .mock(symbol: "ETH", name: "Ethereum"),
            .mock(symbol: "CHSB", name: "SwissBorg")
        ]
    }
}

private extension CryptoCurrency {

    static func mock(symbol: String = "BTC",
                     name: String = "Bitcoin",
                     icon: URL = URL(string: "https://s2.coinmarketcap.com/static/img/coins/64x64/1.png")!) -> CryptoCurrency {

        .init(symbol: symbol,
              name: name,
              icon: icon)
    }
}
