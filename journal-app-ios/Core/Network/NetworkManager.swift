//
//  NetworkManager.swift
//  journal-app-ios
//
//  Created by Sushant Hande on 27/07/26.
//

import Foundation
import os

protocol NetworkServiceProtocol {
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T
}


final class NetworkManager: NetworkServiceProtocol {
    private let session: URLSession
    let networkLogger = Logger(subsystem: "dev.sushanthande.journalapp", category: "Networking")

    let customDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        // "y" = Year, "M" = Month, "d" = Day
        // "H" = Hour (24-hour), "m" = Minute, "s" = Second, "SSS" = Fractional seconds
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SS"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0) // Adjust if your server uses a specific timezone
        return formatter
    }()

    
    // Injecting URLSession allows you to inject a mock session for unit tests later
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        // 1. Build the network request
        let urlRequest = try endpoint.asURLRequest()
        
        logRequest(urlRequest)
        
        // 2. Perform the networking operation natively using modern async/await
        let (data, response) = try await session.data(for: urlRequest)
        
        logResponse(response, data: data, error: nil)
        
        // 3. Ensure the response object is standard HTTP and falls under a 2xx success block
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw APIError.badStatus(httpResponse.statusCode)
        }
        
        // 4. Decode server data into your desired swift Decodable type
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(customDateFormatter)
            
            // Response decoding logic for String type, which is not a JSON object but a raw string
            if T.self == String.self {
                // Try JSON string first: e.g., "abc123"
                if let jsonString = try? decoder.decode(String.self, from: data),
                   let result = jsonString as? T {
                    return result
                }
                // Fallback: treat body as plain text
                if let plain = String(data: data, encoding: .utf8),
                   let result = plain as? T {
                    return result
                }
                throw APIError.decodingError
            }
            
            // For other Decodable types, use standard decoding
            decoder.keyDecodingStrategy = .convertFromSnakeCase // Optional: maps snake_case to camelCase automatically
            return try decoder.decode(T.self, from: data)
        } catch {
            throw APIError.decodingError
        }
    }
    
    func logRequest(_ request: URLRequest) {
        let url = request.url?.absoluteString ?? "Unknown URL"
        let method = request.httpMethod ?? "GET"
        
        // Format and protect Headers
        var headerString = ""
        if let headers = request.allHTTPHeaderFields {
            for (key, value) in headers {
                // Mask sensitive tokens like Bearer auth keys
                let isSensitive = key.lowercased().contains("auth") || key.lowercased().contains("cookie")
                let safeValue = isSensitive ? "********" : value
                headerString += "\n  \(key): \(safeValue)"
            }
        } else {
            headerString = " None"
        }
        
        // Format HTTP Body
        var bodyString = "None"
        if let bodyData = request.httpBody {
            if let jsonString = String(data: bodyData, encoding: .utf8) {
                bodyString = jsonString
            } else {
                bodyString = "\(bodyData.count) bytes"
            }
        }
        
        // 4. Output structured multi-line log
        networkLogger.debug("""
        🌐 [Network Request]
        URL: \(url, privacy: .public)
        Method: \(method, privacy: .public)
        Headers:\(headerString, privacy: .public)
        Body: \(bodyString, privacy: .public)
        """)
    }
    
    func logResponse(_ response: URLResponse?, data: Data?, error: Error?) {
        // 1. Handle Network Errors immediately
        if let error = error {
            networkLogger.error("❌ [Network Error]: \(error.localizedDescription, privacy: .public)")
            return
        }
        
        // 2. Cast response to HTTPURLResponse to access HTTP-specific fields
        guard let httpResponse = response as? HTTPURLResponse else {
            networkLogger.warning("⚠️ [Network Response]: Received non-HTTP response")
            return
        }
        
        // 3. Format and sanitize Response Headers
        var headerString = ""
        for (key, value) in httpResponse.allHeaderFields {
            let isSensitive = key.description.lowercased().contains("set-cookie")
            let safeValue = isSensitive ? "********" : "\(value)"
            headerString += "\n  \(key): \(safeValue)"
        }
        if headerString.isEmpty { headerString = " None" }
        
        // 4. Format and Pretty-Print the JSON Body
        var bodyString = "Empty"
        if let data = data, !data.isEmpty {
            if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
               let prettyData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted),
               let prettyString = String(data: prettyData, encoding: .utf8) {
                bodyString = prettyString
            } else if let fallbackString = String(data: data, encoding: .utf8) {
                bodyString = fallbackString // Fallback if data is raw text/HTML instead of JSON
            } else {
                bodyString = "\(data.count) bytes"
            }
        }
        
        // Determine status emoji for quick scanning
        let statusCode = httpResponse.statusCode
        let statusEmoji = (200...299).contains(statusCode) ? "✅" : "🛑"
        
        // 5. Output structured multi-line log
        networkLogger.debug("""
        \(statusEmoji) [Network Response]
        URL: \(httpResponse.url?.absoluteString ?? "Unknown URL", privacy: .public)
        Status Code: \(statusCode, privacy: .public)
        Headers:\(headerString, privacy: .public)
        Body: 
        \(bodyString, privacy: .public)
        """)
    }
}
