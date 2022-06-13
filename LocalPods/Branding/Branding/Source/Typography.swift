//
//  Typography.swift
//  CryptoPairs
//
//  Created by Thiago Centurion on 12/06/2022.
//

import UIKit

/// Typography enum to easy handle all the system branding just by changing it from computed properties
public enum Typography {

    public static var h2: UIFont { return UIFont.boldSystemFont(ofSize: 18) }
    public static var caption: UIFont { return UIFont.boldSystemFont(ofSize: 14) }
    public static var regular: UIFont { return UIFont.systemFont(ofSize: 14) }
}
