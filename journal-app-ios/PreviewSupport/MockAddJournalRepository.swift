//
//  MockAddJournalRepository.swift
//  journal-app-ios
//
//  Created by Sushant Hande on 30/07/26.
//

#if DEBUG
import Foundation

class MockAddJournalRepository: AddJournalRepository {
    
    func addJournalEntry(title: String, content: String, userName: String, authToken: String) async throws -> JournalEntry? {
        return nil
    }
    
}
#endif // DEBUG
