//
//  FollowerView.swift
//  GHFollowers
//
//  Created by Vitor Capretz on 12/06/22.
//

import SwiftUI

struct FollowerView: View {
    var follower: Follower
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: follower.avatarUrl)) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                Image("avatar-placeholder")
                    .resizable()
                    .scaledToFit()
            }
            .cornerRadius(10)
            
            Text(follower.login)
                .multilineTextAlignment(.center)
                .font(.headline)
        }
        .padding()
    }
}

struct FollowerView_Previews: PreviewProvider {
    static var previews: some View {
        FollowerView(follower: Follower(id: 1, login: "vcapretz", avatarUrl: "https://github.com/vcapretz.png"))
    }
}
