//
//  DefaultCryptoCurrenciesRepositoryTests.swift
//  CryptoPairsTests
//
//  Created by Thiago Centurion on 12/06/2022.
//

import XCTest
import RxSwift
import RxCocoa
import Domain

@testable import CryptoPairs

final class DefaultCryptoCurrenciesRepositoryTests: XCTestCase {

    enum Constants {
        static let timeout: TimeInterval = 1

        enum File {
            static let cryptoCurrencies = "crypto_currencies"
        }
    }

    // MARK: Properties
    var disposeBag: DisposeBag!

    // MARK: - Lifecycle
    override func setUp() {
        super.setUp()

        self.disposeBag = DisposeBag()
    }

    override func tearDown() {
        self.disposeBag = nil

        super.tearDown()
    }

    // MARK: - Tests

    func testFetchCryptoCurrenciesListSuccess() throws {

        // Given
        let expectation = XCTestExpectation(description: #function)
        let cryptoCurrenciesRepository = DefaultCryptoCurrenciesRepository(fileName: Constants.File.cryptoCurrencies)
        var result: SingleEvent<[CryptoCurrency]>?

        let url = try XCTUnwrap(Bundle.main.url(forResource: Constants.File.cryptoCurrencies, withExtension: "json"))
        let data = try Data(contentsOf: url)
        let expectedCurrencies = try JSONDecoder().decode([CryptoCurrency].self, from: data)

        // When
        cryptoCurrenciesRepository.fetchCryptoCurrenciesList()
            .subscribe { result = $0 }
            .disposed(by: self.disposeBag)

        // Then
        switch result {
        case .success(let currencies):
            XCTAssertEqual(currencies, expectedCurrencies)
            expectation.fulfill()
        default:
            XCTFail("Expecting success.")
        }

        wait(for: [expectation], timeout: Constants.timeout)
    }

    func testFetchCryptoCurrenciesListError() throws {

        // Given
        let expectation = XCTestExpectation(description: #function)
        let cryptoCurrenciesRepository = DefaultCryptoCurrenciesRepository(fileName: "xzy")
        var result: SingleEvent<[CryptoCurrency]>?
        let expectedError = CocoaError.error(.fileReadUnknown)

        // When
        cryptoCurrenciesRepository.fetchCryptoCurrenciesList()
            .subscribe { result = $0 }
            .disposed(by: self.disposeBag)

        // Then
        switch result {
        case .failure(let error):
            XCTAssertEqual(error as? CocoaError, expectedError as? CocoaError)
            expectation.fulfill()
        default:
            XCTFail("Expecting failure.")
        }

        wait(for: [expectation], timeout: Constants.timeout)
    }
}
