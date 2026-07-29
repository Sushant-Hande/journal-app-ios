//
//  JournalEntryView.swift
//  journal-app-ios
//
//  Created by Sushant Hande on 29/07/26.
//

import SwiftUI

struct JournalEntryView: View {
    let journalEntry: JournalEntry

    var body: some View {
        VStack(alignment: .leading) {

            Text(journalEntry.title)
                .font(.headline)
                .lineLimit(1)
                .truncationMode(.tail)

            Text(journalEntry.content)
                .font(.body)
                .lineLimit(3)
                .truncationMode(.tail)
                .padding(.top, 1)

            HStack {
                Image(systemName: "calendar")
                    .font(.subheadline)

                Text(
                    journalEntry.date.formatted(date: .numeric, time: .omitted)
                )
                .font(.subheadline)
                .padding(.leading, -5)
            }
            .padding(.top, 1)

        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .padding(.horizontal, 0)
        .background(.gray.opacity(0.2))
        .cornerRadius(15)
    }
}

#Preview {
    let journalEntry = JournalEntry(
        title: "Sample Entry",
        content:
            "This is a sample journal entry. It contains some text to demonstrate how the journal entry will look in the app.",
        date: Date(),
        sentiment: "Positive"
    )
    JournalEntryView(journalEntry: journalEntry)
}

