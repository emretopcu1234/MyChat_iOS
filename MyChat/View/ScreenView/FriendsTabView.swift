//
//  FriendsTabView.swift
//  MyChat
//
//  Created by Emre Topçu on 12.01.2022.
//

import SwiftUI

struct FriendsTabView: View {
    
    @State var editPressed: Bool? = false
    
    var body: some View {
        VStack(spacing: 0) {
            TopBarView(topBarType: TopBarType.Friends, friendsEditPressed: $editPressed, chatsEditPressed: .constant(nil))
                .frame(height: 60)
            ScrollView(showsIndicators: false) {
                ForEach(0 ..< 15) { item in
                    FriendsRowView(editPressed: $editPressed)
                }
            }
            BottomBarView(bottomBarType: BottomBarType.Friends)
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

struct FriendsTabView_Previews: PreviewProvider {
    static var previews: some View {
        FriendsTabView()
    }
}
