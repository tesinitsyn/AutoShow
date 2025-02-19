//
//  HomeView.swift
//  AutoShow
//
//  Created by Timofey Sinitsyn on 19.02.2025.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            Text("Welcome to the App!")
            AsyncImage(url: URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ_ujr52D_x_sSfJnb818WyAMPMyke2QflrDg&s"))
                .frame(width: 100, height: 100)
        }
    }
}
