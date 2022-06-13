//
//  TickersListViewControllerSnapshotTests.swift
//  CryptoPairsSnapshotTests
//
//  Created by Thiago Centurion on 13/06/2022.
//

import XCTest
import SnapshotTesting
import Domain

@testable import CryptoPairs

final class TickersListViewControllerSnapshotTests: XCTestCase {

    // MARK: Constants

    enum Constants {
        static let tickersMockFile = "tickers_mock"
        static let cryptoCurrenciesMockFile = "crypto_currencies_mock"
        static let jsonFileTypeExtension = "json"
    }

    // MARK: Properties

    private var tickersRepositoryStub: TickersRepositoryStub!
    private var cryptoCurrenciesRepositoryStub: CryptoCurrenciesRepositoryStub!

    private var sut: ViewControllerFactory!

    // MARK: - Test Lifecycle

    override func setUp() {
        super.setUp()

        tickersRepositoryStub = TickersRepositoryStub()
        cryptoCurrenciesRepositoryStub = CryptoCurrenciesRepositoryStub()

        let tickerUseCase = TickerUseCase(tickersRepository: tickersRepositoryStub)
        let cryptoCurrencyUseCase = CryptoCurrencyUseCase(cryptoCurrenciesRepository: cryptoCurrenciesRepositoryStub)

        sut = ViewControllerFactory(tickerUseCase: tickerUseCase, cryptoCurrencyUseCase: cryptoCurrencyUseCase)
    }

    override func tearDown() {
        tickersRepositoryStub = nil
        cryptoCurrenciesRepositoryStub = nil
        sut = nil

        super.tearDown()
    }

    // MARK: - Tests
    func testTickersListViewControllerSuccess() throws {
        // Given
        let cryptoCurrencies: [CryptoCurrency] = try self.loadFromJson(named: Constants.cryptoCurrenciesMockFile)
        let tickers: [Ticker] = try self.loadFromJson(named: Constants.tickersMockFile)

        cryptoCurrenciesRepositoryStub.result = .just(cryptoCurrencies)
        tickersRepositoryStub.result = .just(tickers)

        // When
        let viewController = sut.makeTickersListViewController()

        // Then
        verifyViewController(viewController, named: #function)
    }

    func testTickersListViewControllerError() throws {
        // Given
        let cryptoCurrencies: [CryptoCurrency] = try self.loadFromJson(named: Constants.cryptoCurrenciesMockFile)

        cryptoCurrenciesRepositoryStub.result = .just(cryptoCurrencies)
        tickersRepositoryStub.result = .error(CocoaError.error(.fileReadUnknown))

        // When
        let viewController = sut.makeTickersListViewController()

        // Then
        verifyViewController(viewController, named: #function)
    }
}

private extension TickersListViewControllerSnapshotTests {

    func verifyViewController(_ viewController: UIViewController, named: String, record: Bool = false) {
        let navigationController = UINavigationController()
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.pushViewController(viewController, animated: false)

        let result = verifySnapshot(matching: navigationController,
                                    as: .image(on: .iPhoneX),
                                    named: named,
                                    record: record)

        XCTAssertNil(result)
    }

    func loadFromJson<T: Decodable>(named fileName: String) throws -> T {
        let bundle = Bundle(for: TickersListViewControllerSnapshotTests.self)
        let url = try XCTUnwrap(bundle.url(forResource: fileName, withExtension: Constants.jsonFileTypeExtension))
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(T.self, from: data)
    }
}
