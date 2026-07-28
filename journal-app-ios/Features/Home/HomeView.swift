//
//  HomeView.swift
//  journal-app-ios
//
//  Created by Sushant Hande on 28/07/26.
//

import SwiftUI

struct HomeView: View {
    
    @AppStorage("authToken") private var authToken: String = ""
    
    var body: some View {
        
        ZStack {
            VStack {
                Text("Welcome to the Home View!")
                    .font(.title)
                    .padding()
                
                Text(authToken)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    HomeView()
}
