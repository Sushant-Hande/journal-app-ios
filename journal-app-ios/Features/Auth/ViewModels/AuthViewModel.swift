//
//  AuthViewModel.swift
//  journal-app-ios
//
//  Created by Sushant Hande on 27/07/26.
//

import Foundation

@Observable
class AuthViewModel {
    var isLoading: Bool = false
    var error: String?
    var hasError = false
    
    private let authRepository: AuthRepository
    
    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
    
    func signUp(email: String, password: String) async -> Bool {
        isLoading = true
        error = nil
        hasError = false
        do {
          let result = try await authRepository.signUp(email: email, password: password)
          isLoading = false
          return result
        } catch {
            self.error = error.localizedDescription
            isLoading = false
            hasError = true
            return false
        }
    }
    
    func login(email: String, password: String) async -> String {
        isLoading = true
        error = nil
        hasError = false
        do {
          let result = try await authRepository.login(email: email, password: password)
          isLoading = false
          return result
        } catch {
            self.error = error.localizedDescription
            isLoading = false
            hasError = true
            return ""
        }
    }
    
}
