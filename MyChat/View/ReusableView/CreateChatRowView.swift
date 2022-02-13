//
//  CreateChatRowView.swift
//  MyChat
//
//  Created by Emre Topçu on 23.01.2022.
//

import SwiftUI

struct CreateChatRowView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var image = UIImage()
    @State private var imageUrl = URL(string: "")
    
    @Binding var friend: FriendType
    @Binding var newChatSelected: Bool
    @Binding var mobile: String
    
    var body: some View {
        ZStack {
            VStack {
                Divider()
                Button {
                    presentationMode.wrappedValue.dismiss()
                    mobile = friend.mobile
                    newChatSelected = true
                } label: {
                    HStack {
                        if imageUrl == URL(string: ""){
                            Image(systemName: "person.circle")
                                .resizable()
                                .aspectRatio(1, contentMode: .fill)
                                .frame(width: 50, height: 50)
                        }
                        else {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(1, contentMode: .fill)
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                        }
                        VStack {
                            Text(friend.name == "" ? friend.mobile : friend.name)
                                .font(.title2)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text(friend.lastSeen.stringFormattedLastSeen())
                                .font(.system(size: 15))
                                .foregroundColor(Color("Gray"))
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }
                .padding(EdgeInsets.init(top: 0, leading: 10, bottom: 0, trailing: 10))
                .buttonStyle(PlainButtonStyle())
            }
            .padding(.bottom, 5)
            .background(.white)
        }
        .padding(.bottom, -7)
        .background(.white)
        .onAppear {
            UINavigationBar.setAnimationsEnabled(false)
            imageUrl = URL(string: friend.pictureUrl ?? "")
            if imageUrl != URL(string: "") {
                let data = try? Data(contentsOf: imageUrl!)
                image = UIImage(data: data!)!
            }
        }
    }
}

struct CreateChatRowView_Previews: PreviewProvider {
    static var previews: some View {
        CreateChatRowView(friend: .constant(FriendType(mobile: "", name: "", email: "", lastSeen: 0, pictureUrl: nil)), newChatSelected: .constant(false), mobile: .constant(""))
    }
}
