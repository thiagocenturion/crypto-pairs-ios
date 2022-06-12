//
//  CryptoCurrency.swift
//  Domain
//
//  Created by Thiago Centurion on 11/06/2022.
//

import Foundation

public struct CryptoCurrency: Decodable, Equatable {

    // MARK: Properties

    /// Symbol of the Crypto currency data (aka `BTC`)
    public let symbol: String

    /// Name of the Crypto currency (aka `Bitcoin`)
    public let name: String

    /// URL for the icon of the Crypto currency
    public let icon: URL

    // MARK: - Initialization

    public init(symbol: String, name: String, icon: URL) {

        self.symbol = symbol
        self.name = name
        self.icon = icon
    }
}
