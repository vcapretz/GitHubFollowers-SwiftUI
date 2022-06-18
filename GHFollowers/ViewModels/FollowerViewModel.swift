//
//  FollowerViewModel.swift
//  GHFollowers
//
//  Created by Vitor Capretz on 12/06/22.
//

import Foundation

@MainActor class FollowerViewModel: ObservableObject {
    private var allFollowers: [Follower] = []
    var followers: [Follower] {
        if searchText.isEmpty {
            return allFollowers
        } else {
            return allFollowers.filter {
                $0.login.localizedCaseInsensitiveContains(searchText.lowercased())
            }
        }
    }
    
    @Published var selectedFollower: Follower?
    @Published private(set) var errorMessage: String = ""
    @Published private(set) var page = 1
    @Published private(set) var isLoading = false
    @Published var searchText = ""
    @Published var username = ""
    
    private var hasMoreFollowers = true
    
    func getFollowers(for username: String, page: Int) async  {
        if page == 1 {
            self.username = username
        }
        
        isLoading = true
        
        let result = await NetworkManager.shared.getFollowers(for: username, page: page)
        
        isLoading = false
        
        switch result {
            case .success(let newFollowers):
                if newFollowers.count < 100 {
                    hasMoreFollowers = false
                }
                
                allFollowers.append(contentsOf: newFollowers)
            case .failure(let error): errorMessage = error.rawValue
        }
    }
    
    func getNextPage() async {
        guard hasMoreFollowers else { return }
        
        page += 1
        
        await getFollowers(for: username, page: page)
    }
    
    func selectFollower(_ follower: Follower) {
        selectedFollower = follower
    }
    
    func didTapGitHubFollowers(from username: String) async {
        selectedFollower = nil
        page = 1
        searchText = ""
        allFollowers.removeAll()
        
        await getFollowers(for: username, page: page)
    }
}
