//
//  NotificationsViewModel.swift
//  MitraGRAM
//
//  Created by Amaan Amaan on 21/09/24.
//

import SwiftUI
import FirebaseFirestore
import Firebase

class NotificationsViewModel: ObservableObject {
    @Published var notifications = [Notification]()
    
    init(){
        
        fetchNotifications()
    }
    
    func fetchNotifications(){
        
        guard let uid = AuthViewModel.shared.userSession?.uid else {return}
            
        let query = COLLECTION_NOTIFICATIONS.document(uid).collection("user-notification")
            .order(by: "timestamp", descending: true)
        
        query.getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else {return}
            self.notifications = documents.compactMap({ try? $0.data(as: Notification.self)})
            print("HULLA: \(self.notifications)")
            
        }
        
        
    }
    
    static func uploadNotifications(toUid uid: String, type: NotificationType, post: Post? = nil ){
        guard let user = AuthViewModel.shared.currentUser else {return}
        guard uid != user.id else {return}
        
        var data: [String : Any] = ["timestamp": Timestamp(date: Date()),
                                    "username": user.username,
                                    "uid": user.id ?? "",
                                    "profileImageUrl": user.profileImageUrl,
                                    "type": type.rawValue]
        
        if let post = post, let id = post.id {
            data["postId"] = id
        }
        
        COLLECTION_NOTIFICATIONS.document(uid).collection("user-notification")
            .addDocument(data: data)
        
    }
    
}
