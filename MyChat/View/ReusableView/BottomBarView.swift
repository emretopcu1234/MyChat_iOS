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
    case Delete
}

struct BottomBarView: View {
    
    var bottomBarType: BottomBarType
    
    var body: some View {
        
        HStack(alignment: .center) {
            if bottomBarType != BottomBarType.Delete {
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
                .disabled(bottomBarType == BottomBarType.Friends)
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
                .disabled(bottomBarType == BottomBarType.Chats)
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
                .disabled(bottomBarType == BottomBarType.Profile)
            }
            else {
                Spacer()
                Button {
                    // TODO
                } label: {
                    Text("Delete")
                        .font(.title3)
                        .disabled(true)
                }
            }
        }
        .frame(height: 55)
        .padding(EdgeInsets.init(top: 0, leading: 40, bottom: 0, trailing: 40))
        .background(Color("DarkWhite"))
        .ignoresSafeArea(.keyboard)
    }
}

struct BottomBarView_Previews: PreviewProvider {
    static var previews: some View {
        BottomBarView(bottomBarType: BottomBarType.Delete)
    }
}
