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
        static let jsonFileTypeExtension = "json"
    }

    // MARK: Properties
    let fileName: String

    // MARK: - Initialization

    init(fileName: String) {
        self.fileName = fileName
    }
}

// MARK: - CryptoCurrenciesRepository

extension DefaultCryptoCurrenciesRepository: CryptoCurrenciesRepository {

    func fetchCryptoCurrenciesList() -> Single<[CryptoCurrency]> {
        // With this  the cryptocurrencies list in the back-end side and fetch it using an API
        guard let url = Bundle.main.url(forResource: fileName, withExtension: Constants.jsonFileTypeExtension),
              let data = try? Data(contentsOf: url),
              let cryptoCurrencies = try? JSONDecoder().decode([CryptoCurrency].self, from: data) else {

            return .error(CocoaError.error(.fileReadUnknown))
        }

        return .just(cryptoCurrencies)
    }
}
