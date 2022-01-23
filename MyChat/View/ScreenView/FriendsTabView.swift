//
//  FriendsTabView.swift
//  MyChat
//
//  Created by Emre Topçu on 12.01.2022.
//

import SwiftUI

struct FriendsTabView: View {
    
    @State var anyDragCancelled = true
    @State var anyFriendDragging = false
    @State var editPressed = false
    
    var body: some View {
        VStack(spacing: 0) {
            TopBarView(topBarType: TopBarType.Friends, friendsEditPressed: $editPressed, chatsEditPressed: .constant(false), newChatSelected: .constant(false))
                .frame(height: 60)
            ScrollView(showsIndicators: false) {
                ForEach(0 ..< 15) { index in
                    FriendsRowView(anyFriendDragging: $anyFriendDragging, anyDragCancelled: $anyDragCancelled, editPressed: $editPressed)
                }
            }
            BottomBarView(bottomBarType: editPressed ? BottomBarType.Delete : BottomBarType.Friends)
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


// Friend struct'ı baska pakette tanımlanacak.
// FriendOperations class'ı bu dosyada tanımlanabilir. Eger baska bir view'da da (bu view'un child'ları haric) ihtiyac duyulursa o zaman view paketinin icinde baska bir yerde tanımlanabilir. Duzenli gorunmesi acisindan 2.secenek daha mantıklı duruyor.

struct Friend {
    var name: String
    var status: String
    
    init(name: String, status: String){
        self.name = name
        self.status = status
    }
}

class FriendOperations {
    
    var friends: [Friend] = [Friend(name: "emre", status: "last seen ok"), Friend(name: "seren", status: "last seen nok")]
    var friendsToBeDeleted = [Friend]()
    
    
    func insertDeleteList(friend: Friend){
        // örnegin friendsrowview'lardaki herhangi bir row secildiginde ilgili row bu metodu cagıracak ve böylece friendsToBeDeleted listesi guncellenmis olacak.
        friendsToBeDeleted.append(friend)
        print(friendsToBeDeleted[0].name)
    }
    
    func deleteFriends(){
        // örneğin delete tusuna basıldıgında bu metod cagırılacak.
        // viewModelFriends.deleteFrinds(friendsToBeDeleted)
        // not: delete tusu bottomrowview'da yer alıyor. o view'a friendoperations referansını göndermek yerine state binding yontemi kullanılarak delete tusuna basıldıgından haberdar olunması daha mantıklı bir yol. (vstack'e onChange(of: ..., perform...) eklenerek)
    }
    
}

