//
//  TickersRepositoryStub.swift
//  Domain-Unit-Tests
//
//  Created by Thiago Centurion on 11/06/2022.
//

import Foundation
import RxSwift

@testable import Domain

struct TickersRepositoryStub: TickersRepository {

    var result: Single<[Ticker]>

    func fetchTickersList(symbols: [String]) -> Single<[Ticker]> { result }
}
