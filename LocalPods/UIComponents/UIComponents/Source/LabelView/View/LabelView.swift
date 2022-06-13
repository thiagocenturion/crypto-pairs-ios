//
//  Label.swift
//  CryptoPairs
//
//  Created by Thiago Centurion on 12/06/2022.
//

import UIKit

public protocol LabelViewModel {

    var text: String? { get }
    var font: UIFont { get }
    var textColor: UIColor { get }
}

public final class LabelView: UILabel {

    // MARK: - Initialization

    public override init(frame: CGRect) {
        super.init(frame: frame)
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - View

public extension LabelView {

    func configure(with viewModel: LabelViewModel) {
        text = viewModel.text
        font = viewModel.font
        textColor = viewModel.textColor
    }
}
