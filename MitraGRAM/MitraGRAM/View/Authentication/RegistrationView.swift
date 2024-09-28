//
//  RegistrationView.swift
//  MitraGRAM
//
//  Created by Amaan Amaan on 14/09/24.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var fullname = ""
    @State private var username = ""
    @State private var password = ""
    @State private var selectedImage: UIImage?
    @State private var image: Image?
    @State var imagePickerPresented = false
    @Environment(\.presentationMode) var mode
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.MyTheme.brownColor, Color.MyTheme.pinkColor]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Profile image or upload button
                ZStack {
                    if let image = image {
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 140, height: 140)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 4))
                            .shadow(radius: 10)
                    } else {
                        Button(action: { imagePickerPresented.toggle() }, label: {
                            Image(systemName: "person")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 140, height: 140)
                                .foregroundColor(.white)
                                
                        })
                        .sheet(isPresented: $imagePickerPresented, onDismiss: loadImage, content: {
                            ImagePicker(image: $selectedImage)
                        })
                    }
                }
                .padding(.top, 40)
                
                // Input fields for email, username, fullname, and password
                VStack(spacing: 20) {
                    CustomTextField(text: $email, placeholder: Text("Email"), imageName: "envelope")
                        .textFieldStyle()
                    
                    CustomTextField(text: $username, placeholder: Text("Username"), imageName: "person")
                        .textFieldStyle()
                    
                    CustomTextField(text: $fullname, placeholder: Text("Full Name"), imageName: "person")
                        .textFieldStyle()
                    
                    CustomSecureField(text: $password, placeholder: Text("Password"))
                        .textFieldStyle()
                }
                
                // Sign-up button
                Button(action: {
                    viewModel.register(withEmail: email, password: password, image: selectedImage, fullname: fullname, username: username)
                    
                }, label: {
                    Text("Sign Up")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 360, height: 50)
                        .background(Color.MyTheme.brownColor)
                        .clipShape(Capsule())
                        .padding(.top, 20)
                })
                
                // Sign-in option
                Button(action: { mode.wrappedValue.dismiss() }, label: {
                    HStack {
                        Text("Already have an account?")
                            .font(.system(size: 14))
                        
                        Text("Sign In")
                            .font(.system(size: 14, weight: .semibold))
                    }
                    .foregroundColor(.white)
                })
                .padding(.top, 20)
                
                Spacer()
            }
            .padding()
        }
    }
}

extension View {
    func textFieldStyle() -> some View {
        self
            .padding()
            .background(Color.white.opacity(0.15))
            .cornerRadius(10)
            .foregroundColor(.white)
            .padding(.horizontal, 10)
    }
}

extension RegistrationView {
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        image = Image(uiImage: selectedImage)
    }
}

#Preview {
    RegistrationView()
}
