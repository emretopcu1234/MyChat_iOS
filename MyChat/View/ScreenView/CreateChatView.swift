//
//  CreateChatView.swift
//  MyChat
//
//  Created by Emre Topçu on 23.01.2022.
//

import SwiftUI

struct CreateChatView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var friendsViewModel: FriendsViewModel
    
    @Binding var newChatSelected: Bool
    @Binding var mobile: String
    
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Cancel")
                            .font(.title3)
                            .padding(.leading)
                    }
                    Spacer()
                }
                Spacer()
                Text("New Chat")
                    .font(.system(size: 22))
                    .bold()
                Spacer()
            }
            .frame(height: 40)
            ScrollView(showsIndicators: false) {
                ForEach($friendsViewModel.friends) { friend in
                    CreateChatRowView(friend: friend, newChatSelected: $newChatSelected, mobile: $mobile)
                }
            }
            .padding(.bottom, 100)
        }
        .frame(width: UIScreen.self.main.bounds.width, height: UIScreen.self.main.bounds.height)
        .padding(.top, CGFloat(UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0))
        .offset(y: 50)
        .ignoresSafeArea(edges: .top)
        .background(Color("DarkWhite"))
        .onAppear {
            UINavigationBar.setAnimationsEnabled(true)
            newChatSelected = false
        }
    }
}

struct CreateChatView_Previews: PreviewProvider {
    static var previews: some View {
        CreateChatView(newChatSelected: .constant(false), mobile: .constant(""))
    }
}
