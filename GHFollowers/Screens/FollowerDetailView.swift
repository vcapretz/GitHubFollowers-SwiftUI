//
//  FollowerDetailView.swift
//  GHFollowers
//
//  Created by Vitor Capretz on 15/06/22.
//

import SwiftUI

struct FollowerDetailView: View {
    @Environment(\.dismiss) var dismiss
    
    @StateObject var userViewModel = UserViewModel()
    
    var follower: Follower
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    AsyncImage(url: URL(string: userViewModel.user.avatarUrl)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        Image("avatar-placeholder")
                            .resizable()
                            .scaledToFit()
                    }
                    .cornerRadius(10)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text(userViewModel.user.login)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Text(userViewModel.user.name ?? "")
                            .fontWeight(.medium)
                            .foregroundColor(.secondary)
                        
                        Spacer()
                        
                        Label(userViewModel.user.location ?? "No Location", systemImage: SFSymbols.location)
                            .foregroundColor(.secondary)
                            .fontWeight(.medium)
                    }
                    
                    Spacer()
                }
                
                .frame(height: 100)
                
                Text(userViewModel.user.bio ?? "")
                    .lineLimit(3)
                    .foregroundColor(.secondary)
                    .padding(.top)
                    .multilineTextAlignment(.leading)
                
                Spacer()
            }
            .padding(.top)
            .padding(.horizontal)
            .frame(maxWidth: .infinity)
                .toolbar {
                    Button("Done") {
                        dismiss()
                    }
                }
        }
        .accentColor(.green)
        .task {
            await userViewModel.getUserInfo(for: follower.login)
        }
    }
}

struct FollowerDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FollowerDetailView(follower: Follower(id: 1, login: "vcapretz", avatarUrl: "https://github.com/vcapretz.png"))
    }
}
