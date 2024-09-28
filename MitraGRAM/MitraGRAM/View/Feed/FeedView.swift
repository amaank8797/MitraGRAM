//
//  FeedView.swift
//  MitraGRAM
//
//  Created by Amaan Amaan on 14/09/24.
//

import SwiftUI

struct FeedView: View {
    @ObservedObject var viewModel = FeedViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 32) {
                ForEach(viewModel.posts) { post in
                    FeedCell(viewModel: FeedCellViewModel(post: post))
                }
            }
            .padding(.top)
        }
    }
}

#Preview {
    FeedView()
}
