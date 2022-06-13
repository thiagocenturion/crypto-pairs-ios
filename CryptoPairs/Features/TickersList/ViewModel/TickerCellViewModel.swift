//
//  TickerCellViewModel.swift
//  CryptoPairs
//
//  Created by Thiago Centurion on 13/06/2022.
//

import Foundation
import UIComponents
import Domain

struct TickerCellViewModel: Equatable {

    // MARK: Properties

    let title: DefaultLabelViewModel
    let subtitle: DefaultLabelViewModel
    let price: CurrencyLabelViewModel
    let percentage: PercentageLabelViewModel
    let iconURL: URL?

    // MARK: - Initialization

    init(ticker: Ticker, cryptoCurrency: CryptoCurrency, locale: Locale) {
        self.title = .init(text: cryptoCurrency.name, type: .heading)
        self.subtitle = .init(text: cryptoCurrency.symbol, type: .body)
        self.price = .init(locale: locale, value: ticker.lastPrice)
        self.percentage = .init(percent: ticker.dailyChangeRelative * 100)
        self.iconURL = cryptoCurrency.icon
    }
}
