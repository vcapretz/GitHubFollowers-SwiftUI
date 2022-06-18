//
//  GFItemInfoView.swift
//  GHFollowers
//
//  Created by Vitor Capretz on 18/06/22.
//

import SwiftUI

enum ItemInfoTypes {
    case repos, gists, followers, following
}

struct GFItemInfoView: View {
    var itemType: ItemInfoTypes
    var count: Int
    
    var label: String {
        switch itemType {
            case .repos:
                return "Public Repos"
            case .gists:
                return "Public Gists"
            case .followers:
                return "Followers"
            case .following:
                return "Following"
        }
    }
    
    var image: String {
        switch itemType {
            case .repos:
                return SFSymbols.repos
            case .gists:
                return SFSymbols.gists
            case .followers:
                return SFSymbols.followers
            case .following:
                return SFSymbols.following
        }
    }
    
    var body: some View {
        VStack {
            Label(label, systemImage: image)
            Text("\(count)")
        }
        .fontWeight(.bold)
        .font(.subheadline)
    }
}

struct GFItemInfoView_Previews: PreviewProvider {
    static var previews: some View {
        GFItemInfoView(itemType: .gists, count: 10)
    }
}
