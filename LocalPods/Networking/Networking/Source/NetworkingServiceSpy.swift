//
//  NetworkingServiceSpy.swift
//  Networking
//
//  Created by Thiago Centurion on 12/06/2022.
//

import Foundation
import RxSwift

final public class NetworkingServiceSpy: NetworkingServiceProtocol {

    public struct Call {
        public let endpoint: Endpoint
    }

    public var calls = [Call]()

    public init() {}

    public func request<T>(endpoint: Endpoint) -> Single<T> where T : Decodable {
        calls.append(.init(endpoint: endpoint))
        return .never()
    }
}
