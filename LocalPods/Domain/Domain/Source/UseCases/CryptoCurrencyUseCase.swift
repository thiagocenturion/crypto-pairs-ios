//
//  CryptoCurrencyUseCase.swift
//  Domain
//
//  Created by Thiago Centurion on 11/06/2022.
//

import Foundation
import RxSwift

public protocol CryptoCurrencyUseCaseProtocol {

    func cryptoCurrencies() -> Single<[CryptoCurrency]>
}

final public class CryptoCurrencyUseCase: CryptoCurrencyUseCaseProtocol {

    // MARK: Properties
    private let cryptoCurrenciesRepository: CryptoCurrenciesRepository
    private var currencies: [CryptoCurrency]?

    // MARK: - Initialiation
    public init(cryptoCurrenciesRepository: CryptoCurrenciesRepository) {

        self.cryptoCurrenciesRepository = cryptoCurrenciesRepository
    }

    // MARK: - CryptoCurrencyUseCaseProtocol
    public func cryptoCurrencies() -> Single<[CryptoCurrency]> {

        if let currencies = self.currencies {
            return .just(currencies)
        } else {
            return cryptoCurrenciesRepository.fetchCryptoCurrenciesList()
        }
    }
}
