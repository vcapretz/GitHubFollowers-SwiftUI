//
//  FollowerViewModel.swift
//  GHFollowers
//
//  Created by Vitor Capretz on 12/06/22.
//

import Foundation

@MainActor class FollowerViewModel: ObservableObject {
    @Published private(set) var followers: [Follower] = []
    @Published private(set) var errorMessage: String = ""
    @Published private(set) var page = 1
    @Published private(set) var isLoading = false
    
    private var hasMoreFollowers = true
    
    func getFollowers(for username: String, page: Int) async  {
        isLoading = true
        
        let result = await NetworkManager.shared.getFollowers(for: username, page: page)
        
        isLoading = false
        
        switch result {
            case .success(let newFollowers):
                if newFollowers.count < 100 {
                    hasMoreFollowers = false
                }
                
                followers.append(contentsOf: newFollowers)
            case .failure(let error): errorMessage = error.rawValue
        }
    }
    
    func getNextPage(for username: String) async {
        guard hasMoreFollowers else { return }
        
        page += 1
        
        await getFollowers(for: username, page: page)
    }
}
