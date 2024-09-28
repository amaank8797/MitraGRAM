//
//  UploadPostView.swift
//  MitraGRAM
//
//  Created by Amaan Amaan on 14/09/24.
//

import SwiftUI

struct UploadPostView: View {
    @State private var selectedImage: UIImage?
    @State var postImage: Image?
    @State var captionText = ""
    @State var imagePickerPresented = false
    @Binding var tabIndex: Int
    @ObservedObject var viewModel = UploadPostViewModel()
    
    var body: some View {
        VStack {
            if postImage == nil {
                Button(action: { imagePickerPresented.toggle() }, label: {
                    Image(systemName: "square.and.arrow.up")
                        .resizable()
                        .renderingMode(.template)
                        .scaledToFit()
                        .frame(width: 180, height: 180)
                        .clipped()
                        .padding(.top, 56)
                        .foregroundColor(.primary) // Adapt to light/dark mode
                })
                .sheet(isPresented: $imagePickerPresented, onDismiss: loadImage, content: {
                    ImagePicker(image: $selectedImage)
                })
            } else if let image = postImage {
                HStack(alignment: .top) {
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 96, height: 96)
                        .clipped()
                    
                    TextArea(text: $captionText, placeholder: "Enter your caption")
                        .frame(height: 200)
                        .background(Color(.systemGray6)) // Light background
                        .cornerRadius(8)
                        .foregroundColor(.primary) // Text color
                }
                .padding()
                
                HStack(spacing: 16) {
                    Button(action: {
                        captionText = ""
                        postImage = nil
                    }, label: {
                        Text("Cancel")
                            .font(.system(size: 16, weight: .semibold))
                            .frame(width: 172, height: 50)
                            .background(Color.red)
                            .cornerRadius(5)
                            .foregroundColor(.white)
                    })
                    
                    Button(action: {
                        if let image = selectedImage {
                            viewModel.uploadPost(caption: captionText, image: image) { _ in
                                captionText = ""
                                postImage = nil
                                tabIndex = 0
                            }
                        }
                    }, label: {
                        Text("Share")
                            .font(.system(size: 16, weight: .semibold))
                            .frame(width: 172, height: 50)
                            .background(Color.blue)
                            .cornerRadius(5)
                            .foregroundColor(.white)
                    })
                }
                .padding()
            }
            
           
        }
        .padding()
        .background(Color(.systemBackground)) // Adapts to light/dark mode
        .edgesIgnoringSafeArea(.all)
    }
}

extension UploadPostView {
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        postImage = Image(uiImage: selectedImage)
    }
}
