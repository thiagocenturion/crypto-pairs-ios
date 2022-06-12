//
//  DefaultCryptoCurrenciesRepository.swift
//  CryptoPairs
//
//  Created by Thiago Centurion on 12/06/2022.
//

import Foundation
import Domain
import RxSwift
import RxCocoa

final class DefaultCryptoCurrenciesRepository {

    // MARK: Constants
    enum Constants {
        enum File {
            static let cryptoCurrencies = "crypto_currencies"
        }
    }

    // MARK: - Initialization
    init() {}
}

// MARK: - CryptoCurrenciesRepository

extension DefaultCryptoCurrenciesRepository: CryptoCurrenciesRepository {

    func fetchCryptoCurrenciesList() -> Single<[CryptoCurrency]> {
        // TODO: - Implement the cryptocurrencies list in the back-end side and fetch it using an API
        guard let url = Bundle.main.url(forResource: Constants.File.cryptoCurrencies, withExtension: "json") else {

            return .error(CocoaError.error(.fileNoSuchFile))
        }

        guard let data = try? Data(contentsOf: url) else {

            return .error(CocoaError.error(.fileReadCorruptFile))
        }

        guard let cryptoCurrencies = try? JSONDecoder().decode([CryptoCurrency].self, from: data) else {

            return .error(CocoaError.error(.fileReadUnknown))
        }

        return .just(cryptoCurrencies)
    }
}
