//
//  AuthRepositoryImpl.swift
//  journal-app-ios
//
//  Created by Sushant Hande on 27/07/26.
//

import Foundation

class AuthRepositoryImpl: AuthRepository {
    
    private let networkServiceProtocol: NetworkServiceProtocol
    
    init(networkServiceProtocol: NetworkServiceProtocol) {
        self.networkServiceProtocol = networkServiceProtocol
    }
    
    func signUp(email: String, password: String) async throws -> Bool {
        return try await networkServiceProtocol.request(AuthEndPoint.signUp(email: email, password: password))
    }
    
    func login(email: String, password: String) async throws -> String {
        return try await networkServiceProtocol.request(AuthEndPoint.login(email: email, password: password))
    }

}
