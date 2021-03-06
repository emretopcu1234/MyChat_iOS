//
//  BottomBarView.swift
//  MyChat
//
//  Created by Emre Topçu on 19.01.2022.
//

import SwiftUI

enum BottomBarType {
    case friends
    case chats
    case profile
    case deleteFriend
    case deleteChat
}

struct BottomBarView: View {
    
    var bottomBarType: BottomBarType
    @EnvironmentObject var friendSelection: FriendSelection
    @EnvironmentObject var chatSelection: ChatSelection
    @State private var showDeleteFriendConfirmation = false
    @State private var showDeleteChatConfirmation = false
    @Binding var deleteFriendPressed: Bool
    @Binding var deleteChatPressed: Bool
    
    var body: some View {
        
        HStack(alignment: .center) {
            if bottomBarType == BottomBarType.friends || bottomBarType == BottomBarType.chats || bottomBarType == BottomBarType.profile {
                NavigationLink(destination: FriendsView()) {
                    VStack(spacing: 5) {
                        Image(systemName: "person.3.fill")
                            .scaleEffect(1.3)
                        Text("Friends")
                            .font(.system(size: 11))
                    }
                    .offset(y: 10)
                    .foregroundColor(bottomBarType == BottomBarType.friends ? .blue : .gray)
                }
                .disabled(bottomBarType == BottomBarType.friends)
                Spacer()
                NavigationLink(destination: ChatsView()) {
                    VStack(spacing: 5) {
                        Image(systemName: "message.fill")
                            .scaleEffect(1.3)
                        Text("Chats")
                            .font(.system(size: 11))
                    }
                    .offset(y: 10)
                    .foregroundColor(bottomBarType == BottomBarType.chats ? .blue : .gray)
                }
                .disabled(bottomBarType == BottomBarType.chats)
                Spacer()
                NavigationLink(destination: ProfileView()) {
                    VStack(spacing: 5) {
                        Image(systemName: "person.fill")
                            .scaleEffect(1.3)
                        Text("Profile")
                            .font(.system(size: 11))
                    }
                    .offset(y: 10)
                    .foregroundColor(bottomBarType == BottomBarType.profile ? .blue : .gray)
                }
                .disabled(bottomBarType == BottomBarType.profile)
            }
            else if bottomBarType == .deleteFriend {
                Spacer()
                Button {
                    UINavigationBar.setAnimationsEnabled(true)
                    showDeleteFriendConfirmation = true
                } label: {
                    Text("Delete")
                        .font(.title3)
                        .disabled(friendSelection.selectedFriends.isEmpty ? true : false)
                        .confirmationDialog("", isPresented: $showDeleteFriendConfirmation) {
                            Button("Delete", role: .destructive) {
                                deleteFriendPressed = true
                            }
                            Button("Cancel", role: .cancel) {
                            }
                        } message: {
                            Text("Are you sure you want to delete selected friends?")
                        }
                }
            }
            else {
                Spacer()
                Button {
                    UINavigationBar.setAnimationsEnabled(true)
                    showDeleteChatConfirmation = true
                } label: {
                    Text("Delete")
                        .font(.title3)
                        .disabled(chatSelection.selectedChats.isEmpty ? true : false)
                        .confirmationDialog("", isPresented: $showDeleteChatConfirmation) {
                            Button("Delete", role: .destructive) {
                                deleteChatPressed = true
                            }
                            Button("Cancel", role: .cancel) {
                            }
                        } message: {
                            Text("Are you sure you want to delete selected chats?")
                        }
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
        BottomBarView(bottomBarType: BottomBarType.deleteFriend, deleteFriendPressed: .constant(false), deleteChatPressed: .constant(false))
    }
}
