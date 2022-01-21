//
//  FriendsRowView.swift
//  MyChat
//
//  Created by Emre Topçu on 12.01.2022.
//

import SwiftUI

struct FriendsRowView: View {
    
    @State private var showFriendProfile = false
    @State private var offsetDelete = CGSize.zero
    @State private var friendSelected = false
    @Binding var anyFriendDragging: Bool
    @Binding var anyDragCancelled: Bool
    @Binding var editPressed: Bool
    
    var body: some View {
        ZStack {
            VStack {
                Divider()
                Button {
                    if editPressed {
                        friendSelected.toggle()
                    }
                    else {
                        if anyDragCancelled {
                            UINavigationBar.setAnimationsEnabled(true)
                            showFriendProfile = true
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
                .padding(.leading)
                .padding(.trailing)
                .buttonStyle(PlainButtonStyle())
                .sheet(isPresented: $showFriendProfile) {
                    FriendProfileView()
                }
            }
            .padding(.bottom, 5)
            .offset(x: editPressed ? 50 : min(0, offsetDelete.width))
            .background(friendSelected ? Color("LightBlue") : .white)
            .gesture(
                 DragGesture()
                    .onChanged{ gesture in
                        if !editPressed {
                            withAnimation {
                                offsetDelete.width = max(-70, gesture.translation.width)
                                anyFriendDragging = true
                                anyDragCancelled = false
                            }
                        }
                    }
                    .onEnded{ _ in
                        if offsetDelete.width < -50 && !editPressed {
                            withAnimation {
                                offsetDelete.width = -70
                                anyFriendDragging = false
                            }
                        }
                        else {
                            withAnimation {
                                offsetDelete.width = 0
                                anyFriendDragging = false
                            }
                        }
                    }
            )
            .onTapGesture {
                if editPressed{
                    friendSelected.toggle()
                }
                else {
                    withAnimation {
                        anyDragCancelled = true
                    }
                }
            }
            
            HStack {
                Image(systemName: friendSelected ? "checkmark.circle.fill" : "circle")
                    .resizable()
                    .aspectRatio(1, contentMode: .fill)
                    .frame(width: 20, height: 20)
                    .padding()
                    .offset(x: editPressed ? 0 : -50, y: 5)
                    .foregroundColor(.blue)
                    .onTapGesture {
                        friendSelected.toggle()
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
        .padding(.bottom, -7)
        .background(friendSelected ? Color("LightBlue") : .white)
        .onChange(of: editPressed) { pressed in
            withAnimation {
                offsetDelete.width = 0
            }
            if !pressed {
                friendSelected = false
            }
        }
        .onChange(of: anyFriendDragging) { dragging in
            if dragging && offsetDelete.width == -70 { // that means, current friend is already dragged (because its offset is -70), so at the moment there is another friend dragging, and therefore this friend should be undragged.
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

struct FriendsRowView_Previews: PreviewProvider {
    static var previews: some View {
        FriendsRowView(anyFriendDragging: .constant(false), anyDragCancelled: .constant(true), editPressed: .constant(false))
    }
}
