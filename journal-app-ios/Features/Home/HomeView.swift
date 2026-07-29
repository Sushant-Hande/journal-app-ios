//
//  HomeView.swift
//  journal-app-ios
//
//  Created by Sushant Hande on 28/07/26.
//

import SwiftUI

struct HomeView: View {

    @AppStorage("authToken") private var authToken: String = ""

    let journalEntry = JournalEntry(
        id: UUID(),
        title: "Sample Entry",
        content:
            "This is a sample journal entry. It contains some text to demonstrate how the journal entry will look in the app.",
        date: Date(),
        sentiment: "Positive"
    )

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack {
                List {
                    ForEach(0..<10) { _ in
                        JournalEntryView(journalEntry: journalEntry)
                    }.onDelete { _ in
                        
                    }
                }
            }
            
            Button(
                action: {
                   
                },
                label: {
                    Circle()
                        .fill(.white)
                        .frame(width: 60, height: 60)
                        .shadow(radius: 10)
                        .overlay(Image(systemName: "plus").font(.title2).foregroundColor(.blue).bold())
                }
            )
            .padding()
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    HomeView()
}
