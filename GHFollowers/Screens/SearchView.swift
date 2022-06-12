//
//  SearchView.swift
//  GHFollowers
//
//  Created by Vitor Capretz on 09/06/22.
//

import SwiftUI

struct SearchView: View {
    @Binding var usernames: [String]
    
    @ObservedObject var followerViewModel: FollowerViewModel
    
    @State private var alertToShow: IdentifiableAlert?
    
    var body: some View {
        VStack {
            Spacer()
            
            Image("gh-logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.horizontal, 60)
                .padding(.bottom, 40)
            
            TextField("Enter a username", text: $followerViewModel.username, onCommit: {
                navigateToFollowersView()
            })
                .frame(height: 50)
                .gfTextFieldStyle()
            
            Spacer()
            Spacer()
            
            Button {
                navigateToFollowersView()
            } label: {
                Text("Get Followers")
                    .padding()
                    .frame(height: 50)
                    .gfButtonStyle(backgroundColor: .green)
            }
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .alert(item: $alertToShow) { alertToShow in
            alertToShow.alert()
        }
    }
    
    private func navigateToFollowersView() {
        guard !followerViewModel.username.isEmpty else {
            showEmptyUsernameAlert()
            return
        }
        
        usernames.append(followerViewModel.username)
    }
    
    private func showEmptyUsernameAlert() {
        alertToShow = IdentifiableAlert(id: "empty-username") {
            Alert(
                title: Text("Empty username"),
                message: Text("Please enter a username. We need to know who to look for 😆."),
                dismissButton: .default(Text("Ok"))
            )
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        let followerViewModel = FollowerViewModel()
        
        return SearchView(usernames: .constant([]), followerViewModel: followerViewModel)
    }
}
