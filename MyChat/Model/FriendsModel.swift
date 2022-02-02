//
//  DatabaseModel.swift
//  MyChat
//
//  Created by Emre Topçu on 26.01.2022.
//

import Foundation

class FriendsModel {
    
    static let shared = FriendsModel()
    var friendsDelegate: FriendsDelegate?
    let userDefaultsModel: UserDefaultsModel
    
    private init(){
        userDefaultsModel = UserDefaultsModel.shared
    }
    
    func getFriendsData(){
        var friends = [FriendRowType]()
        friends.append(FriendRowType(name: "emre topcu", lastSeen: "last seen yesterday at 11:35", pictureUrl: "https://firebasestorage.googleapis.com:443/v0/b/mychat-d8d6d.appspot.com/o/555555?alt=media&token=fc143ece-62b0-457b-a27b-5f000968d4fc"))
        friends.append(FriendRowType(name: "emre topcu2", lastSeen: "last seen yesterday at 11:36", pictureUrl: "https://firebasestorage.googleapis.com:443/v0/b/mychat-d8d6d.appspot.com/o/555555?alt=media&token=fc143ece-62b0-457b-a27b-5f000968d4fc"))
        friends.append(FriendRowType(name: "emre topcu3", lastSeen: "last seen yesterday at 11:37", pictureUrl: nil))
        friends.append(FriendRowType(name: "emre topcu4", lastSeen: "last seen yesterday at 11:38", pictureUrl: "https://firebasestorage.googleapis.com:443/v0/b/mychat-d8d6d.appspot.com/o/555555?alt=media&token=fc143ece-62b0-457b-a27b-5f000968d4fc"))
        friendsDelegate?.onFriendsDataReceived(friends: friends)
    }
}
