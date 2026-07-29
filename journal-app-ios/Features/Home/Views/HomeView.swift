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

    init(homeViewModel: HomeViewModel) {
        self.homeViewModel = homeViewModel
    }

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack {
                List {
                    ForEach(homeViewModel.journalEntries) { journalEntry in
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
                        .overlay(
                            Image(systemName: "plus").font(.title2)
                                .foregroundColor(.blue).bold()
                        )
                }
            )
            .padding()

            homeViewModel.isLoading ? ProgressView() : nil

        }.onAppear {
            Task {
                await homeViewModel.fetchJournalEntries(
                    userName: userName,
                    authToken: authToken
                )
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    let homeViewModel = HomeViewModel(homeRepository: MockHomeRepositoryImpl())
    HomeView(homeViewModel: homeViewModel)
}
