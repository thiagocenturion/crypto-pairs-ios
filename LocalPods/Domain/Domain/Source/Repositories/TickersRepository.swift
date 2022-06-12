//
//  TickersRepository.swift
//  Domain
//
//  Created by Thiago Centurion on 11/06/2022.
//

import Foundation
import RxSwift

public protocol TickersRepository {

    func fetchTickersList(symbols: [String]) -> Single<[Ticker]>
}
