//
//  ChatsRowView.swift
//  MyChat
//
//  Created by Emre Topçu on 13.01.2022.
//

import SwiftUI

struct ChatsRowView: View {
    
    let chatOperations = ChatSelection.shared
    
    @State private var image = UIImage()
    @State private var imageUrl = URL(string: "")
    @State private var enterChat: Bool?
    @State private var offsetDelete = CGSize.zero
    @State private var chatSelected = false
    @State private var showDeleteConfirmation = false
    
    @Binding var chat: ChatType
    @Binding var anyChatDragging: Bool
    @Binding var anyDragCancelled: Bool
    @Binding var editPressed: Bool
    @Binding var deletion: String
    @Binding var multipleDeletePressed: Bool
    
    var body: some View {
        ZStack {
            VStack {
                Divider()
                NavigationLink(destination: SpecificChatView(mobile: chat.mobile), tag: true, selection: $enterChat) {
                    Button {
                        if editPressed {
                            chatSelected.toggle()
                            if chatSelected {
                                chatOperations.addSelection(selectedChat: chat.id)
                            }
                            else {
                                chatOperations.removeSelection(removedChat: chat.id)
                            }
                        }
                        else {
                            if anyDragCancelled {
                                UINavigationBar.setAnimationsEnabled(true)
                                enterChat = true
                            }
                            else {
                                withAnimation {
                                    anyDragCancelled = true
                                }
                            }
                        }
                    } label: {
                        HStack {
                            if imageUrl == URL(string: ""){
                                Image(systemName: "person.circle")
                                    .resizable()
                                    .aspectRatio(1, contentMode: .fill)
                                    .frame(width: 60, height: 60)
                            }
                            else {
                                AsyncImage(url: imageUrl) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(1, contentMode: .fill)
                                        .frame(width: 60, height: 60)
                                        .clipShape(Circle())
                                } placeholder: {
                                    Image(systemName: "person.circle")
                                        .resizable()
                                        .aspectRatio(1, contentMode: .fill)
                                        .frame(width: 60, height: 60)
                                }
                            }
                            VStack {
                                Text(chat.name == "" ? chat.mobile : chat.name)
                                    .font(.title2)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Text(chat.messages[chat.messages.count-1].message)
                                    .font(.system(size: 15))
                                    .foregroundColor(Color("Gray"))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .lineLimit(2)
                            }
                            Spacer()
                            VStack(alignment: .trailing, spacing: 5) {
                                Text(chat.lastMessageTime.stringFormattedLastMessageTime())
                                    .font(.system(size: 15))
                                    .foregroundColor(Color("Gray"))
                                    .frame(width: 80, alignment: .trailing)
                                ZStack {
                                    Image(systemName: "circle.fill")
                                        .scaleEffect(1.5)
                                        .foregroundColor(chat.unreadMessageNumber > 0 ? .blue : .white)
                                    Text(String(chat.unreadMessageNumber))
                                        .foregroundColor(.white)
                                }
                                .padding(EdgeInsets.init(top: 3, leading: 0, bottom: 0, trailing: 3))
                            }
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding(EdgeInsets.init(top: 0, leading: 10, bottom: 5, trailing: 10))
            .offset(x: editPressed ? 50 : min(0, offsetDelete.width))
            .background(chatSelected ? Color("LightBlue") : .white)
            .gesture(
                DragGesture()
                    .onChanged{ gesture in
                        if !editPressed {
                            withAnimation {
                                offsetDelete.width = max(-70, gesture.translation.width)
                                anyChatDragging = true
                                anyDragCancelled = false
                            }
                        }
                    }
                    .onEnded{ _ in
                        if offsetDelete.width < -50 && !editPressed {
                            withAnimation {
                                offsetDelete.width = -70
                                anyChatDragging = false
                            }
                        }
                        else {
                            withAnimation {
                                offsetDelete.width = 0
                                anyChatDragging = false
                            }
                        }
                    }
            )
            .onTapGesture {
                if editPressed{
                    chatSelected.toggle()
                    if chatSelected {
                        chatOperations.addSelection(selectedChat: chat.id)
                    }
                    else {
                        chatOperations.removeSelection(removedChat: chat.id)
                    }
                }
                else {
                    withAnimation {
                        anyDragCancelled = true
                    }
                }
            }
            
            HStack {
                Image(systemName: chatSelected ? "checkmark.circle.fill" : "circle")
                    .resizable()
                    .aspectRatio(1, contentMode: .fill)
                    .frame(width: 20, height: 20)
                    .padding()
                    .offset(x: editPressed ? 0 : -50, y: 5)
                    .foregroundColor(.blue)
                    .onTapGesture {
                        chatSelected.toggle()
                }
                Spacer()
            }
            
            Button {
                UINavigationBar.setAnimationsEnabled(true)
                showDeleteConfirmation = true
            } label: {
                HStack {
                    Spacer()
                    VStack {
                        Spacer()
                        Text("Delete")
                            .font(.system(size: 15))
                            .foregroundColor(.white)
                            .confirmationDialog("", isPresented: $showDeleteConfirmation) {
                                Button("Delete", role: .destructive) {
                                    anyDragCancelled = true
                                    deletion = chat.id
                                }
                                Button("Cancel", role: .cancel) {
                                    anyDragCancelled = true
                                }
                            } message: {
                                Text(chat.name == "" ? "Are you sure you want to delete the chat with the user with mobile \(chat.mobile)?" : "Are you sure you want to delete the chat with \(chat.name)?")
                            }
                        Spacer()
                    }
                    .frame(width: 70)
                    .background(.red)
                }
            }
            .padding(.bottom, -7)
            .buttonStyle(PlainButtonStyle())
            .offset(x: offsetDelete.width + 70)
        }
        .padding(.bottom, -5)
        .background(chatSelected ? Color("LightBlue") : .white)
        .onAppear(perform: {
            imageUrl = URL(string: chat.pictureUrl ?? "")
        })
        .onChange(of: editPressed) { pressed in
            withAnimation {
                offsetDelete.width = 0
            }
            if !pressed {
                chatSelected = false
            }
        }
        .onChange(of: anyChatDragging) { dragging in
            if dragging && offsetDelete.width == -70 {  // that means, current chat is already dragged (because its offset is -70), so at the moment there is another chat dragging, and therefore this chat should be undragged.
                withAnimation {
                    offsetDelete.width = 0
                }
            }
        }
        .onChange(of: anyDragCancelled) { cancelled in
            if cancelled {
                withAnimation {
                    offsetDelete.width = 0
                }
            }
        }
        .onChange(of: multipleDeletePressed) { _ in
            chatSelected = false
        }
    }
}

struct ChatsRowView_Previews: PreviewProvider {
    static var previews: some View {
        ChatsRowView(chat: .constant(ChatType(id: "", mobile: "", name: "", email: "", pictureUrl: nil, lastSeen: 0, lastMessage: "", lastMessageTime: 0, unreadMessageNumber: 0, messages: [MessageType]())), anyChatDragging: .constant(false), anyDragCancelled: .constant(true), editPressed: .constant(false), deletion: .constant(""), multipleDeletePressed: .constant(false))
    }
}
