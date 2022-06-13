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

final public class TickerUseCase: TickerUseCaseProtocol {

    // MARK: Properties
    private let tickersRepository: TickersRepository

    // MARK: - Initialiation
    public init(tickersRepository: TickersRepository) {

        self.tickersRepository = tickersRepository
    }

    // MARK: - TickerUseCaseProtocol
    public func tickers(currencySymbols: [String], pairWith pairSymbol: String) -> Single<[Ticker]> {

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
