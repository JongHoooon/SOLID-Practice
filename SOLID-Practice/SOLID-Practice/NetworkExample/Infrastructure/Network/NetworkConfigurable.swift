//
//  NetworkConfigurable.swift
//  SOLID-Practice
//
//  Created by JongHoon on 2023/03/19.
//

import Foundation

public protocol NetworkConfigurable {
    var baseURL: URL { get }
    var headers: [String: String] { get }
    var queryParameters: [String: String] { get }
}

public struct ApiDataNetworkConfig: NetworkConfigurable {
    public var baseURL: URL
    public var headers: [String : String]
    public var queryParameters: [String : String]
    
    public init(
        baseURL: URL,
        headers: [String: String] = [:],
        queryParameters: [String: String] = [:]
    ) {
        self.baseURL = baseURL
        self.headers = headers
        self.queryParameters = queryParameters
    }
}
