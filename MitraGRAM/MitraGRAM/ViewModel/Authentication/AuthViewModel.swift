//
//  AuthViewModel.swift
//  MitraGRAM
//
//  Created by Amaan Amaan on 14/09/24.
//

import SwiftUI
import Firebase
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var didSendResetPasswordLink = false
    @Published var resetPasswordError: String? = nil

    static let shared = AuthViewModel()

    init() {
        checkUserSession()
    }
    
    func checkUserSession() {
        userSession = Auth.auth().currentUser
        fetchUser() // Fetch user data after checking session
    }

    func login(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Debug: Login Failed \(error.localizedDescription)")
                return
            }
            guard let user = result?.user else { return }
            self.userSession = user
            self.fetchUser()
        }
    }
    
    func register(withEmail email: String, password: String, image: UIImage?, fullname: String, username: String) {
        guard filterEmail(withEmail: email) else {
            print("Debug: Registration failed due to invalid email")
            return
        }
        
        guard let image = image else { return }
        ImageUploader.uploadImage(image: image, type: .profile) { imageUrl in
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                guard let user = result?.user else { return }
                print("Successfully registered user...")
                
                let data = ["email": email,
                            "username": username,
                            "fullname": fullname,
                            "profileImageUrl": imageUrl,
                            "uid": user.uid]
                
                COLLECTION_USERS.document(user.uid).setData(data) { _ in
                    print("Successfully uploaded user data...")
                    self.userSession = user
                    self.fetchUser()
                }
            }
        }
    }
    
    func signOut() {
        self.userSession = nil
        try? Auth.auth().signOut()
    }
    
    func resetPassword(withEmail email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                print("Failed to send link with error \(error.localizedDescription)")
                self.resetPasswordError = error.localizedDescription
                return
            }
            print("Successfully sent reset link")
            self.didSendResetPasswordLink = true
        }
    }

    func fetchUser() {
        guard let uid = userSession?.uid else { return }
        COLLECTION_USERS.document(uid).getDocument { snapshot, _ in
            guard let user = try? snapshot?.data(as: User.self) else { return }
            self.currentUser = user
        }
    }
    
    func filterEmail(withEmail email: String) -> Bool {
        let emailParts = email.split(separator: "@")
        
        guard emailParts.count == 2 else {
            print("Debug: Invalid email format")
            return false
        }
        
        let domain = emailParts[1]
        
        if let firstChar = domain.first, firstChar.isNumber {
            print("Debug: Invalid email - domain name starts with a number")
            return false
        }
        
        return true
    }
}
