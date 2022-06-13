//
//  CurrencyLabelViewModel.swift
//  CryptoPairs
//
//  Created by Thiago Centurion on 12/06/2022.
//

import UIKit

public struct CurrencyLabelViewModel: LabelViewModel {

    // MARK: Properties

    private let value: Float
    private let numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.usesGroupingSeparator = true
        return numberFormatter
    }()

    public let font: UIFont
    public let textColor: UIColor

    public var text: String? {
        numberFormatter.string(from: value as NSNumber)
    }

    // MARK: - Initialization

    public init(locale: Locale, value: Float) {
        self.value = value
        self.font = Typography.caption
        self.textColor = ColorPalette.label

        numberFormatter.locale = locale
    }
}
