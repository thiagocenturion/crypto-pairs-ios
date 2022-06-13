//
//  ErrorToastView.swift
//  CryptoPairs
//
//  Created by Thiago Centurion on 13/06/2022.
//

import UIKit
import RxSwift
import RxCocoa

public final class ErrorToastView: UIView {

    // MARK: Constants

    enum Constants {
        enum Spacing {
            static let margin: CGFloat = 24
        }

        enum Insets {
            static let margin = UIEdgeInsets(top: Constants.Spacing.margin,
                                             left: Constants.Spacing.margin,
                                             bottom: -Constants.Spacing.margin,
                                             right: -Constants.Spacing.margin)
        }
    }

    // MARK: Properties

    private let messageLabel: LabelView = {
        let messageLabel = LabelView()
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.numberOfLines = 0
        return messageLabel
    }()

    // MARK: - Initialization

    public override init(frame: CGRect) {
        super.init(frame: frame)

        configureView()
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Public Methods

public extension ErrorToastView {

    func configure(with viewModel: ErrorToastViewModel) {
        messageLabel.configure(with: viewModel.message)
    }
}

// MARK: - Private Methods

private extension ErrorToastView {

    func configureView() {
        backgroundColor = ColorPalette.negative
        isUserInteractionEnabled = false

        addSubviews()
        configureConstraints()
    }

    func addSubviews() {
        addSubview(messageLabel)
    }

    func configureConstraints() {
        messageLabel.edge(insets: Constants.Insets.margin, to: self)
    }
}
