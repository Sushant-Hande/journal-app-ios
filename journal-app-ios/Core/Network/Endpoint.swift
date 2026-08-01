//
//  Endpoint.swift
//  journal-app-ios
//
//  Created by Sushant Hande on 27/07/26.
//

import Foundation

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var body: Data? { get }
}

// Provide defaults so every property isn't required for simple requests
extension Endpoint {
    var baseURL: String { "https://journalapp-s2aw.onrender.com" }
    var headers: [String: String]? { ["Content-Type": "application/json"] }
    var body: Data? { nil }
    
    // Assembles components securely into a single URLRequest object
    func asURLRequest() throws -> URLRequest {
        guard let url = URL(string: baseURL + path) else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        // Start with defaults
        var finalHeaders: [String: String] = ["Content-Type": "application/json"]

        // Merge in endpoint-specific headers (overrides defaults if same keys)
        if let endpointHeaders = headers {
            for (k, v) in endpointHeaders {
                finalHeaders[k] = v
            }
        }
        
        request.allHTTPHeaderFields = finalHeaders
        request.httpBody = body
        return request
    }
}
