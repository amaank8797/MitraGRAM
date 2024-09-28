//
//  FeedCell.swift
//  MitraGRAM
//
//  Created by Amaan Amaan on 14/09/24.
//

import SwiftUI
import Kingfisher

struct FeedCell: View {
    @State var showActionSheet: Bool = false
    @State var actionSheetType: PostActionSheetOption = .general
    
    enum PostActionSheetOption {
        case general
        case reporting
    }
    
    @ObservedObject var viewModel: FeedCellViewModel
    
    var didLike: Bool { return viewModel.post.didLike ?? false }
    
    init(viewModel: FeedCellViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            // user info
            HStack {
                if let imageUrl = URL(string: viewModel.post.ownerImageUrl) {
                    KFImage(imageUrl)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 36, height: 36)
                        .clipShape(Circle())
                }
                
                Text(viewModel.post.ownerUsername)
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(.primary) // Adjusts automatically for dark/light mode
                
                Spacer()
                
                Button(action: {
                    showActionSheet.toggle()
                }) {
                    Image(systemName: "ellipsis")
                        .font(.headline)
                }
                .accentColor(.primary) // Adjusts for dark/light mode
                .actionSheet(isPresented: $showActionSheet) {
                    getActionSheet()
                }
            }
            .padding([.leading, .bottom, .trailing], 8)
            
            // image
            if let postImageUrl = URL(string: viewModel.post.imageUrl) {
                KFImage(postImageUrl)
                    .resizable()
                    .scaledToFill()
                    .frame(maxHeight: UIDevice.current.userInterfaceIdiom == .pad ? 840 : 440)

                    .frame(minWidth: UIScreen.main.bounds.width)
                    .clipped()
            }
            
            // buttons
            HStack(spacing: 16) {
                Button(action: {
                    didLike ? viewModel.unlike() : viewModel.like()
                }) {
                    Image(systemName: didLike ? "heart.fill" : "heart")
                        .resizable()
                        .scaledToFill()
                        .foregroundColor(didLike ? .red : .primary) // Dynamic for light/dark mode
                        .frame(width: 20, height: 20)
                }
                
                NavigationLink {
                    CommentsView(post: viewModel.post)
                } label: {
                    Image(systemName: "bubble.right")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 20, height: 20)
                }
                
                Button(action: {
                    viewModel.sharePost()
                }) {
                    Image(systemName: "paperplane")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 20, height: 20)
                }
            }
            .padding(.leading, 4)
            .foregroundColor(.primary) // Adjusts automatically for dark/light mode
            
            // caption and likes
            Text(viewModel.likeString)
                .font(.system(size: 14, weight: .semibold))
                .padding(.leading, 8)
                .padding(.bottom, 2)
                .foregroundColor(.primary) // Dynamic text color for dark/light mode
            
            HStack {
                Text(viewModel.post.ownerUsername)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.primary) +
                Text(" \(viewModel.post.caption)")
                    .font(.system(size: 15))
                    .foregroundColor(.primary)
            }
            .padding(.horizontal, 8)
            
            Text(viewModel.timestampString)
                .font(.system(size: 14))
                .foregroundColor(.secondary) // More subtle color for timestamp in dark/light mode
                .padding(.leading, 8)
                .padding(.top, -2)
        }
    }
    
    // functions
    func getActionSheet() -> ActionSheet {
        switch actionSheetType {
        case .general:
            return ActionSheet(
                title: Text("What would you like to do?"),
                message: nil,
                buttons: [
                    .destructive(Text("Report"), action: {
                        self.actionSheetType = .reporting
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.showActionSheet = true
                        }
                    }),
                    .default(Text("Learn more..."), action: {
                        print("LEARN MORE PRESSED")
                    }),
                    .cancel()
                ]
            )
        case .reporting:
            return ActionSheet(
                title: Text("Why are you reporting this post?"),
                message: nil,
                buttons: [
                    .destructive(Text("This is inappropriate"), action: {
                        reportPost(reason: "This is inappropriate")
                    }),
                    .destructive(Text("This is spam"), action: {
                        reportPost(reason: "This is spam")
                    }),
                    .destructive(Text("It made me uncomfortable"), action: {
                        reportPost(reason: "It made me uncomfortable")
                    }),
                    .cancel({
                        self.actionSheetType = .general
                    })
                ]
            )
        }
    }
    
    func reportPost(reason: String) {
        print("REPORT POST: \(reason)")
    }
}
