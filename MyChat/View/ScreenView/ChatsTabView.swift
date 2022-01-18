//
//  ChatsTabView.swift
//  MyChat
//
//  Created by Emre Topçu on 12.01.2022.
//

import SwiftUI

struct ChatsTabView: View {
    
    var body: some View {
        VStack(spacing: 0) {
            TopBarView(topBarType: TopBarType.Chats)
                .frame(height: 60)
            ScrollView(showsIndicators: false) {
                ForEach(0 ..< 15) { item in
                    ChatsRowView()
                }
            }
            Spacer()
        }
        .padding(.top, CGFloat(UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0))
        .ignoresSafeArea(edges: .top)
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
    }
}

struct ChatsTabView_Previews: PreviewProvider {
    static var previews: some View {
        ChatsTabView()
    }
}
