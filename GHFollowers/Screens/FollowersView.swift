//
//  FollowersView.swift
//  GHFollowers
//
//  Created by Vitor Capretz on 09/06/22.
//

import SwiftUI

struct FollowersView: View {
    var username: String
    
    @ObservedObject var followerViewModel: FollowerViewModel
    
    @State private var alertToShow: IdentifiableAlert?
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [.init(.flexible()), .init(.flexible()), .init(.flexible())]) {
                ForEach(followerViewModel.followers) { follower in
                    FollowerView(follower: follower)
                }
            }
        }
            .navigationTitle(username)
            .navigationBarTitleDisplayMode(.large)
            .onChange(of: followerViewModel.errorMessage, perform: { newValue in
                if newValue.isEmpty {
                    alertToShow = nil
                } else {
                    alertToShow = IdentifiableAlert(id: "request-error") {
                        Alert(
                            title: Text("Error"),
                            message: Text(newValue),
                            dismissButton: .default(Text("Ok"))
                        )
                    }
                }
            })
            .task {
                await followerViewModel.getFollowers()
            }
            .alert(item: $alertToShow) { alertToShow in
                alertToShow.alert()
            }
    }
}

struct FollowersView_Previews: PreviewProvider {
    static var previews: some View {
        @StateObject var followerViewModel = FollowerViewModel()
        
        return NavigationStack {
            FollowersView(username: "vcapretz", followerViewModel: followerViewModel)
        }
    }
}
