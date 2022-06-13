//
//  TickerCellViewModel.swift
//  CryptoPairs
//
//  Created by Thiago Centurion on 13/06/2022.
//

import Foundation

struct TickerCellViewModel {

    // MARK: Properties

    let title: DefaultLabelViewModel
    let subtitle: DefaultLabelViewModel
    let price: CurrencyLabelViewModel
    let percentage: PercentageLabelViewModel
    let iconURL: URL?

    // MARK: - Initialization

    init(title: String, subtitle: String, locale: Locale, price: Float, percent: Float, iconURL: URL?) {
        self.title = .init(text: title, type: .heading)
        self.subtitle = .init(text: subtitle, type: .body)
        self.price = .init(locale: locale, value: price)
        self.percentage = .init(percent: percent)
        self.iconURL = iconURL
    }
}
