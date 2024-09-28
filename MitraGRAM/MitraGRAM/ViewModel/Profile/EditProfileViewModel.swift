//
//  EditProfileViewModel.swift
//  MitraGRAM
//
//  Created by Amaan Amaan on 22/09/24.
//

import SwiftUI

class EditProfileViewModel: ObservableObject {
    var user: User
    @Published var uploadComplete = false
    
    init(user: User) {
        self.user = user
    }
    
    func saveUserBio(_ bio: String){
        guard let uid = user.id else {return}
        COLLECTION_USERS.document(uid).updateData(["bio": bio]) {_ in 
            self.user.bio = bio
            self.uploadComplete = true
        }
    }
    
}
