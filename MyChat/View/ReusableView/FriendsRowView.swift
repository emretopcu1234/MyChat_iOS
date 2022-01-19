//
//  FriendsRowView.swift
//  MyChat
//
//  Created by Emre Topçu on 12.01.2022.
//

import SwiftUI

struct FriendsRowView: View {
    
    @State var showFriendProfile = false
    
    var body: some View {
        VStack {
            Divider()
            Button {
                UINavigationBar.setAnimationsEnabled(true)
                showFriendProfile = true
            } label: {
                HStack {
                    Image(systemName: "person.circle")
                        .resizable()
                        .aspectRatio(1, contentMode: .fill)
                        .frame(width: 50, height: 50)
                    VStack {
                        Text("Michael Clooney")
                            .font(.title2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("last seen yesterday at 11:38")
                            .font(.system(size: 15))
                            .foregroundColor(Color("Gray"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
            .buttonStyle(PlainButtonStyle())
            .sheet(isPresented: $showFriendProfile) {
                FriendProfileView()
            }
        }
        .padding(.leading)
        .padding(.trailing)
    }
}

struct FriendsRowView_Previews: PreviewProvider {
    static var previews: some View {
        FriendsRowView()
    }
}
