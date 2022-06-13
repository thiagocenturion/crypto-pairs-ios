//
//  ColorPalette.swift
//  CryptoPairs
//
//  Created by Thiago Centurion on 12/06/2022.
//

import UIKit

/// ColorPallete to easy handle all the system branding just by changing it from computed properties
public enum ColorPalette {

    public static var background: UIColor { return UIColor.systemBackground }
    public static var tableViewBackground: UIColor { return UIColor.systemGroupedBackground }
    public static var fill: UIColor { return UIColor.systemFill }
    public static var label: UIColor { return UIColor.label }
    public static var inversedLabel: UIColor { return UIColor.white }
    public static var tertiaryLabel: UIColor { return UIColor.tertiaryLabel }
    public static var positive: UIColor { return UIColor.systemGreen }
    public static var negative: UIColor { return UIColor.systemRed }
}
