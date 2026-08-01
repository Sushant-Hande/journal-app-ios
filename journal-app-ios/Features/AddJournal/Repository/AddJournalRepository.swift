//
//  AddJournalRepository.swift
//  journal-app-ios
//
//  Created by Sushant Hande on 30/07/26.
//

import Foundation

protocol AddJournalRepository {
    func addJournalEntry(title: String, content: String, userName: String, authToken: String) async throws -> JournalEntry?
}
