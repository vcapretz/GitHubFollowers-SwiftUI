//
//  FollowerDetailView.swift
//  GHFollowers
//
//  Created by Vitor Capretz on 15/06/22.
//

import SwiftUI

struct FollowerDetailView: View {
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var followerViewModel: FollowerViewModel
    @StateObject var userViewModel = UserViewModel()
    
    var follower: Follower
    
    var body: some View {
        NavigationStack {
            VStack {
                userHeaderInfo
                
                itemOne
                
                itemTwo
                    .padding(.top)
                
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
        .fullScreenCover(item: $userViewModel.gitHubProfile) { profile in
            profile.safari()
        }
    }
    
    var userHeaderInfo: some View {
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
                .padding([.top, .bottom])
                .multilineTextAlignment(.leading)
        }
    }
    
    var itemOne: some View {
        VStack {
            HStack {
                GFItemInfoView(itemType: .repos, count: userViewModel.user.publicRepos)
                
                Spacer()
                
                GFItemInfoView(itemType: .gists, count: userViewModel.user.publicGists)
            }
            
            Button {
                userViewModel.didTapGitHubProfile()
            } label: {
                Text("GitHub Profile")
                    .padding()
                    .frame(height: 44)
                    .gfButtonStyle(backgroundColor: .purple)
            }
            .padding(.top)
        }
        .padding()
        .cornerRadius(18)
        .background {
            Color(uiColor: .secondarySystemBackground)
                .cornerRadius(18)
        }
    }
    
    var itemTwo: some View {
        VStack {
            HStack {
                GFItemInfoView(itemType: .followers, count: userViewModel.user.followers)
                
                Spacer()
                
                GFItemInfoView(itemType: .following, count: userViewModel.user.following)
            }
            
            Button {
                Task {
                    await followerViewModel.didTapGitHubFollowers(from: userViewModel.user.login)
                }
            } label: {
                Text("GitHub Followers")
                    .padding()
                    .frame(height: 44)
                    .gfButtonStyle(backgroundColor: .green)
            }
            .padding(.top)
        }
        .padding()
        .cornerRadius(18)
        .background {
            Color(uiColor: .secondarySystemBackground)
                .cornerRadius(18)
        }
    }
}

struct FollowerDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FollowerDetailView(follower: Follower(id: 1, login: "vcapretz", avatarUrl: "https://github.com/vcapretz.png"))
            .environmentObject(FollowerViewModel())
    }
}
