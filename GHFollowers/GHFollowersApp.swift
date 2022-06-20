//
//  GHFollowersApp.swift
//  GHFollowers
//
//  Created by Vitor Capretz on 09/06/22.
//

import SwiftUI

@main
struct GHFollowersApp: App {
    @StateObject var favoritesViewModel = FavoritesViewModel()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(favoritesViewModel)
        }
    }
}
