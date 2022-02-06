//
//  FriendsViewModel.swift
//  MyChat
//
//  Created by Emre Topçu on 27.01.2022.
//

import Foundation

class FriendsViewModel: ObservableObject, FriendsDelegate {
    
    @Published var friends: [FriendType]
    
    
    let friendsModel = FriendsModel.shared
    let userDefaultsModel = UserDefaultsModel.shared
    
    init(){
        friends = [FriendType]()
        friendsModel.friendsDelegate = self
    }
        
    func getData(){
        friendsModel.getFriendsData()
    }
    
    
    
    // MARK: PROTOCOL METHODS
    func onFriendsDataReceived(friends: [FriendType]) {
        self.friends = friends
    }
    
}
