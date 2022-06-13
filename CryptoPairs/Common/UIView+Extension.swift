//
//  UIView+Extension.swift
//  CryptoPairs
//
//  Created by Thiago Centurion on 12/06/2022.
//

import UIKit

extension UIView {

    /// Sizes the view based on `CGSize` argument. View should not be translates autoresizing mask into constraints.
    func constrain(size: CGSize) {
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: size.width),
            self.heightAnchor.constraint(equalToConstant: size.height)
        ])
    }

    /// Sizes the view based on `width` and/or `height` optional arguments. View should not be translates autoresizing mask into constraints.
    func constrain(width: CGFloat? = nil, height: CGFloat? = nil) {

        if let width = width {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }

        if let height = height {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }

    /// Edges the view based on `UIEdgeInsets` argument to a related `view`. View should not be translates autoresizing mask into constraints.
    func edge(insets: UIEdgeInsets = .zero, to view: UIView?, ignoringBottomSafeArea: Bool = false) {

        guard let view = view else { return }

        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: insets.top),
            self.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: insets.left),
            self.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: insets.right),
            self.bottomAnchor.constraint(equalTo: ignoringBottomSafeArea ? view.bottomAnchor : view.safeAreaLayoutGuide.bottomAnchor, constant: insets.bottom)
        ])
    }

    func edge(top: CGFloat? = nil, left: CGFloat? = nil, bottom: CGFloat? = nil, right: CGFloat? = nil, to view: UIView?) {

        guard let view = view else { return }

        if let top = top {
            self.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: top).isActive = true
        }

        if let left = left {
            self.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: left).isActive = true
        }

        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: bottom).isActive = true
        }

        if let right = right {
            self.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: right).isActive = true
        }
    }
}
