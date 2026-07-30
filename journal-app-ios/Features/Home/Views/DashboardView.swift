//
//  DashboardView.swift
//  journal-app-ios
//
//  Created by Sushant Hande on 29/07/26.
//

import SwiftUI

struct DashboardView: View {
    
    @Binding var path: [AppScreen]
    
    // State variable to track the currently selected tab
    @State private var selectedTab = 0
 
    @State var homeViewModel = HomeViewModel(homeRepository: HomeRepositoryImpl(networkServiceProtocol: NetworkManager()))

    var body: some View {

        TabView(selection: $selectedTab) {
            HomeView(homeViewModel: homeViewModel)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(0)

            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                }
                .tag(1)
        }
        .navigationTitle(Text("Journals"))
        .navigationBarTitleDisplayMode(.large)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .secondaryAction) {
                Button("Profle") {
                    path.append(.profile)
                }
            }
        }
    }
}

#Preview {
    DashboardView(path: .constant([]))
}
