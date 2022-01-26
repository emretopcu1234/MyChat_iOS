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
    
    
    var body: some View {
        NavigationView {
            if contentViewModel.loginActive {
                WelcomePageView()
            }
            else {
                GeneralView()
            }
        }
        .environmentObject(generalViewModel)
        .environmentObject(friendsViewModel)
        .environmentObject(profileViewModel)
        .environmentObject(chatsViewModel)
        .environmentObject(specificChatViewModel)
        .environmentObject(loginViewModel)
        .environmentObject(registerViewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(contentViewModel: ContentViewModel())
    }
}
