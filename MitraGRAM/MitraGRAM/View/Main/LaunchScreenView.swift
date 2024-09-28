//
//  LaunchScreenView.swift
//  MitraGRAM
//
//  Created by Amaan Amaan on 22/09/24.
//

import SwiftUI

struct LaunchScreenView: View {
    var body: some View {
        ZStack {
            // Full-screen background color
            Color.MyTheme.biegeColor
                .ignoresSafeArea() // This ensures it covers the entire screen
            
            VStack {
                Image("logo_backgroundfree") // Your image asset name
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200) // Adjust size as needed
                
                Text("Welcome to MITRAGRAM")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                
                Text("Sharing is the essence of social media.")
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
            }
            .padding() // Optional padding for better layout
        }
    }
}

#Preview {
    LaunchScreenView()
}
