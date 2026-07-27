//
//  LoginView.swift
//  journal-app-ios
//
//  Created by Sushant Hande on 27/07/26.
//

import SwiftUI

struct LoginView: View {
    
    @State private var emailInput: String = ""
    @State private var passwordInput: String = ""
    @State private var isPasswordVisible: Bool = false
    
    @Binding var path: [AppScreen]
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text("welcome_label")
                    .font(.largeTitle)
                    .foregroundColor(.primary)
                
                Spacer()
                    .frame(height: 20)
                
                Text("settle_into")
                    .font(.title3)
                
                Spacer()
                    .frame(height: 20)
                
                TextField("email", text: $emailInput)
                                .keyboardType(.emailAddress)
                                .textContentType(.emailAddress)
                                .autocorrectionDisabled(true)
                                .textInputAutocapitalization(.never)
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color(.systemGray4), lineWidth: 1)
                                )
                
                Spacer()
                    .frame(height: 20)
                
                HStack {
                    // Conditional swap based on visibility state
                    if isPasswordVisible {
                        TextField("password", text: $passwordInput)
                            .textContentType(.password)
                            .autocorrectionDisabled(true)
                            .textInputAutocapitalization(.never)
                    } else {
                        SecureField("password", text: $passwordInput)
                            .textContentType(.password)
                    }
                    
                    // Show / Hide Eye Button Toggle
                    Button(action: { isPasswordVisible.toggle() }) {
                        Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                            .foregroundColor(.gray)
                            .padding(.trailing, 4)
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color(.systemGray4), lineWidth: 1)
                )
                
                Spacer()
                    .frame(height: 20)
                
                Button(action: {
                           print("Login button tapped")
                       }) {
                           Text("login")
                               .font(.headline)
                               .frame(maxWidth: .infinity)
                       }
                       .buttonStyle(.borderedProminent)
                       .tint(.blue)
                       .controlSize(.large)
                       .clipShape(RoundedRectangle(cornerRadius: 12))
                
                Spacer()
                    .frame(height: 20)
                
                HStack {
                    Spacer()
                        .frame(height: 0.6)
                        .background(Color.gray)
                    
                    Text("or")
                        .padding(.horizontal, 8)
                    
                    Spacer()
                        .frame(height: 0.6)
                        .background(Color.gray)
                }
                
                Spacer()
                    .frame(height: 20)
                
                HStack(alignment: .center) {
                    Text("new_here")
                    Text("create_an_account")
                        .foregroundColor(.blue)
                        .onTapGesture {
                            path.append(.signUp)
                        }
                }
                .frame(maxWidth: .infinity)
                
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    LoginView(path: .constant([]))
}
