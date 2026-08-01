//
//  HomeView.swift
//  journal-app-ios
//
//  Created by Sushant Hande on 28/07/26.
//

import SwiftUI

struct HomeView: View {

    @AppStorage("authToken") private var authToken: String = ""
    @AppStorage("userName") private var userName: String = ""

    private let homeViewModel: HomeViewModel
    let onAddJournal: () -> Void

    init(homeViewModel: HomeViewModel, onAddJournal: @escaping () -> Void) {
        self.homeViewModel = homeViewModel
        self.onAddJournal = onAddJournal
    }

    var body: some View {
        ZStack(alignment: .center) {
            ZStack(alignment: .bottomTrailing) {
                VStack {
                    List {
                        ForEach(homeViewModel.journalEntries) { journalEntry in
                            JournalEntryView(journalEntry: journalEntry)
                        }.onDelete { _ in
                            
                        }
                    }.task {
                        await homeViewModel.fetchJournalEntriesIfNeeded(
                            userName: userName,
                            authToken: authToken
                        )
                    }
                }
                
                Button(
                    action: {
                        onAddJournal()
                    },
                    label: {
                        Circle()
                            .fill(.white)
                            .frame(width: 60, height: 60)
                            .shadow(radius: 10)
                            .overlay(
                                Image(systemName: "plus").font(.title2)
                                    .foregroundColor(.blue).bold()
                            )
                    }
                )
                .padding()
                
            }
            .navigationBarBackButtonHidden(true)
            
            homeViewModel.isLoading ? ProgressView() : nil
        }
    }
}

#Preview {
    let homeViewModel = HomeViewModel(homeRepository: MockHomeRepositoryImpl())
    HomeView(homeViewModel: homeViewModel, onAddJournal: {})
}
