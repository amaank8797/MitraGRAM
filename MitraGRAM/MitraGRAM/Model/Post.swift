//
//  Post.swift
//  MitraGRAM
//
//  Created by Amaan Amaan on 20/09/24.
//


import FirebaseFirestore



struct Post: Identifiable, Decodable {
    @DocumentID var id: String?
    let ownerUid: String
    let ownerUsername: String
    let caption: String
    var likes: Int
    let imageUrl: String
    let timestamp: Timestamp
    let ownerImageUrl: String
    
    var didLike: Bool? = false
    var user: User?
    
    
}
