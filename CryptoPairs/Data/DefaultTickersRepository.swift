//
//  DefaultTickersRepository.swift
//  CryptoPairs
//
//  Created by Thiago Centurion on 12/06/2022.
//

import Foundation
import Domain
import Networking
import RxSwift
import RxCocoa

final class DefaultTickersRepository {

    // MARK: Properties
    private let networkingServices: NetworkingServiceProtocol

    // MARK: - Initialization
    init(networkingServices: NetworkingServiceProtocol) {
        self.networkingServices = networkingServices
    }
}

// MARK: - TickersRepository

extension DefaultTickersRepository: TickersRepository {

    func fetchTickersList(symbols: [String]) -> Single<[Ticker]> {
        return networkingServices.request(endpoint: .tickers(symbols: symbols))
    }
}
