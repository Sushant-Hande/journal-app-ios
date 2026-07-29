//
//  JournalEntry.swift
//  journal-app-ios
//
//  Created by Sushant Hande on 29/07/26.
//

import Foundation

struct JournalEntry: Identifiable, Codable {
    var id: UUID
    var title: String
    var content: String
    var date: Date?
    var sentiment: String?
}
