//
//  PercentageLabelViewModel.swift
//  CryptoPairs
//
//  Created by Thiago Centurion on 12/06/2022.
//

import UIKit
import Branding

public struct PercentageLabelViewModel: LabelViewModel, Equatable {

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
