//
//  User.swift
//  GHFollowers
//
//  Created by Vitor Capretz on 10/06/22.
//

import Foundation

struct User: Identifiable, Codable {
    var id: Int
    let login: String
    let avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    let publicRepos: Int
    let publicGists: Int
    let htmlUrl: String
    let following: Int
    let followers: Int
    let createdAt: String
}
