//
//  AddJournalView.swift
//  journal-app-ios
//
//  Created by Sushant Hande on 30/07/26.
//

import SwiftUI

struct AddJournalView: View {

    @AppStorage("authToken") private var authToken: String = ""
    @AppStorage("userName") private var userName: String = ""

    @State var addJournalViewModel = AddJournalViewModel(
        addJournalRepository: AddJournalRepositoryImpl(
            networkServiceProtocol: NetworkManager()
        )
    )
    
    @Binding var path: [AppScreen]
    @Environment(HomeViewModel.self) private var homeViewModel
    
    
    var body: some View {
        ZStack {
            
            VStack(alignment: .leading) {
                
                HStack {
                    Image(systemName: "calendar")
                        .font(.subheadline)
                    
                    Text(
                        Date().formatted(date: .numeric, time: .omitted)
                    )
                    .font(.subheadline)
                    .padding(.leading, -5)
                }
                .padding(.top)
                
                TextField("title_your_journal", text: $addJournalViewModel.title)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color(.systemGray4), lineWidth: 1)
                    )
                    .padding(.top, 10)
                
                TextEditor(text: $addJournalViewModel.content)
                    .padding()
                    .scrollContentBackground(.hidden)
                    .frame(height: 200)
                    .border(Color.gray.opacity(0.2), width: 1)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color(.systemGray4), lineWidth: 1)
                    )
                    .padding(.top, 10)
                
                Button(action: {
                    if !addJournalViewModel.validateInput() {
                        return
                    }
                    
                    Task {
                        let journalEntry = await addJournalViewModel.addJournal(
                            userName: userName,
                            authToken: authToken
                        )
                        
                        if let journalEntry = journalEntry {
                            homeViewModel.journalEntries.insert(journalEntry, at: 0)
                        }
                        
                    }
                }) {
                    Text("Add Journal")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .tint(.blue)
                .controlSize(.large)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.top, 10)
                
                .alert(
                    "success",
                    isPresented: $addJournalViewModel.showSuccessMessage,
                    actions: { Button("Okay") { path.removeLast()  } },
                    message: {
                        Text("New journal successfully added")
                    }
                )
                
                .alert(
                    "error",
                    isPresented: $addJournalViewModel.showValidationError,
                    actions: { Button("Okay") { /* Retry logic */  } },
                    message: {
                        Text("enter_valid_title_content")
                    }
                )
                
                Spacer()
            }
            .padding()
            .navigationTitle("Add Journal")
            
            addJournalViewModel.isLoading ? ProgressView() : nil
        }
    }
}

#Preview {
    let addJournalViewModel = AddJournalViewModel(
        addJournalRepository: MockAddJournalRepository()
    )
    AddJournalView(addJournalViewModel: addJournalViewModel, path: .constant([]))
        .environment(HomeViewModel(homeRepository:MockHomeRepositoryImpl()))
}
