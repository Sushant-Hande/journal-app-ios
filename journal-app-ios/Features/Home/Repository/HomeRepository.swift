//
//  HomeRepository.swift
//  journal-app-ios
//
//  Created by Sushant Hande on 29/07/26.
//

import Foundation

protocol HomeRepository {
    func fetchJournalEntries(userName: String, authToken: String) async throws -> [JournalEntry]
}
