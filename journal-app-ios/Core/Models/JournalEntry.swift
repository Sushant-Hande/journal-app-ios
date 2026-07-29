//
//  JournalEntry.swift
//  journal-app-ios
//
//  Created by Sushant Hande on 29/07/26.
//

import Foundation

struct JournalEntry: Identifiable, Codable {
    let id = UUID()
    var title: String
    var content: String
    var date: Date
    var sentiment: String?
    
    // 3. Define CodingKeys and OMIT the ignored fields
        enum CodingKeys: String, CodingKey {
            case title
            case content
            case date
            case sentiment
        }
}

