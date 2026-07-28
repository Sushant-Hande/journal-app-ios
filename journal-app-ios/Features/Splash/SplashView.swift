//
//  SplashView.swift
//  journal-app-ios
//
//  Created by Sushant Hande on 28/07/26.
//

import SwiftUI

struct SplashView: View {
    
    @Binding var path: [AppScreen]
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
    
    var body: some View {
        ZStack(alignment: .center) {
            Text("Journal")
                .font(.largeTitle)
        }
        .task {
            // Simulate a delay for the splash screen
            try? await Task.sleep(nanoseconds: 2_000_000_000) // 2 seconds
            
            if isLoggedIn {
                path.append(.home)
            } else {
                path.append(.login)
            }
        }
    }
}

#Preview {
    SplashView(path: .constant([]))
}
