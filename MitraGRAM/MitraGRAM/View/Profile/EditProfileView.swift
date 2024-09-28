//
//  EditProfileView.swift
//  MitraGRAM
//
//  Created by Amaan Amaan on 22/09/24.
//

import SwiftUI

struct EditProfileView: View {
    @State private var bioText: String
    @ObservedObject private var viewModel: EditProfileViewModel
    @Binding var user: User
    @Environment(\.presentationMode) var mode
    
    init(user: Binding<User>) {
        self._user = user
        self.viewModel = EditProfileViewModel(user: self._user.wrappedValue)
        self._bioText = State(initialValue: _user.wrappedValue.bio ?? "")
    }
    
    var body: some View {
        VStack {
            HStack {
                Button(action: { mode.wrappedValue.dismiss() }, label: {
                    Text("Cancel")
                        .foregroundColor(.primary) // Adapts to light/dark mode
                })
                
                Spacer()
                
                Button(action: { viewModel.saveUserBio(bioText) }, label: {
                    Text("Done").bold()
                        .foregroundColor(.blue) // Ensure it's visible in both modes
                })
            }
            .padding()

            // Adjust TextArea padding or frame
            TextArea(text: $bioText, placeholder: "Add your bio..")
                .frame(width: 370, height: 200)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.5))) // Optional border
                .padding(.horizontal)
                .foregroundColor(.primary) // Adapts to light/dark mode
                .background(Color(.systemBackground)) // Adaptive background for the TextArea

            Spacer()
        }
        .onReceive(viewModel.$uploadComplete) { completed in
            if completed {
                self.mode.wrappedValue.dismiss()
                self.user.bio = viewModel.user.bio
            }
        }
        .navigationTitle("Edit Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
}


