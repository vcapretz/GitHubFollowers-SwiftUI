//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Vitor Capretz on 10/06/22.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    let baseUrl = "https://api.github.com"
    
    private init() {}
    
    func getFollowers(for username: String, page: Int) async -> Result<[Follower], GFError> {
        let endpoint = baseUrl + "/users/\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            return .failure(.invalidUsername)
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let response = response as? HTTPURLResponse, response.statusCode < 300 else {
                return .failure(.invalidResponse)
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let followers = try decoder.decode([Follower].self, from: data)
            
            return .success(followers)
        } catch {
            return .failure(.unableToComplete)
        }
    }
}
