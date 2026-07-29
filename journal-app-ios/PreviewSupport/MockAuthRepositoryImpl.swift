//
//  MockAuthRepositoryImpl.swift
//  journal-app-ios
//
//  Created by Sushant Hande on 29/07/26.
//

#if DEBUG
import Foundation

final class MockAuthRepository: AuthRepository {
    func signUp(email: String, password: String) async throws -> Bool {
        try await Task.sleep(nanoseconds: 300_000_000)
        return true
    }

    func login(email: String, password: String) async throws -> String {
        try await Task.sleep(nanoseconds: 300_000_000)
        return "mock-token-123"
    }
}
#endif // DEBUG
