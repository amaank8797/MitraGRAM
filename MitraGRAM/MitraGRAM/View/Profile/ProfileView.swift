//
//  ProfileView.swift
//  MitraGRAM
//
//  Created by Amaan Amaan on 14/09/24.
//

import SwiftUI

struct ProfileView: View {
    let user: User
    var uid: String?
    @ObservedObject var viewModel: ProfileViewModel
    
    init(user: User) {
        self.user = user
        self.viewModel = ProfileViewModel(user: user)
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                ProfileHeaderView(viewModel: viewModel)
                
                PostGridView(config: .profile(user.id ?? ""))
                    
            }.padding(.top)
        }
    }
}



