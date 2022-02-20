//
//  FriendsView.swift
//  MyChat
//
//  Created by Emre Topçu on 12.01.2022.
//

import SwiftUI

struct FriendsView: View {
    
    @EnvironmentObject var friendsViewModel: FriendsViewModel
    
    @State var anyDragCancelled = true
    @State var anyFriendDragging = false
    @State var editPressed = false
    @State var multipleDeletePressed = false
    @State var singleDeletion: String = ""
    @State var friendCreationMobile: String = ""
    @State var friendCreationResult: CreateFriendState? = nil
    
    let friendSelection = FriendSelection.shared
    var selectedFriends = [String]()
    
    var body: some View {
        VStack(spacing: 0) {
            TopBarView(topBarType: TopBarType.friends, friendsEditPressed: $editPressed, chatsEditPressed: .constant(false), newChatSelected: .constant(false), chatInfo: .constant(ChatType(id: "", mobile: "", name: "", pictureUrl: nil, lastSeen: 0, lastMessage: "", lastMessageTime: 0, unreadMessageNumber: 0, messages: [MessageType]())), friendCreationMobile: $friendCreationMobile, friendCreationResult: $friendCreationResult)
                .frame(height: 60)
            ScrollView(showsIndicators: false) {
                ForEach($friendsViewModel.friends) { friend in
                    FriendsRowView(friend: friend, anyFriendDragging: $anyFriendDragging, anyDragCancelled: $anyDragCancelled, editPressed: $editPressed, deletion: $singleDeletion, multipleDeletePressed: $multipleDeletePressed)
                }
            }
            BottomBarView(bottomBarType: editPressed ? BottomBarType.deleteFriend : BottomBarType.friends, deleteFriendPressed: $multipleDeletePressed, deleteChatPressed: .constant(false))
        }
        .padding(.top, CGFloat(UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0))
        .ignoresSafeArea(edges: .top)
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
        .onAppear {
            UINavigationBar.setAnimationsEnabled(false)
            friendsViewModel.getData()
        }
        .onChange(of: editPressed) { _ in
            friendSelection.clearSelection()
        }
        .onChange(of: singleDeletion) { deletion in
            if deletion.count > 0 {
                friendsViewModel.deleteFriend(mobile: deletion)
            }
        }
        .onChange(of: multipleDeletePressed) { pressed in
            if pressed {
                friendsViewModel.deleteFriends(mobile: friendSelection.selectedFriends)
                friendSelection.clearSelection()
                multipleDeletePressed = false
                withAnimation {
                    editPressed = false
                }
            }
        }
        .onChange(of: friendCreationMobile) { mobile in
            if mobile.count > 0 {
                friendsViewModel.createFriend(mobile: mobile)
            }
        }
        .onReceive(friendsViewModel.$createFriendState) { state in
            friendCreationResult = state
        }
    }
}

struct FriendsTabView_Previews: PreviewProvider {
    static var previews: some View {
        FriendsView()
    }
}
