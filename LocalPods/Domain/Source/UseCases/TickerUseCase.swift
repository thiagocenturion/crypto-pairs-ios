//
//  TickerUseCase.swift
//  
//
//  Created by Thiago Centurion on 10/06/2022.
//

import Foundation
import RxSwift

public protocol TickerUseCaseProtocol {

    func tickers(currencySymbols: [String], pairWith pairSymbol: String) -> Single<[Ticker]>
}

final class TickerUseCase: TickerUseCaseProtocol {

    // MARK: Properties
    private let tickersRepository: TickersRepository

    // MARK: - Initialiation
    init(tickersRepository: TickersRepository) {

        self.tickersRepository = tickersRepository
    }

    // MARK: - TickerUseCaseProtocol
    func tickers(currencySymbols: [String], pairWith pairSymbol: String) -> Single<[Ticker]> {

        let currencyPairs = currencySymbols.map { symbol -> String in
            if symbol.count > 3 {
                return "t\(symbol.uppercased()):\(pairSymbol.uppercased())"
            } else {
                return "t\(symbol.uppercased())\(pairSymbol.uppercased())"
            }
        }

        return tickersRepository.fetchTickersList(symbols: currencyPairs)
    }
}
