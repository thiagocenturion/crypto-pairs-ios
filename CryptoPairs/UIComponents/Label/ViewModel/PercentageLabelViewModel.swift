//
//  PercentageLabelViewModel.swift
//  CryptoPairs
//
//  Created by Thiago Centurion on 12/06/2022.
//

import UIKit

public struct PercentageLabelViewModel: LabelViewModel {

    // MARK: Properties

    public var text: String? {
        let value = String(format: "%.2f%%", percent)
        return isPositive ? "+" + value : value
    }

    public var font: UIFont { Typography.caption }

    public var textColor: UIColor {
        isPositive ? ColorPalette.positive : ColorPalette.negative
    }

    private let percent: Float
    private var isPositive: Bool { percent >= 0 }

    // MARK: - Initialization

    public init(percent: Float) {
        self.percent = percent
    }
}
