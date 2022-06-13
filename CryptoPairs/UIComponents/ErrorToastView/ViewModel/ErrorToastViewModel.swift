//
//  ErrorToastViewModel.swift
//  CryptoPairs
//
//  Created by Thiago Centurion on 13/06/2022.
//

import Foundation

public struct ErrorToastViewModel {

    // MARK: Properties

    public let message: DefaultLabelViewModel

    // MARK: - Initialization

    public init(message: String) {
        self.message = .init(text: message, type: .body, overrideTextColor: ColorPalette.inversedLabel)
    }
}
