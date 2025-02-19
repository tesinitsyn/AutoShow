//
//  AuthView.swift
//  AutoShow
//
//  Created by Timofey Sinitsyn on 19.02.2025.
//

import SwiftUI

struct AuthView: View {
    @State private var username = ""
    @State private var password = ""
    @ObservedObject var authViewModel = AuthViewModel()

    var body: some View {
        VStack {
            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Login") {
                authViewModel.login(username: username, password: password)
            }
            .padding()
        }
        .onAppear {
            print("AuthView появился, isAuthenticated = \(authViewModel.isAuthenticated)")
        }
    }
}


