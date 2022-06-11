//
//  CryptoCurrenciesRepository.swift
//  Domain
//
//  Created by Thiago Centurion on 11/06/2022.
//

import Foundation
import RxSwift

protocol CryptoCurrenciesRepository {

    func fetchCryptoCurrenciesList() -> Single<[CryptoCurrency]>
}
