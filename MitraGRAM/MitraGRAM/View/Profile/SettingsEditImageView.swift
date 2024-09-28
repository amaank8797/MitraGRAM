//
//  SettingsEditImageView.swift
//  MitraGRAM
//
//  Created by Amaan Amaan on 22/09/24.
//

import SwiftUI

struct SettingsEditImageView: View {
   
    @State var title: String
    @State var description: String
    @State var selectedImage: UIImage // image shown on screen
    @State var showImagePicker: Bool = false
    @State var sourceType: UIImagePickerController.SourceType = UIImagePickerController.SourceType.photoLibrary
 
    
    
    var body: some View {
        VStack (alignment: .leading, spacing: 20){
            
            HStack {
                Text(description)
                Spacer(minLength: 0)
            }
            
            
            Image(uiImage: selectedImage)
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 200, alignment: .center)
                .clipped()
                .cornerRadius(12)
            
            Button(action: {
                showImagePicker.toggle()
            }, label: {
                Text("Import".uppercased())
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding()
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(Color.MyTheme.pinkColor)
                    .cornerRadius(12)
            })
            .accentColor(Color.MyTheme.brownColor)

            
            
            
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
    NavigationStack {
        SettingsEditImageView(title: "title", description: "Description", selectedImage: UIImage(named: "image5")!)
    }
}

