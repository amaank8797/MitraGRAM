//
//  ContentView.swift
//  MitraGRAM
//
//  Created by Amaan Amaan on 14/09/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var selectedIndex = 0
    @State private var isLoading = true

    var body: some View {
        Group {
            if isLoading {
                LaunchScreenView() // Show the custom launch screen
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                            isLoading = false
                        }
                    }
            } else {
                if viewModel.userSession == nil {
                    LoginView()
                } else {
                    if let user = viewModel.currentUser {
                        MainTabView(user: user, selectedIndex: $selectedIndex)
                    }
                }
            }
        }
        .onAppear {
            viewModel.checkUserSession() // Check user session on appear
        }
    }
}
