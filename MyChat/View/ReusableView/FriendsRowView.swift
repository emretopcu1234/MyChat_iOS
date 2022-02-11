//
//  FriendsRowView.swift
//  MyChat
//
//  Created by Emre Topçu on 12.01.2022.
//

import SwiftUI

struct FriendsRowView: View {
    
    let friendOperations = FriendSelection.shared
    
    @State private var image = UIImage()
    @State private var imageUrl = URL(string: "")
    @State private var showFriendProfile = false
    @State private var offsetDelete = CGSize.zero
    @State private var friendSelected = false
    @State private var showDeleteConfirmation = false
    
    @Binding var friend: FriendType
    @Binding var anyFriendDragging: Bool
    @Binding var anyDragCancelled: Bool
    @Binding var editPressed: Bool
    @Binding var deletion: String
    @Binding var multipleDeletePressed: Bool
    
    var body: some View {
        ZStack {
            VStack {
                Divider()
                Button {
                    if editPressed {
                        friendSelected.toggle()
                        if friendSelected {
                            friendOperations.addSelection(selectedFriend: friend.mobile)
                        }
                        else {
                            friendOperations.removeSelection(removedFriend: friend.mobile)
                        }
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
                                .foregroundColor(friend.lastSeen.stringFormattedLastSeen() == "online" ? .blue : Color("Gray"))
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }
                .padding(EdgeInsets.init(top: 0, leading: 10, bottom: 0, trailing: 10))
                .buttonStyle(PlainButtonStyle())
                .sheet(isPresented: $showFriendProfile) {
                    FriendProfileView(friend: friend)
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
                    if friendSelected {
                        friendOperations.addSelection(selectedFriend: friend.mobile)
                    }
                    else {
                        friendOperations.removeSelection(removedFriend: friend.mobile)
                    }
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
                                    deletion = friend.mobile
                                }
                                Button("Cancel", role: .cancel) {
                                    anyDragCancelled = true
                                }
                            } message: {
                                Text(friend.name == "" ? "Are you sure you want to delete the user with mobile \(friend.mobile)?" : "Are you sure you want to delete \(friend.name)?")
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
        .padding(.bottom, -7)
        .background(friendSelected ? Color("LightBlue") : .white)
        .onAppear(perform: {
            imageUrl = URL(string: friend.pictureUrl ?? "")
            if imageUrl != URL(string: "") {
                let data = try? Data(contentsOf: imageUrl!)
                image = UIImage(data: data!)!
            }
        })
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
        .onChange(of: multipleDeletePressed) { _ in
            friendSelected = false
        }
    }
}

struct FriendsRowView_Previews: PreviewProvider {
    static var previews: some View {
        FriendsRowView(friend: .constant(FriendType(mobile: "", name: "", email: "", lastSeen: 0, pictureUrl: nil)), anyFriendDragging: .constant(false), anyDragCancelled: .constant(true), editPressed: .constant(false), deletion: .constant(""), multipleDeletePressed: .constant(false))
    }
}
