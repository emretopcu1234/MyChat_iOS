//
//  FriendsTabView.swift
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
    
    let friendSelection = FriendSelection.shared
    var selectedFriends = [String]()
    
    var body: some View {
        VStack(spacing: 0) {
            TopBarView(topBarType: TopBarType.Friends, friendsEditPressed: $editPressed, chatsEditPressed: .constant(false), newChatSelected: .constant(false))
                .frame(height: 60)
//            ScrollViewReader { scrollIndex in
            ScrollView(showsIndicators: false) {
                ForEach(Array($friendsViewModel.friends.enumerated()), id: \.offset) { index, element in
                    FriendsRowView(friend: friendsViewModel.friends[index], anyFriendDragging: $anyFriendDragging, anyDragCancelled: $anyDragCancelled, editPressed: $editPressed, deletion: $singleDeletion, multipleDeletePressed: $multipleDeletePressed)
                        .id(index)
                }
            }
//                .onAppear {
//                    scrollIndex.scrollTo(12)
//                }
//            }
            BottomBarView(bottomBarType: editPressed ? BottomBarType.DeleteFriend : BottomBarType.Friends, deletePressed: $multipleDeletePressed)
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
    }
}

struct FriendsTabView_Previews: PreviewProvider {
    static var previews: some View {
        FriendsView()
    }
}
