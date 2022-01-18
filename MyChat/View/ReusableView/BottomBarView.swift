//
//  BottomBarView.swift
//  MyChat
//
//  Created by Emre Topçu on 19.01.2022.
//

import SwiftUI

enum BottomBarType {
    case Friends
    case Chats
    case Profile
}

struct BottomBarView: View {
    
    var bottomBarType: BottomBarType
    
    var body: some View {
        HStack(alignment: .center) {
            NavigationLink(destination: FriendsTabView()) {
                VStack(spacing: 5) {
                    Image(systemName: "person.3.fill")
                        .scaleEffect(1.3)
                    Text("Friends")
                        .font(.system(size: 11))
                }
                .offset(y: 10)
                .foregroundColor(bottomBarType == BottomBarType.Friends ? .blue : .gray)
            }
            Spacer()
            NavigationLink(destination: ChatsTabView()) {
                VStack(spacing: 5) {
                    Image(systemName: "message.fill")
                        .scaleEffect(1.3)
                    Text("Chats")
                        .font(.system(size: 11))
                }
                .offset(y: 10)
                .foregroundColor(bottomBarType == BottomBarType.Chats ? .blue : .gray)
            }
            Spacer()
            NavigationLink(destination: ProfileTabView()) {
                VStack(spacing: 5) {
                    Image(systemName: "person.fill")
                        .scaleEffect(1.3)
                    Text("Profile")
                        .font(.system(size: 11))
                }
                .offset(y: 10)
                .foregroundColor(bottomBarType == BottomBarType.Profile ? .blue : .gray)
            }
        }
        .frame(height: 55)
        .padding(.leading, 40)
        .padding(.trailing, 40)
        .background(Color("DarkWhite"))
        .ignoresSafeArea(.keyboard)
    }
}

struct BottomBarView_Previews: PreviewProvider {
    static var previews: some View {
        BottomBarView(bottomBarType: BottomBarType.Chats)
    }
}
