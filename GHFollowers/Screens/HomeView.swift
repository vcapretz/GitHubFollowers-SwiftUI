//
//  ContentView.swift
//  GHFollowers
//
//  Created by Vitor Capretz on 09/06/22.
//

import SwiftUI

struct HomeView: View {
    @State private var usernames: [String] = []
    @StateObject var followerViewModel = FollowerViewModel()
    
    var body: some View {
        VStack {
            TabView {
                NavigationStack(path: $usernames) {
                    SearchView(usernames: $usernames, followerViewModel: followerViewModel)
                        .navigationDestination(for: String.self) { username in
                            FollowersView(username: username, followerViewModel: followerViewModel)
                        }
                }
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }
                    .tag(0)
                
                FavoritesView()
                    .tabItem {
                        Label("Favorites", systemImage: "star.fill")
                    }
                    .tag(1)
            }
            .accentColor(.green)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
