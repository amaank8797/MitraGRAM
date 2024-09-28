//
//  SettingsView.swift
//  MitraGRAM
//
//  Created by Amaan Amaan on 22/09/24.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack{
            ScrollView(.vertical, showsIndicators: false) {
                //MARK: SECTION1: MitraGram
                GroupBox(label: SettingsLabelView(labelText: "MitraGram", labelImage: "dot.radiowaves.left.and.right"), content: {
                    HStack(alignment: .center,spacing: 10, content: {
                        
                        Image("logo1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80, alignment: .center)
                            .cornerRadius(12)
                        
                        Text("MitraGram is no one app for posting pictures of friends and sharing then across the worlds. We are a friendship spreading community and we are happy to have you!")
                            .font(.footnote)
                        
                        
                    })
                })
                .padding()
                
                //MARK: SECTION2: PROFILE
                GroupBox(label: SettingsLabelView(labelText: "Profile", labelImage: "person.fill"), content: {
                    
                    NavigationLink {
                        SettingsEditTextView(submissionText: "current display name", title: "Display Name", description: "You can edit you display name here. this will be seen by other users on your profile and on your posts! ", placeholder: "Your display name here...")
                    } label: {
                        SettingsRowView(leftIcon: "pencil", text: "Display Name", color: Color.MyTheme.brownColor)
                        
                    }
                    
                    
                    NavigationLink {
                        SettingsEditTextView(submissionText: "Current Bio here...", title: "Profile Bio", description: "Your bio is a great place to let other other users know a little about you. It will be shown on your profile only.", placeholder: "Your bio here>..")
                    } label: {
                        SettingsRowView(leftIcon: "text.quote", text: "Bio", color: Color.MyTheme.brownColor)
                        
                    }
                    
                    NavigationLink {
                        SettingsEditImageView(title: "ProfilePicture", description: "Your profile picture will be shown on your profile and on your posts. Most users make it an image of themselves. ", selectedImage: UIImage(named: "image5")! )
                    } label: {
                        SettingsRowView(leftIcon: "photo", text: "Profile Picture", color: Color.MyTheme.brownColor)
                        
                    }
                    Button {
                        AuthViewModel.shared.signOut()
                    } label: {
                        SettingsRowView(leftIcon: "figure.walk", text: "Sign Out", color: Color.MyTheme.brownColor)

                    }

                    
                    
                    
                })
                .padding()
                
                //MARK: SECTION 3: APPLICATION
                GroupBox(label: SettingsLabelView(labelText: "Application", labelImage: "apps.iphone")) {
                    
                    Button(action: {
                        openCustomURL(urlStrings: "https://www.google.com")
                    }, label: {
                        SettingsRowView(leftIcon: "folder.fill", text: "Privacy Policy", color: Color.MyTheme.biegeColor)
                    })
                    Button(action: {
                        openCustomURL(urlStrings: "https://www.google.com")

                    }, label: {
                        SettingsRowView(leftIcon: "folder.fill", text: "Terms & Condition", color: Color.MyTheme.biegeColor)
                    })
                    Button(action: {
                        openCustomURL(urlStrings: "https://www.google.com")

                    }, label: {
                        SettingsRowView(leftIcon: "globe", text: "MitraGram's Website", color: Color.MyTheme.biegeColor)
                    })
                    
                    
                    
                }
                .padding()
                
                //MARK: SECTION 4: SIGN OFF
                
                GroupBox {
                    Text("MitraGram is made with love. \n All Rights Reserved \n Cool Apps Inc. \n Copyright 2024 ❤️ ")
                        .foregroundStyle(Color.gray)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                }
                .padding(/*@START_MENU_TOKEN@*/EdgeInsets()/*@END_MENU_TOKEN@*/)
                .padding(.bottom, 80)
                
            }
            .navigationBarTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarItems(leading:
                                    Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "xmark")
                    .font(.title)
            })
                                        .accentColor(.primary)
                                
            )
        }
        
    }
    
    //MARK: FUNCTIONS
    
    func openCustomURL(urlStrings: String){
        guard let url = URL(string: urlStrings) else { return }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
        
    }
    
}

#Preview {
    SettingsView()
}

