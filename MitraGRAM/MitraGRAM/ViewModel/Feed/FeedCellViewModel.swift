//
//  FeedCellViewModel.swift
//  MitraGRAM
//
//  Created by Amaan Amaan on 20/09/24.
//

import SwiftUI
import UIKit

class FeedCellViewModel: ObservableObject {
    @Published var post: Post
    
    var likeString: String {
        let label = post.likes == 1 ? "like" : "likes"
        return "\(post.likes) \(label)"
    }
    
    var timestampString: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: post.timestamp.dateValue() , to: Date()) ?? ""
    }
    
    init(post: Post) {
        self.post = post
        checkIfUserLikedPost()
    }
    
    func like(){
        guard let uid = AuthViewModel.shared.userSession?.uid else {return}
        guard let postId = post.id else {return}
        
        
        
        COLLECTION_POSTS.document(postId).collection("post-likes").document(uid).setData([ : ]) { _ in
            COLLECTION_USERS.document(uid).collection("user-likes").document(postId).setData([:]) { _ in
                    COLLECTION_POSTS.document(postId).updateData(["likes": self.post.likes + 1 ])
                
                NotificationsViewModel.uploadNotifications(toUid: self.post.ownerUid, type: .like, post: self.post)
                    
                    self.post.didLike = true
                    self.post.likes += 1
                }
            
        }
    }
    
    func unlike(){
        guard post.likes > 0 else {return}
        guard let uid = AuthViewModel.shared.userSession?.uid else {return}
        guard let postId = post.id else {return}
        
        
        COLLECTION_POSTS.document(postId).collection("post-likes").document(uid).delete { _ in
                COLLECTION_USERS.document(uid).collection("user_likes").document(postId).delete { _ in
                    COLLECTION_POSTS.document(postId).updateData(["likes": self.post.likes - 1 ])
                    
                    self.post.didLike = false
                    self.post.likes -= 1
                }
            }
    }
    
    func checkIfUserLikedPost() {
        guard let uid = AuthViewModel.shared.userSession?.uid else {return}
        guard let postId = post.id else {return}
        
        COLLECTION_USERS.document(uid).collection("user-likes").document(postId)
            .getDocument { snapshot, _  in
                guard let didLike = snapshot?.exists else {return}
                self.post.didLike = didLike
                
        }
    }
    
    func sharePost() {
        let postCaption = post.caption
        let postImageUrl = post.imageUrl
        
        guard let imageUrl = URL(string: postImageUrl) else { return }
        
        let activityItems: [Any] = [postCaption, imageUrl]
        let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        
        // iPad specific popover handling
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootVC = windowScene.windows.first?.rootViewController {
            
            if let popover = activityVC.popoverPresentationController {
                popover.sourceView = rootVC.view // Make sure it's tied to the view
                popover.sourceRect = CGRect(x: rootVC.view.bounds.midX, y: rootVC.view.bounds.midY, width: 0, height: 0)
                popover.permittedArrowDirections = []
            }
            
            rootVC.present(activityVC, animated: true, completion: nil)
        }
    }
    
    
    func fetchPostUser(){
        
    }
    
    
}
