//
//  UserViewModel.swift
//  GHFollowers
//
//  Created by Vitor Capretz on 16/06/22.
//

import Foundation

@MainActor class UserViewModel: ObservableObject {
    @Published private(set) var user: User = User(id: 0, login: "", avatarUrl: "", publicRepos: 0, publicGists: 0, htmlUrl: "", following: 0, followers: 0, createdAt: "")
    
    @Published var gitHubProfile: IdentifiableSafariView?
    @Published private(set) var errorMessage: String = ""
    
    func getUserInfo(for username: String) async {
        let result = await NetworkManager.shared.getUserInfo(for: username)
        
        switch result {
            case .success(let newUser):
                user = newUser
            case .failure(let error): errorMessage = error.rawValue
        }
    }
    
    func didTapGitHubProfile() {
        guard let url = URL(string: user.htmlUrl) else {
            errorMessage = "The URL attached to this user is invalid"
            return
        }
        
        gitHubProfile = IdentifiableSafariView(id: "github-profile", safari: {
            SFSafariViewWrapper(url: url)
        })
    }
    
    func didTapGitHubFollowers() {
        
    }
}
