//
//  HomeViewModel.swift
//  journal-app-ios
//
//  Created by Sushant Hande on 29/07/26.
//

import Foundation

@Observable
class HomeViewModel {
    var isLoading: Bool = false
    var error: String?
    var hasError = false
    var journalEntries: [JournalEntry] = []
    var hasLoaded = false

    private let homeRepository: HomeRepository
    
    init(homeRepository: HomeRepository) {
        self.homeRepository = homeRepository
    }
    
    func fetchJournalEntriesIfNeeded(userName: String, authToken: String) async {
        guard !hasLoaded else { return }
        isLoading = true
        do {
            journalEntries = try await homeRepository.fetchJournalEntries(userName: userName, authToken: authToken)
            journalEntries.sort { $0.date > $1.date }
            hasLoaded = true
            isLoading = false
        } catch {
            self.error = error.localizedDescription
            isLoading = false
            hasError = true
        }
    }
    
}
