//
//  HomeRepositoryImpl.swift
//  journal-app-ios
//
//  Created by Sushant Hande on 29/07/26.
//

import Foundation

class HomeRepositoryImpl: HomeRepository {
    
    private let networkServiceProtocol: NetworkServiceProtocol

    init(networkServiceProtocol: NetworkServiceProtocol) {
        self.networkServiceProtocol = networkServiceProtocol
    }
    
    func fetchJournalEntries(userName: String, authToken: String) async throws -> [JournalEntry] {
        return try await networkServiceProtocol.request(JournalEndPoint.getJournals(userName: userName, authToken: authToken))
    }
    
    func addJournalEntry(journalEntry: JournalEntry) async throws {
        throw NSError(domain: "Not implemented", code: 0, userInfo: nil)
    }
    
    
    
}
