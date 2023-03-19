//
//  Endpoint.swift
//  SOLID-Practice
//
//  Created by JongHoon on 2023/03/19.
//

import Foundation

public protocol Requestable {
    var path: String { get }
    var isFullPath: Bool { get }
    var method: HTTPMethodType { get }
    var headerParameters: [String: String] { get }
    var queryParametersEncodable: Encodable? { get }
    var queryParameters: [String: Any] { get }
    var bodyParametersEncodable: Encodable? { get }
    var bodyParameters: [String: Any] { get }
    var bodyEncoding: BodyEncoding { get }
    
    func urlRequest(with networkConfig: NetworkConfigurable) throws -> URLRequest
}

extension Requestable {
    
    func url(with config: NetworkConfigurable) throws -> URL {
        
        let baseURL = config.baseURL.absoluteString.last != "/" ?
            config.baseURL.absoluteString + "/" : config.baseURL.absoluteString
        let endpoint = isFullPath ? path : baseURL.appending(path)
        
        guard var urlComponents: URLComponents = URLComponents(string: endpoint) else {
            throw RequestGenerationError.components
        }
        var urlQueryItemts: [URLQueryItem] = []
    
        let queryParameters = try queryParametersEncodable?.toDictionary() ?? self.queryParameters
        queryParameters.forEach {
            urlQueryItemts.append(URLQueryItem(name: $0.key, value: "\($0.value)"))
        }
        config.queryParameters.forEach {
            urlQueryItemts.append(URLQueryItem(name: $0.key, value: $0.value))
        }
        urlComponents.queryItems = !urlQueryItemts.isEmpty ? urlQueryItemts : nil
        guard let url = urlComponents.url else { throw RequestGenerationError.components }
        return url
    }
    
    public func urlReqeust(with config: NetworkConfigurable) throws -> URLRequest {
        
        let url = try self.url(with: config)
        var urlRequest = URLRequest(url: url)
        var allHeaders: [String: String] = config.headers
        headerParameters.forEach { allHeaders.updateValue($1, forKey: $0) }
        
        let bodyParamaters = try bodyParametersEncodable?.toDictionary() ?? self.bodyParameters
        if !bodyParamaters.isEmpty {
            urlRequest.httpBody = encodeBody(
                bodyParameters: bodyParamaters,
                bodyEncoding: bodyEncoding
            )
        }
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = allHeaders
        return urlRequest
    }
    
    private func encodeBody(bodyParameters: [String: Any], bodyEncoding: BodyEncoding) -> Data? {
        switch bodyEncoding {
        case .jsonSerializationData:
            return try? JSONSerialization.data(withJSONObject: bodyParameters)
        case .stringEncodingAscii:
            return bodyParameters.queryString.data(
                using: String.Encoding.ascii,
                allowLossyConversion: true
            )
        }
    }
}

/// Dictionary형을 queryString 형태로 변경
private extension Dictionary {
    var queryString: String {
        return self.map { "\($0.key)=\($0.value)" }
            .joined(separator: "&")
            .addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) ?? ""
    }
}


/// Encodable인 struct형을 딕셔너리 형태로 변형
private extension Encodable {
    func toDictionary() throws -> [String: Any]? {
        let data = try JSONEncoder().encode(self)
        let jsonData = try JSONSerialization.jsonObject(with: data)
        return jsonData as? [String: Any]
    }
}

public enum HTTPMethodType: String {
    case get    = "GET"
    case head   = "HEAD"
    case post   = "POST"
    case put    = "PUT"
    case patch  = "PATCH"
    case delete = "DELETE"
}

public enum BodyEncoding {
    case jsonSerializationData
    case stringEncodingAscii
}

enum RequestGenerationError: Error {
    case components
}
