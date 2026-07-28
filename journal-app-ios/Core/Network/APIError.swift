//
//  APIError.swift
//  journal-app-ios
//
//  Created by Sushant Hande on 27/07/26.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case badStatus(Int)
    case decodingError
    case unknownError
}
