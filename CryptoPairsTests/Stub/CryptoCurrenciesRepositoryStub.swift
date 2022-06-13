//
//  CryptoCurrenciesRepositoryStub.swift
//  CryptoPairsSnapshotTests
//
//  Created by Thiago Centurion on 13/06/2022.
//

import Foundation
import RxSwift
import RxCocoa
import Domain

final class CryptoCurrenciesRepositoryStub {

    // MARK: Stub
    var result: Single<[CryptoCurrency]>

    // MARK: Spy
    var calls: [Call] = []

    // MARK: - Initialization

    init(result: Single<[CryptoCurrency]> = .never()) {
        self.result = result
    }
}

// MARK: - Spy

extension CryptoCurrenciesRepositoryStub {

    enum Call {
        case fetchCryptoCurrenciesList
    }
}

// MARK: - CryptoCurrenciesRepository

extension CryptoCurrenciesRepositoryStub: CryptoCurrenciesRepository {

    func fetchCryptoCurrenciesList() -> Single<[CryptoCurrency]> {
        calls.append(.fetchCryptoCurrenciesList)
        return result
    }
}
