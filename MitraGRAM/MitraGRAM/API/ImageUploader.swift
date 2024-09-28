//
//  ImageUploader.swift
//  MitraGRAM
//
//  Created by Amaan Amaan on 14/09/24.
//

import UIKit
import Firebase
import FirebaseStorage

enum UploadType {
    case profile
    case post
    
    var filePath: StorageReference {
        let filename = NSUUID().uuidString
        switch self {
        case .profile:
           return Storage.storage().reference(withPath: "/profile_images/\(filename)")
        case .post:
           return Storage.storage().reference(withPath: "/profile_images/\(filename)")
        }
    }
}


struct ImageUploader {
    static func uploadImage(image: UIImage, type: UploadType, completion: @escaping(String) -> Void ){
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        let ref = type.filePath
        
        ref.putData(imageData, metadata: nil) { _, error in
            if let error = error {
                print("Debug: Failed to upload image \(error.localizedDescription)")
                return
            }
            
            print("successfully uploaded image.....")
            
            ref.downloadURL { url, _  in
                guard let imageUrl = url?.absoluteString else {return}
                completion(imageUrl)
            }
        }
        
    }
    
}
