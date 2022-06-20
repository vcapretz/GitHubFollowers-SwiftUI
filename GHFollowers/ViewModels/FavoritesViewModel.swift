//
//  FavoritesViewModel.swift
//  GHFollowers
//
//  Created by Vitor Capretz on 20/06/22.
//

import Foundation

@MainActor class FavoritesViewModel: ObservableObject {
    @Published var favorites: [Follower] = []
    @Published var errorMessage: String = ""
    @Published var successMessage: String = ""
    
    func add(username: String) async {
        let result = await NetworkManager.shared.getUserInfo(for: username)
        
        switch result {
            case .success(let user):
                let favorite = Follower(
                    id: user.id,
                    login: user.login,
                    avatarUrl: user.avatarUrl
                )
                
                let updatedResult = PersistenceManager.updateWith(favorite: favorite, actionType: .add)
                
                switch updatedResult {
                    case .success(let newFavorites):
                        favorites = newFavorites
                        successMessage = "You added \(user.login) to your favorites list."
                    case .failure(let error):
                        errorMessage = error.rawValue
                }
            case .failure(let error):
                errorMessage = error.rawValue
        }
    }
    
    func delete(atOffsets indexSet: IndexSet) {
        guard let indexToBeRemoved = indexSet.first else { return }
        let favorite = favorites[indexToBeRemoved]
        
        let result = PersistenceManager.updateWith(favorite: favorite, actionType: .remove)
        
        switch result {
            case .success:
                break
            case .failure(let error):
                errorMessage = error.rawValue
        }
    }
    
    func retrieveFavorites() {
        let result = PersistenceManager.retrieveFavorites()
        
        switch result {
            case .success(let newFavorites):
                favorites  = newFavorites
            case .failure(let error):
                errorMessage = error.rawValue
        }
    }
}
