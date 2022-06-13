//
//  Endpoint.swift
//  Networking
//
//  Created by Thiago Centurion on 11/06/2022.
//

import Foundation
import Moya

public enum Endpoint {
    case tickers(symbols: [String])
}

// MARK: - TargetType

extension Endpoint: TargetType {
    public var baseURL: URL { URL(string: "https://api-pub.bitfinex.com/v2")! }

    public var path: String {
        switch self {
        case .tickers:
            return "tickers"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .tickers:
            return .get
        }
    }

    public var task: Task {
        switch self {
        case .tickers(let symbols):
            let parameters = symbols.joined(separator: ",")
            return .requestParameters(parameters: ["symbols": parameters], encoding: URLEncoding.queryString)
        }
    }

    public var headers: [String : String]? { ["Content-type": "application/json"] }
}
