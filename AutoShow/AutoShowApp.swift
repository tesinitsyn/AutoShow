//
//  AutoShowApp.swift
//  AutoShow
//
//  Created by Timofey Sinitsyn on 19.02.2025.
//

import SwiftUI

@main
struct AutoShowApp: App {
    @AppStorage("isAuthenticated") var isAuthenticated = false
    
    var body: some Scene {
        WindowGroup {
            if isAuthenticated {
                HomeView()
            } else {
                AuthView()
            }
        }
    }
}
