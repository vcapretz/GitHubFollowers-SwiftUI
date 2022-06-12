//
//  FollowerViewModel.swift
//  GHFollowers
//
//  Created by Vitor Capretz on 12/06/22.
//

import Foundation

@MainActor class FollowerViewModel: ObservableObject {
    @Published private(set) var followers: [Follower] = []
    @Published var username: String = ""
    @Published var errorMessage: String = ""
    
    func getFollowers() async  {
        let result = await NetworkManager.shared.getFollowers(for: username, page: 1)
        
        switch result {
            case .success(let followers): self.followers = followers
            case .failure(let error): self.errorMessage = error.rawValue
        }
    }
}
