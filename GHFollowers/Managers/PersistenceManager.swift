//
//  PersistenceManager.swift
//  GHFollowers
//
//  Created by Vitor Capretz on 20/06/22.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    static func updateWith(favorite: Follower, actionType: PersistenceActionType) -> Result<[Follower], GFError> {
        let result = retrieveFavorites()
        
        switch result {
            case .success(let favorites):
                var retrievedFavorites = favorites
                
                switch actionType {
                    case .add:
                        guard !retrievedFavorites.contains(favorite) else {
                            return .failure(.alreadyInFavorites)
                        }
                        
                        retrievedFavorites.append(favorite)
                    case .remove:
                        retrievedFavorites.removeAll {
                            $0.login == favorite.login
                        }
                }
                
                let savedError = save(favorites: retrievedFavorites)
                
                if let error = savedError {
                    return .failure(error)
                }
                
                return .success(retrievedFavorites)
            case .failure(let error):
                return .failure(error)
        }
        
    }
    
    static func retrieveFavorites() -> Result<[Follower], GFError> {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            return .success([])
        }
        
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            return .success(favorites)
        } catch {
            return .failure(.unableToFavorite)
        }
    }
    
    static func save(favorites: [Follower]) -> GFError? {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
        } catch {
            return .unableToFavorite
        }
        
        return nil
    }
}
