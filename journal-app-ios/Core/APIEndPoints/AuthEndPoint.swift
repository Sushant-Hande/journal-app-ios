//
//  UserEndPoint.swift
//  journal-app-ios
//
//  Created by Sushant Hande on 28/07/26.
//

import Foundation

enum AuthEndPoint: Endpoint {
    case login(email: String, password: String)
    case signUp(email: String, password: String)
    
    var path: String {
        switch self {
        case .login: return "/public/login"
        case .signUp: return "/public/signUp"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .login, .signUp: return .post
        }
    }
    
    var body: Data? {
        switch self {
        case .login(let email, let password):
            return try? JSONEncoder().encode(["userName": email, "password": password])
            
        case .signUp(let email, let password):
            return try? JSONEncoder().encode(["userName": email, "password": password])
        }
    }
}
