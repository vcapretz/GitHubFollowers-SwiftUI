//
//  FollowersView.swift
//  GHFollowers
//
//  Created by Vitor Capretz on 09/06/22.
//

import SwiftUI

struct FollowersView: View {
    var username: String
    
    var body: some View {
        Text("Followers")
            .navigationTitle(username)
            .navigationBarTitleDisplayMode(.large)
    }
}

struct FollowersView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            FollowersView(username: "vcapretz")
        }
    }
}
