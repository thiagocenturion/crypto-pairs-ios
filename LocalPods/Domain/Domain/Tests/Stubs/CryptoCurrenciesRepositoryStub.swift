//
//  CryptoCurrenciesRepositoryStub.swift
//  Domain-Unit-Tests
//
//  Created by Thiago Centurion on 11/06/2022.
//

import Foundation
import RxSwift

@testable import Domain

struct CryptoCurrenciesRepositoryStub: CryptoCurrenciesRepository {

    var result: Single<[CryptoCurrency]>

    func fetchCryptoCurrenciesList() -> Single<[CryptoCurrency]> { result }
}
