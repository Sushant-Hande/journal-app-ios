//
//  JournalEndPoint.swift
//  journal-app-ios
//
//  Created by Sushant Hande on 29/07/26.
//

import Foundation

enum JournalEndPoint: Endpoint {
    case getJournals(userName: String, authToken: String)
    case addJournal(title: String, content: String, authToken: String)
    
    var path: String {
        switch self {
        case .getJournals(let userName, let authToken): return "/journal/getJournalEntries/\(userName)"
        case .addJournal: return "/journal/addJournalEntry"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getJournals: return .get
        case .addJournal: return .post
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .getJournals(_, let authToken), .addJournal(_, _, let authToken):
            return ["Authorization": "Bearer \(authToken)"]
        }
    }
    
    var body: Data? {
        switch self {
        case .getJournals(let userName, let authToken):
            return nil
            
        case .addJournal(let title, let content, let authToken):
            return try? JSONEncoder().encode(["title": title, "content": content])
        }
    }
}
