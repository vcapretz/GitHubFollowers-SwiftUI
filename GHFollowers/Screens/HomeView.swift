//
//  ContentView.swift
//  GHFollowers
//
//  Created by Vitor Capretz on 09/06/22.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            TabView {
                SearchView()
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
