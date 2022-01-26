//
//  ChatsTabView.swift
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
    @State var newChatSelected = false
    
    var body: some View {
        VStack(spacing: 0) {
            TopBarView(topBarType: TopBarType.Chats, friendsEditPressed: .constant(false), chatsEditPressed: $editPressed, newChatSelected: $newChatSelected)
                .frame(height: 60)
            ScrollView(showsIndicators: false) {
                ForEach(0 ..< 15) { item in
                    ChatsRowView(anyChatDragging: $anyChatDragging, anyDragCancelled: $anyDragCancelled, editPressed: $editPressed)
                }
            }
            BottomBarView(bottomBarType: editPressed ? BottomBarType.Delete : BottomBarType.Chats)
        }
        .padding(.top, CGFloat(UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0))
        .ignoresSafeArea(edges: .top)
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
        .onAppear {
            UINavigationBar.setAnimationsEnabled(false)
        }
    }
}

struct ChatsTabView_Previews: PreviewProvider {
    static var previews: some View {
        ChatsView()
    }
}
