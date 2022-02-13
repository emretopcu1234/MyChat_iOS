//
//  ChatsView.swift
//  MyChat
//
//  Created by Emre Topçu on 12.01.2022.
//

import SwiftUI

struct ChatsView: View {
    
    @EnvironmentObject var chatsViewModel: ChatsViewModel
    
    @State var anyDragCancelled = true
    @State var anyChatDragging = false
    @State var editPressed = false
    @State var multipleDeletePressed = false
    @State var singleDeletion: String = ""
    @State var newChatSelected = false
    @State var enteredChatMobile: String = ""
//    @State var friendCreationMobile: String = ""
//    @State var friendCreationResult: CreateFriendState? = nil
    
    let chatSelection = ChatSelection.shared
    let selectedChats = [String]()
    
    var body: some View {
        VStack(spacing: 0) {
            TopBarView(topBarType: TopBarType.Chats, friendsEditPressed: .constant(false), chatsEditPressed: $editPressed, newChatSelected: $newChatSelected, friendCreationMobile: .constant(""), friendCreationResult: .constant(nil))
                .frame(height: 60)
            ScrollView(showsIndicators: false) {
                ForEach($chatsViewModel.chats) { chat in
                    ChatsRowView(chat: chat, anyChatDragging: $anyChatDragging, anyDragCancelled: $anyDragCancelled, editPressed: $editPressed, deletion: $singleDeletion, multipleDeletePressed: $multipleDeletePressed)
                }
            }
            BottomBarView(bottomBarType: editPressed ? BottomBarType.DeleteChat : BottomBarType.Chats, deleteFriendPressed: .constant(false), deleteChatPressed: $multipleDeletePressed)
        }
        .padding(.top, CGFloat(UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0))
        .ignoresSafeArea(edges: .top)
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
        .onAppear {
            UINavigationBar.setAnimationsEnabled(false)
            chatsViewModel.getData()
        }
        .onChange(of: editPressed) { _ in
            chatSelection.clearSelection()
        }
        .onChange(of: singleDeletion) { deletion in
            if deletion.count > 0 {
                chatsViewModel.deleteChat(id: deletion)
            }
        }
        .onChange(of: multipleDeletePressed) { pressed in
            if pressed {
                chatsViewModel.deleteChats(id: chatSelection.selectedChats)
                chatSelection.clearSelection()
                multipleDeletePressed = false
                withAnimation {
                    editPressed = false
                }
            }
        }
//        .onChange(of: friendCreationMobile) { mobile in
//            if mobile.count > 0 {
//                friendsViewModel.createFriend(mobile: mobile)
//            }
//        }
//        .onReceive(friendsViewModel.$createFriendState) { state in
//            friendCreationResult = state
//        }
    }
}

struct ChatsTabView_Previews: PreviewProvider {
    static var previews: some View {
        ChatsView()
    }
}
