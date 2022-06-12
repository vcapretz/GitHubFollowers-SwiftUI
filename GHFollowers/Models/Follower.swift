//
//  Follower.swift
//  GHFollowers
//
//  Created by Vitor Capretz on 10/06/22.
//

import Foundation

struct Follower: Identifiable, Codable, Hashable {
    var id: Int
    var login: String
    var avatarUrl: String
}
