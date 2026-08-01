//
//  AddJournalRepositoryImpl.swift
//  journal-app-ios
//
//  Created by Sushant Hande on 30/07/26.
//

import Foundation

class AddJournalRepositoryImpl: AddJournalRepository {
    
    private let networkServiceProtocol: NetworkServiceProtocol

    init(networkServiceProtocol: NetworkServiceProtocol) {
        self.networkServiceProtocol = networkServiceProtocol
    }

    func addJournalEntry(title: String, content: String, userName: String, authToken: String) async throws -> JournalEntry? {
        return try await networkServiceProtocol.request(JournalEndPoint.addJournal(title: title, content: content, userName: userName, authToken: authToken))
    }
    
}
