//
//  ChatsRowView.swift
//  MyChat
//
//  Created by Emre Topçu on 13.01.2022.
//

import SwiftUI

struct ChatsRowView: View {
    
    @State private var enterChat: Bool?
    @State private var offsetDelete = CGSize.zero
    @State private var chatSelected = false
    @Binding var anyChatDragging: Bool
    @Binding var anyDragCancelled: Bool
    @Binding var editPressed: Bool
    
    var body: some View {
        ZStack {
            VStack {
                Divider()
                NavigationLink(destination: SpecificChatView(), tag: true, selection: $enterChat) {
                    Button {
                        if editPressed {
                            chatSelected.toggle()
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
                            Image(systemName: "person.circle")
                                .resizable()
                                .aspectRatio(1, contentMode: .fill)
                                .frame(width: 60, height: 60)
                            VStack {
                                Text("Michael Clooney")
                                    .font(.title2)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
                                    .font(.system(size: 15))
                                    .foregroundColor(Color("Gray"))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .lineLimit(2)
                            }
                            Spacer()
                            VStack(alignment: .trailing, spacing: 5) {
                                Text("Yesterday")
                                    .font(.system(size: 15))
                                    .foregroundColor(Color("Gray"))
                                    .frame(width: 70, alignment: .trailing)
                                    .lineLimit(2)
                                ZStack {
                                    Image(systemName: "circle.fill")
                                        .scaleEffect(1.5)
                                        .foregroundColor(.blue)
                                    Text("13")
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
                // TODO
            } label: {
                HStack {
                    Spacer()
                    VStack {
                        Spacer()
                        Text("Delete")
                            .font(.system(size: 15))
                            .foregroundColor(.white)
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
    }
}

struct ChatsRowView_Previews: PreviewProvider {
    static var previews: some View {
        ChatsRowView(anyChatDragging: .constant(false), anyDragCancelled: .constant(true), editPressed: .constant(false))
    }
}
