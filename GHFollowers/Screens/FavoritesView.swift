//
//  FavoritesView.swift
//  GHFollowers
//
//  Created by Vitor Capretz on 09/06/22.
//

import SwiftUI

struct FavoritesView: View {
    @State private var usernames: [String] = []
    
    @EnvironmentObject var favoritesViewModel: FavoritesViewModel
    
    var body: some View {
        NavigationStack(path: $usernames) {
            List {
                ForEach(favoritesViewModel.favorites) { favorite in
                    NavigationLink(value: favorite.login) {
                        HStack {
                            AsyncImage(url: URL(string: favorite.avatarUrl)) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                            } placeholder: {
                                Image("avatar-placeholder")
                                    .resizable()
                                    .scaledToFit()
                            }
                            .cornerRadius(10)
                            .frame(height: 60)
                            
                            Text(favorite.login)
                        }
                    }
                }
                .onDelete { indexSet in
                    favoritesViewModel.delete(atOffsets: indexSet)
                    favoritesViewModel.retrieveFavorites()
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Favorites")
            .navigationDestination(for: String.self) { username in
                FollowersView(username: username)
            }
        }
        .onAppear {
            favoritesViewModel.retrieveFavorites()
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        let favoritesVM = FavoritesViewModel()

        FavoritesView()
            .environmentObject(favoritesVM)
            .onAppear {
                favoritesVM.favorites = [
                    Follower(id: 1, login: "vcapretz", avatarUrl: "https://github.com/vcapretz.png"),
                    Follower(id: 2, login: "dhh", avatarUrl: "https://github.com/vcapretz.png"),
                    Follower(id: 3, login: "sallen0400  ", avatarUrl: "https://github.com/vcapretz.png"),
                ]
            }
    }
}
