//
//  TickerCell.swift
//  CryptoPairs
//
//  Created by Thiago Centurion on 12/06/2022.
//

import UIKit
import Kingfisher

final class TickerCell: UITableViewCell {

    // MARK: Constants

    enum Constants {
        static let placeholderIcon = "placeholder_icon"
        static let cornerRadius: CGFloat = 10

        enum Sizes {
            static let iconImage: CGSize = CGSize(width: 48, height: 48)
        }

        enum Spacing {
            static let horizontal: CGFloat = .zero
            static let vertical: CGFloat = 12
            static let padding: CGFloat = 12
        }

        enum Insets {
            static let horizontalStackView = UIEdgeInsets(top: Constants.Spacing.vertical / 2,
                                                          left: Constants.Spacing.horizontal,
                                                          bottom: -Constants.Spacing.vertical / 2,
                                                          right: -Constants.Spacing.horizontal)

            static let padding = UIEdgeInsets(top: Constants.Spacing.padding,
                                              left: Constants.Spacing.padding,
                                              bottom: Constants.Spacing.padding,
                                              right: Constants.Spacing.padding)
        }
    }

    // MARK: Properties

    private let titleLabel: LabelView = {
        let titleLabel = LabelView()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 0
        return titleLabel
    }()

    private let subtitleLabel: LabelView = {
        let subtitleLabel = LabelView()
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        return subtitleLabel
    }()

    private let priceLabel: LabelView = {
        let priceLabel = LabelView()
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        return priceLabel
    }()

    private let percentageLabel: LabelView = {
        let percentageLabel = LabelView()
        percentageLabel.translatesAutoresizingMaskIntoConstraints = false
        return percentageLabel
    }()

    private let iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.contentMode = .scaleAspectFit
        return iconImageView
    }()

    private let titleStackView: UIStackView = {
        let titleStackView = UIStackView()
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        titleStackView.axis = .vertical
        titleStackView.spacing = Constants.Spacing.padding
        titleStackView.alignment = .leading
        return titleStackView
    }()

    private let priceStackView: UIStackView = {
        let priceStackView = UIStackView()
        priceStackView.translatesAutoresizingMaskIntoConstraints = false
        priceStackView.axis = .vertical
        priceStackView.spacing = Constants.Spacing.padding
        priceStackView.alignment = .trailing
        return priceStackView
    }()

    private let horizontalStackView: UIStackView = {
        let horizontalStackView = UIStackView()
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = Constants.Spacing.padding
        horizontalStackView.alignment = .center
        horizontalStackView.layoutMargins = Constants.Insets.padding
        horizontalStackView.isLayoutMarginsRelativeArrangement = true
        return horizontalStackView
    }()

    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        configureView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Configure

extension TickerCell {

    func configure(with viewModel: TickerCellViewModel) {
        titleLabel.configure(with: viewModel.title)
        subtitleLabel.configure(with: viewModel.subtitle)
        priceLabel.configure(with: viewModel.price)
        percentageLabel.configure(with: viewModel.percentage)

        iconImageView.kf.setImage(with: viewModel.iconURL, placeholder: UIImage(named: Constants.placeholderIcon))
    }
}

// MARK: - Layout View

private extension TickerCell {

    func configureView() {
        selectionStyle = .none
        backgroundColor = .clear

        horizontalStackView.layer.cornerRadius = Constants.cornerRadius
        horizontalStackView.layer.masksToBounds = true
        horizontalStackView.backgroundColor = ColorPalette.background

        addSubviews()
        configureConstraints()
    }

    func addSubviews() {
        // Title and Subtitle stack viewl
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(subtitleLabel)

        // Price and percentage stack view
        priceStackView.addArrangedSubview(priceLabel)
        priceStackView.addArrangedSubview(percentageLabel)

        // Adding horizontal stack view
        horizontalStackView.addArrangedSubview(iconImageView)
        horizontalStackView.addArrangedSubview(titleStackView)
        horizontalStackView.addArrangedSubview(priceStackView)
        contentView.addSubview(horizontalStackView)
    }

    func configureConstraints() {
        iconImageView.constrain(size: Constants.Sizes.iconImage)
        titleStackView.constrain(width: contentView.bounds.width / 2)
        horizontalStackView.edge(insets: Constants.Insets.horizontalStackView, to: contentView)
    }
}
