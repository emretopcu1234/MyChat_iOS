//
//  GeneralView.swift
//  MyChat
//
//  Created by Emre Topçu on 12.01.2022.
//

import SwiftUI

struct GeneralView: View {
    
    init(){
        UITabBar.appearance().backgroundColor = UIColor(named: "DarkWhite")
    }
    
    var body: some View {
        NavigationView {
            TabView {
                FriendsTabView()
                    .tabItem {
                        Label("Friends", systemImage: "person.3.fill")
                    }
                ChatsTabView()
                    .tabItem {
                        Label("Chats", systemImage: "message.fill")
                    }
                ProfileTabView()
                    .tabItem {
                        Label("Profile", systemImage: "person.fill")
                    }
            }
        }
    }
}

struct GeneralView_Previews: PreviewProvider {
    static var previews: some View {
        GeneralView()
    }
}
