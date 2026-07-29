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

    // User input properties
    var email: String = ""
    var password: String = ""
    var showValidationError: Bool = false

    private let authRepository: AuthRepository

    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }

    func validateInput() -> Bool {
        guard !email.isEmpty && !password.isEmpty else {
            showValidationError = true
            return false
        }
        showValidationError = !email.contains("@") || !(password.count >= 6)
        return email.contains("@") && password.count >= 6
    }

    func signUp(email: String, password: String) async -> Bool {
        isLoading = true
        error = nil
        hasError = false
        do {
            let result = try await authRepository.signUp(
                email: email,
                password: password
            )
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
            let result = try await authRepository.login(
                email: email,
                password: password
            )
            isLoading = false
            return result
        } catch {
            self.error = error.localizedDescription
            isLoading = false
            hasError = true
            return ""
        }
    }
    
    func clear() {
        email = ""
        password = ""
        error = nil
        hasError = false
        showValidationError = false
    }

}
