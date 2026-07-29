//
//  MockHomeRepositoryImpl.swift
//  journal-app-ios
//
//  Created by Sushant Hande on 29/07/26.
//

#if DEBUG
import Foundation

final class MockHomeRepositoryImpl: HomeRepository {
    func fetchJournalEntries(userName: String, authToken: String) async throws -> [JournalEntry] {
        return [JournalEntry(title: "Mock Entry 1", content: "This is a mock journal entry.", date: Date()),]
    }
    
    func addJournalEntry(journalEntry: JournalEntry) async throws {
        
    }
    
    
}
#endif // DEBUG
