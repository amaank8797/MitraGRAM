//
//  MainTabView.swift
//  MitraGRAM
//
//  Created by Amaan Amaan on 14/09/24.
//

import SwiftUI

struct MainTabView: View {
    let user: User
    @Binding var selectedIndex: Int
    @State var showSettings: Bool = false

    var body: some View {
        NavigationStack {
            TabView(selection: $selectedIndex) {
                FeedView()
                    .onTapGesture {
                        selectedIndex = 0
                    }
                    .tabItem {
                        Image(systemName: "house")
                    }.tag(0)
                
                SearchView()
                    .onTapGesture {
                        selectedIndex = 1
                    }
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                    }.tag(1)
                
                UploadPostView(tabIndex: $selectedIndex)
                    .onTapGesture {
                        selectedIndex = 2
                    }
                    .tabItem {
                        Image(systemName: "plus.square")
                    }.tag(2)
                
                NotificationView()
                    .onTapGesture {
                        selectedIndex = 3
                    }
                    .tabItem {
                        Image(systemName: "heart")
                    }.tag(3)
                
                ProfileView(user: user)
                    .onTapGesture {
                        selectedIndex = 4
                    }
                    .tabItem {
                        Image(systemName: "person")
                    }.tag(4)
            }
            .navigationTitle(tabTitle)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: logoutButton(), trailing: settingsButton())
            .sheet(isPresented: $showSettings) {
                SettingsView()
            }
            .accentColor(.primary) // Dynamically adapts to light/dark mode
        }
    }

    // Show logout button only on Profile tab
    @ViewBuilder
    func logoutButton() -> some View {
        if selectedIndex == 4 {
            Button {
                AuthViewModel.shared.signOut()
            } label: {
                Text("Logout")
                    .foregroundColor(.primary) // Adapts to light/dark mode
            }
        } else {
            EmptyView()
        }
    }
    
    // Show settings button only on Profile tab
    @ViewBuilder
    func settingsButton() -> some View {
        if selectedIndex == 4 {
            Button(action: {
                showSettings.toggle()
            }) {
                Image(systemName: "line.horizontal.3")
            }
            .accentColor(Color.MyTheme.redColor)
        } else {
            EmptyView()
        }
    }

    var tabTitle: String {
        switch selectedIndex {
        case 0: return "Feed"
        case 1: return "Explore"
        case 2: return "New Post"
        case 3: return "Notifications"
        case 4: return "Profile"
        default: return ""
        }
    }
}
