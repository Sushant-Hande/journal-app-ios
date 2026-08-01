//
//  AddJournalViewModel.swift
//  journal-app-ios
//
//  Created by Sushant Hande on 30/07/26.
//

import Foundation

@Observable
class AddJournalViewModel {
    let addJournalRepository: AddJournalRepository
    
    // Properties to manage the state of the view
    var isLoading: Bool = false
    var error: String?
    var hasError = false
    var showValidationError: Bool = false
    var showSuccessMessage: Bool = false
    
    // Properties to hold the title and content of the journal entry
    var title: String = ""
    var content: String = ""
    
    init(addJournalRepository: AddJournalRepository) {
        self.addJournalRepository = addJournalRepository
    }
    
    func validateInput() -> Bool {
        guard !title.isEmpty && !content.isEmpty else {
            showValidationError = true
            return false
        }
        return   true
    }
    
    func addJournal(userName: String, authToken: String) async -> JournalEntry? {
        isLoading = true
        do {
            let journalEntry = try await addJournalRepository.addJournalEntry(title: title, content: self.content ,userName: userName, authToken: authToken)
            isLoading = false
            showSuccessMessage = true
            return journalEntry
        } catch {
            self.error = error.localizedDescription
            isLoading = false
            hasError = true
            return nil
        }
    }
    
}
