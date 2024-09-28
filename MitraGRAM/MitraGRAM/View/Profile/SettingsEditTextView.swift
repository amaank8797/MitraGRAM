//
//  SettingsEditTextView.swift
//  MitraGRAM
//
//  Created by Amaan Amaan on 22/09/24.
//

import SwiftUI

struct SettingsEditTextView: View {
    
    @State var submissionText: String = ""
    @State var title: String
    @State var description: String
    @State var placeholder: String
    
    
    var body: some View {
        VStack{
            
            HStack {
                Text(description)
                Spacer(minLength: 0)
            }
            
            TextField(placeholder, text: $submissionText)
                .padding()
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .background(.thinMaterial)
                .cornerRadius(12)
                .font(.headline)
                .autocapitalization(.sentences)
            
            Button(action: {
                
            }, label: {
                Text("Save".uppercased())
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding()
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(Color.MyTheme.brownColor)
                    .cornerRadius(12)
            })
            .accentColor(Color.MyTheme.pinkColor)
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        
        
        .navigationBarTitle(title)
    }
}

#Preview {
    NavigationStack{
        SettingsEditTextView(title: "Test Title", description: "this is a description", placeholder: "test Placeholder")

    }
}
