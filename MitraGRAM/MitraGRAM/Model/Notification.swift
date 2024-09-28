//
//  Notification.swift
//  MitraGRAM
//
//  Created by Amaan Amaan on 21/09/24.
//

import FirebaseFirestore

struct Notification: Identifiable, Decodable{
    @DocumentID var id: String?
    var postId: String?
    let username: String
    let profileImageUrl: String
    let timestamp: Timestamp
    let type: NotificationType
    let uid: String
    
    var isFollowed: Bool? = false
    var post: Post?
    var user: User?
}

enum NotificationType: Int, Decodable {
    case like
    case comment
    case follow
    
    
    var notificationMessage: String {
        switch self {
        case .like:
            return " liked one of your post"
        case .comment:
            return " commented on one of your post"
        case .follow:
            return " started following you"
        }
    }
}
