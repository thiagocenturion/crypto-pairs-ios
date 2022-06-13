//
//  DefaultLabelViewModel.swift
//  CryptoPairs
//
//  Created by Thiago Centurion on 12/06/2022.
//

import UIKit
import Branding

public struct DefaultLabelViewModel: LabelViewModel, Equatable {

    // MARK: Properties

    public let text: String?

    public var font: UIFont {
        switch type {
        case .heading:
            return Typography.h2
        case .body:
            return Typography.regular
        }
    }

    public var textColor: UIColor {
        if let overrideTextColor = overrideTextColor {
            return overrideTextColor
        } else {
            switch type {
            case .heading:
                return ColorPalette.label
            case .body:
                return ColorPalette.tertiaryLabel
            }
        }
    }

    private let type: DefaultLabelType
    private let overrideTextColor: UIColor?

    // MARK: - Initialization

    public init(text: String?, type: DefaultLabelType, overrideTextColor: UIColor? = nil) {
        self.text = text
        self.type = type
        self.overrideTextColor = overrideTextColor
    }
}
