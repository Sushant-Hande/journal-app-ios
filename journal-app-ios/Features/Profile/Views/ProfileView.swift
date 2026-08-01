//
//  ProfileView.swift
//  journal-app-ios
//
//  Created by Sushant Hande on 30/07/26.
//

import SwiftUI

struct ProfileView: View {

    @AppStorage("userName") private var userName: String = ""

    var body: some View {
            VStack {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.blue)

            Text(userName)

            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Image(systemName: "person")
                        .resizable()
                        .frame(width: 20, height: 20)
                    VStack(alignment: .leading) {
                        Text("user_name")

                        Text(userName)
                            .font(.subheadline)
                    }
                }
                .padding(10)
                .padding(.leading, 10)

                Spacer()
                    .frame(height: 1)
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.5))

                HStack {
                    Image(systemName: "shield")
                        .resizable()
                        .frame(width: 20, height: 20)
                    VStack(alignment: .leading) {
                        Text("logged_in")

                        Text("yes")
                            .font(.subheadline)
                    }
                }
                .padding(10)
                .padding(.leading, 10)

                Spacer()
                    .frame(height: 1)
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.5))

                HStack {
                    Image(systemName: "key")
                        .resizable()
                        .frame(width: 20, height: 20)
                    VStack(alignment: .leading) {
                        Text("auth_token")

                        Text("available")
                            .font(.subheadline)
                    }
                }
                .padding(10)
                .padding(.leading, 10)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.gray.opacity(0.2))
            .cornerRadius(20)
            .padding(.top, 10)

            Text("Version 1.0.0")
                .font(.subheadline)
                .padding(10)

            Spacer(minLength: 0)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .navigationTitle("profile")
    }
}

#Preview {
    ProfileView()
}
