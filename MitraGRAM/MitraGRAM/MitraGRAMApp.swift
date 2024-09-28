//
//  MitraGRAMApp.swift
//  MitraGRAM
//
//  Created by Amaan Amaan on 11/09/24.
//

import SwiftUI
import Firebase

@main
struct MitraGRAMApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(AuthViewModel.shared)
            //MainTabView()
            
        }
    }
}
