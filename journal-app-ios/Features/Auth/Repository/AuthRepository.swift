//
//  AuthRepository.swift
//  journal-app-ios
//
//  Created by Sushant Hande on 27/07/26.
//

import Foundation

protocol AuthRepository {
    func signUp(email: String, password: String) async throws -> Bool
    func login(email: String, password: String) async throws -> String
}
