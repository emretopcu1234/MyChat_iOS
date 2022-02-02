//
//  ContentView.swift
//  MyChat
//
//  Created by Emre Topçu on 13.01.2022.
//

import SwiftUI

struct ContentView: View {
    
    let contentViewModel: ContentViewModel
    @StateObject var generalViewModel = GeneralViewModel()
    @StateObject var friendsViewModel = FriendsViewModel()
    @StateObject var profileViewModel = ProfileViewModel()
    @StateObject var chatsViewModel = ChatsViewModel()
    @StateObject var specificChatViewModel = SpecificChatViewModel()
    @StateObject var loginViewModel = LoginViewModel()
    @StateObject var registerViewModel = RegisterViewModel()
    
    @State private var isLoggedIn: Bool?
    
    var body: some View {
        NavigationView {
            if contentViewModel.loginActive {
                WelcomePageView()
            }
            else {
                if let isLoggedIn = isLoggedIn {
                    if isLoggedIn {
                        GeneralView()
                    }
                    else {
                        EmptyView()
                    }
                }
            }
        }
        .environmentObject(generalViewModel)
        .environmentObject(friendsViewModel)
        .environmentObject(profileViewModel)
        .environmentObject(chatsViewModel)
        .environmentObject(specificChatViewModel)
        .environmentObject(loginViewModel)
        .environmentObject(registerViewModel)
        .onAppear {
            if !contentViewModel.loginActive {
                if let isLoggedIn = isLoggedIn {
                    if !isLoggedIn {
                        contentViewModel.login()
                    }
                }
                else {
                    contentViewModel.login()
                }
            }
        }
        .onReceive(contentViewModel.$loginResult) { result in
            if result == LoginState.Successful {
                isLoggedIn = true
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(contentViewModel: ContentViewModel())
    }
}
