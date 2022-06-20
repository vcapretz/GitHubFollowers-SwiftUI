//
//  FollowersView.swift
//  GHFollowers
//
//  Created by Vitor Capretz on 09/06/22.
//

import SwiftUI

struct FollowersView: View {
    var username: String
    
    @StateObject var followerViewModel = FollowerViewModel()
    @EnvironmentObject var favoritesViewModel: FavoritesViewModel
    @State private var alertToShow: IdentifiableAlert?
    
    var body: some View {
        ZStack {
            if followerViewModel.searchText.isEmpty && !followerViewModel.isLoading && followerViewModel.followers.isEmpty {
                GFEmptyView(message: "This user doesn't have any followers. Go follow them 😄.")
            } else {
                followersList
            }
            
            if followerViewModel.isLoading {
                Color(uiColor: .systemBackground)
                    .opacity(0.8)
                
                ProgressView()
                    .scaleEffect(2)
            }
        }
        .navigationTitle(followerViewModel.username)
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    Task {
                        await favoritesViewModel.add(username: followerViewModel.username)
                    }
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .onChange(of: followerViewModel.errorMessage, perform: { newValue in
            if newValue.isEmpty {
                alertToShow = nil
                return
            }
            
            alertToShow = IdentifiableAlert(id: "request-error") {
                Alert(
                    title: Text("Error"),
                    message: Text(newValue),
                    dismissButton: .default(Text("Ok"))
                )
            }
        })
        .onChange(of: favoritesViewModel.successMessage, perform: { newValue in
            if newValue.isEmpty {
                alertToShow = nil
                return
            }
            
            alertToShow = IdentifiableAlert(id: "added-favorites") {
                Alert(
                    title: Text("Success"),
                    message: Text(newValue),
                    dismissButton: .default(Text("Ok"))
                )
            }
        })
        .onChange(of: favoritesViewModel.errorMessage, perform: { newValue in
            if newValue.isEmpty {
                alertToShow = nil
                return
            }
            
            alertToShow = IdentifiableAlert(id: "failed-to-add-favorites") {
                Alert(
                    title: Text("Something went wrong"),
                    message: Text(newValue),
                    dismissButton: .default(Text("Ok"))
                )
            }
        })
        .task {
            await followerViewModel.getFollowers(for: username, page: followerViewModel.page)
        }
        .alert(item: $alertToShow) { alertToShow in
            alertToShow.alert()
        }
        .sheet(item: $followerViewModel.selectedFollower) { follower in
            FollowerDetailView(follower: follower)
                .environmentObject(followerViewModel)
        }
    }
    
    var followersList: some View {
        ScrollView {
            LazyVGrid(columns: [.init(.flexible()), .init(.flexible()), .init(.flexible())]) {
                ForEach(followerViewModel.followers) { follower in
                    if follower == followerViewModel.followers.last {
                        FollowerView(follower: follower)
                            .task {
                                if followerViewModel.searchText.isEmpty {
                                    await followerViewModel.getNextPage()
                                }
                            }
                            .onTapGesture {
                                followerViewModel.selectFollower(follower)
                            }
                    } else {
                        FollowerView(follower: follower)
                            .onTapGesture {
                                followerViewModel.selectFollower(follower)
                            }
                    }
                }
            }
        }
        .searchable(text: $followerViewModel.searchText)
    }
}

struct FollowersView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            FollowersView(username: "vcapretz")
        }
    }
}
