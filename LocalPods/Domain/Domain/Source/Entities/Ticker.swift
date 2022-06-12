//
//  Ticker.swift
//  
//
//  Created by Thiago Centurion on 10/06/2022.
//

import Foundation

public struct Ticker: Decodable, Equatable {

    // MARK: Properties

    /// Symbol of the requested ticker data (aka `"tBTCUSD`)
    public let symbol: String

    /// Price of last highest bid
    public let bid: Float

    /// Sum of the 25 highest bid sizes
    public let bidSize: Float

     /// Price of last lowest ask
    public let ask: Float

     /// Sum of the 25 lowest ask sizes
    public let askSize: Float

     /// Last changed price since yesterday
    public let dailyChange: Float

     /// Relative price change since yesterday (multiply by 100 for percentage change)
    public let dailyChangeRelative: Float

     /// LTP - Last Traded Price
    public let lastPrice: Float

     /// Daily volume
    public let volume: Float

     /// Daily high
    public let high: Float

     /// Daily low
    public let low: Float

    // MARK: - Initialization

    public init(symbol: String,
                bid: Float,
                bidSize: Float,
                ask: Float,
                askSize: Float,
                dailyChange: Float,
                dailyChangeRelative: Float,
                lastPrice: Float,
                volume: Float,
                high: Float,
                low: Float) {

        self.symbol = symbol
        self.bid = bid
        self.bidSize = bidSize
        self.ask = ask
        self.askSize = askSize
        self.dailyChange = dailyChange
        self.dailyChangeRelative = dailyChangeRelative
        self.lastPrice = lastPrice
        self.volume = volume
        self.high = high
        self.low = low
    }

    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()

        symbol = try container.decode(String.self)
        bid = try container.decode(Float.self)
        bidSize = try container.decode(Float.self)
        ask = try container.decode(Float.self)
        askSize = try container.decode(Float.self)
        dailyChange = try container.decode(Float.self)
        dailyChangeRelative = try container.decode(Float.self)
        lastPrice = try container.decode(Float.self)
        volume = try container.decode(Float.self)
        high = try container.decode(Float.self)
        low = try container.decode(Float.self)
    }
}
