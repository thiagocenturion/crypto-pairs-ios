//
//  TickersRepositoryStub.swift
//  CryptoPairsSnapshotTests
//
//  Created by Thiago Centurion on 13/06/2022.
//

import Foundation
import RxSwift
import RxCocoa
import Domain

final class TickersRepositoryStub {

    // MARK: Stub
    var result: Single<[Ticker]>

    // MARK: Spy
    var calls: [Call] = []

    // MARK: - Initialization

    init(result: Single<[Ticker]> = .never()) {
        self.result = result
    }
}

// MARK: - Spy

extension TickersRepositoryStub {

    enum Call {
        case fetchTickersList(symbols: [String])
    }
}

// MARK: - TickersRepository

extension TickersRepositoryStub: TickersRepository {

    func fetchTickersList(symbols: [String]) -> Single<[Ticker]> {
        calls.append(.fetchTickersList(symbols: symbols))
        return result
    }
}
