//
//  UserViewModel.swift
//  GHFollowers
//
//  Created by Vitor Capretz on 16/06/22.
//

import Foundation

@MainActor class UserViewModel: ObservableObject {
    @Published private(set) var user: User = User(login: "", avatarUrl: "", publicRepos: 0, publicGists: 0, htmlUrl: "", following: 0, followers: 0, createdAt: "")
    
    @Published private(set) var errorMessage: String = ""
    
    func getUserInfo(for username: String) async {
        let result = await NetworkManager.shared.getUserInfo(for: username)
        
        switch result {
            case .success(let newUser):
                user = newUser
            case .failure(let error): errorMessage = error.rawValue
        }
    }
}
