//
//  NetworkingService.swift
//  Networking
//
//  Created by Thiago Centurion on 11/06/2022.
//

import Foundation
import RxSwift
import Moya

public protocol NetworkingServiceProtocol {
    func request<T: Decodable>(endpoint: Endpoint) -> Single<T>
}

public struct NetworkingService: NetworkingServiceProtocol {

    // MARK: Properties
    private let provider: MoyaProvider<Endpoint>

    // MARK: - Initialization

    public init(provider: MoyaProvider<Endpoint> = MoyaProvider<Endpoint>()) {
        self.provider = provider
    }
}

// MARK: - NetworkingServiceProtocol
extension NetworkingService {

    public func request<T: Decodable>(endpoint: Endpoint) -> Single<T> {
        self.provider.rx.request(endpoint).flatMap { response in
            do {
                let model = try response.map(T.self)
                return .just(model)
            } catch {
                return .error(error)
            }
        }
    }
}
