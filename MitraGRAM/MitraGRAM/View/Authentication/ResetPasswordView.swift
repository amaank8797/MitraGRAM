//
//  ResetPasswordView.swift
//  MitraGRAM
//
//  Created by Amaan Amaan on 14/09/24.
//

import SwiftUI

struct ResetPasswordView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.presentationMode) var mode
    @Binding var email: String

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.MyTheme.brownColor, Color.MyTheme.pinkColor]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                Image("logo_backgroundfree")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 220, height: 100)
                    .foregroundColor(.white)
                                    
                VStack(spacing: 20) {
                    CustomTextField(text: $email, placeholder: Text("Email"), imageName: "envelope")
                        .padding()
                        .background(Color(.init(white: 1, alpha: 0.15)))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .padding(.horizontal, 32)
                }
                                    
                Button(action: {
                    viewModel.resetPassword(withEmail: email)
                    
                }, label: {
                    Text("Send Reset Password Link")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 360, height: 50)
                        .background(Color.MyTheme.brownColor)
                        .clipShape(Capsule())
                        .padding()
                })
                
               // Spacer()

                // Display reset password error
                if let error = viewModel.resetPasswordError {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                }

                Button(action: { mode.wrappedValue.dismiss() }, label: {
                    HStack {
                        Text("Already have an account?")
                            .font(.system(size: 14))
                        
                        Text("Sign In")
                            .font(.system(size: 14, weight: .semibold))
                    }.foregroundColor(.white)
                })
            }
            .padding(.top, -44)
        }
        .onReceive(viewModel.$didSendResetPasswordLink) { didSend in
            if didSend {
                self.mode.wrappedValue.dismiss()
            }
        }
    }
        
}
