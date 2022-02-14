//
//  TopBarView.swift
//  MyChat
//
//  Created by Emre Topçu on 12.01.2022.
//

import SwiftUI

enum TopBarType {
    case Friends
    case Chats
    case SpecificChat
    case Profile
}

struct TopBarView: View {
    
    var topBarType: TopBarType
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var showCreateFriendView = false
    @State private var showCreateChatView = false
    @State private var enterChat: Bool?
    @State var enterChatMobile: String = ""
    
    @Binding var friendsEditPressed: Bool
    @Binding var chatsEditPressed: Bool
    @Binding var newChatSelected: Bool
    @Binding var chatInfo: ChatType
    @Binding var friendCreationMobile: String
    @Binding var friendCreationResult: CreateFriendState?
    
    var body: some View {
        
        HStack {
            switch topBarType {
            case .Friends:
                ZStack {
                    HStack {
                        Spacer()
                        Text("Friends")
                            .font(.title2)
                        Spacer()
                    }
                    HStack {
                        Button {
                            withAnimation {
                                friendsEditPressed.toggle()
                            }
                        } label: {
                            if !friendsEditPressed {
                                Text("Edit")
                                    .font(.title3)
                                    .padding()
                            }
                            else {
                                Text("Done")
                                    .font(.title3)
                                    .bold()
                                    .padding()
                            }
                        }
                        Spacer()
                        Button {
                            UINavigationBar.setAnimationsEnabled(true)
                            friendCreationMobile = ""
                            showCreateFriendView = true
                        } label: {
                            Image(systemName: "plus")
                                .scaleEffect(1.5)
                                .padding()
                        }
                        .disabled(friendsEditPressed ? true : false)
                        .sheet(isPresented: $showCreateFriendView) {
                            CreateFriendView(mobile: $friendCreationMobile, result: $friendCreationResult)
                        }
                    }
                }
            case .Chats:
                ZStack {
                    HStack {
                        Spacer()
                        Text("Chats")
                            .font(.title2)
                        Spacer()
                    }
                    HStack {
                        Button {
                            withAnimation {
                                chatsEditPressed.toggle()
                            }
                        } label: {
                            if !chatsEditPressed {
                                Text("Edit")
                                    .font(.title3)
                                    .padding()
                            }
                            else {
                                Text("Done")
                                    .font(.title3)
                                    .bold()
                                    .padding()
                            }
                        }
                        Spacer()
                        NavigationLink(destination: SpecificChatView(mobile: enterChatMobile), tag: true, selection: $enterChat) {
                            Button {
                                UINavigationBar.setAnimationsEnabled(true)
                                showCreateChatView = true
                            } label: {
                                Image(systemName: "square.and.pencil")
                                    .scaleEffect(1.5)
                                    .padding()
                            }
                            .disabled(chatsEditPressed ? true : false)
                            .sheet(isPresented: $showCreateChatView) {
                                CreateChatView(newChatSelected: $newChatSelected, mobile: $enterChatMobile)
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .onChange(of: newChatSelected) { chatSelected in
                    if chatSelected {
                        enterChat = true
                    }
                }
            case .SpecificChat:
                ZStack {
                    HStack {
                        Spacer()
                        VStack {
                            Text(chatInfo.name == "" ? chatInfo.mobile : chatInfo.name)
                                .font(.title2)
                            Text(chatInfo.name == "" ? "" : chatInfo.lastSeen.stringFormattedLastSeen())
                                .font(.system(size: 15))
                                .foregroundColor(Color("Gray"))
                        }
                        Spacer()
                    }
                    HStack {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "chevron.left")
                                .scaleEffect(1.5)
                                .padding()
                        }
                        Spacer()
                        Image(systemName: "person.circle")
                            .resizable()
                            .aspectRatio(1, contentMode: .fill)
                            .frame(width: 50, height: 50)
                            .padding()
                            .onTapGesture {
                                // TODO
                            }
                    }
                }
            case .Profile:
                VStack {
                    HStack {
                        Spacer()
                        Text("Profile")
                            .font(.title2)
                        Spacer()
                    }
                    Divider()
                        .padding(EdgeInsets.init(top: 0, leading: 10, bottom: 0, trailing: 10))
                }
            }
        }
        .frame(height: 60)
        .background(Color("DarkWhite"))
        .padding(.top, CGFloat(UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0))
        .ignoresSafeArea(edges: .top)
    }
}

struct TopBarView_Previews: PreviewProvider {
    static var previews: some View {
        TopBarView(topBarType: TopBarType.Friends, friendsEditPressed: .constant(false), chatsEditPressed: .constant(false), newChatSelected: .constant(false), chatInfo: .constant(ChatType(id: "", mobile: "", name: "", pictureUrl: nil, lastSeen: 0, lastMessage: "", lastMessageTime: 0, unreadMessageNumber: 0, messages: [MessageType]())), friendCreationMobile: .constant(""), friendCreationResult: .constant(nil))
            .previewLayout(.sizeThatFits)
    }
}
