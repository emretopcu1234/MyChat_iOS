//
//  DatabaseModel.swift
//  MyChat
//
//  Created by Emre Topçu on 26.01.2022.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

class FriendsModel {
    
    static let shared = FriendsModel()
    var friendsDelegate: FriendsDelegate?
    let userDefaultsModel: UserDefaultsModel
    let dbRef: Firestore
    let usersRef: CollectionReference
    let storageRef: StorageReference
    private var friends: [String]
    private var crossFriends: [FriendType]
    
    private init(){
        userDefaultsModel = UserDefaultsModel.shared
        dbRef = Firestore.firestore()
        usersRef = dbRef.collection("users")
        storageRef = Storage.storage().reference()
        friends = [String]()
        crossFriends = [FriendType]()
    }
    
    func getFriendsData(){
        usersRef.whereField("mobile", isEqualTo: userDefaultsModel.mobile).getDocuments { [self] querySnapshot, error in
            guard error == nil else {
                return
            }
            for document in querySnapshot!.documents {
                let result = Result {
                    try document.data(as: DocUserType.self)
                }
                switch result {
                case .success(let receivedUser):
                    if let receivedUser = receivedUser {
                        friends = receivedUser.friends
                        usersRef.order(by: "lastSeen", descending: true).whereField("friends", arrayContains: userDefaultsModel.mobile).getDocuments { querySnapshot2, error2 in
                            guard error2 == nil else {
                                return
                            }
                            crossFriends = [FriendType]()
                            for document in querySnapshot2!.documents {
                                let result2 = Result {
                                    try document.data(as: DocUserType.self)
                                }
                                switch result2 {
                                case .success(let candidateCrossFriend):
                                    if let candidateCrossFriend = candidateCrossFriend {
                                        if friends.contains(candidateCrossFriend.mobile) {
                                            crossFriends.append(FriendType(mobile: candidateCrossFriend.mobile, name: candidateCrossFriend.name, email: candidateCrossFriend.email, lastSeen: candidateCrossFriend.lastSeen.stringFormattedLastSeen(), pictureUrl: candidateCrossFriend.pictureUrl))
                                        }
                                    }
                                case .failure(_):
                                    break
                                }
                            }
                            var isFriend: Bool
                            for friend in friends {
                                isFriend = false
                                for crossFriend in crossFriends {
                                    if crossFriend.mobile == friend {
                                        isFriend = true
                                        break
                                    }
                                }
                                if !isFriend {
                                    crossFriends.append(FriendType(mobile: friend, name: "", email: "", lastSeen: "", pictureUrl: nil))
                                }
                            }
                            friendsDelegate?.onFriendsDataReceived(friends: crossFriends)
                        }
                    }
                case .failure(_):
                    break
                }
                break // since just one document will be returned
            }
        }
    }
}





//        var friends = [FriendRowType]()
//        friends.append(FriendRowType(name: "emre topcu", lastSeen: "last seen yesterday at 11:35", pictureUrl: "https://firebasestorage.googleapis.com:443/v0/b/mychat-d8d6d.appspot.com/o/555555?alt=media&token=fc143ece-62b0-457b-a27b-5f000968d4fc"))
//        friends.append(FriendRowType(name: "emre topcu2", lastSeen: "last seen yesterday at 11:36", pictureUrl: "https://firebasestorage.googleapis.com:443/v0/b/mychat-d8d6d.appspot.com/o/555555?alt=media&token=fc143ece-62b0-457b-a27b-5f000968d4fc"))
//        friends.append(FriendRowType(name: "emre topcu3", lastSeen: "last seen yesterday at 11:37", pictureUrl: nil))
//        friends.append(FriendRowType(name: "emre topcu4", lastSeen: "last seen yesterday at 11:38", pictureUrl: "https://firebasestorage.googleapis.com:443/v0/b/mychat-d8d6d.appspot.com/o/555555?alt=media&token=fc143ece-62b0-457b-a27b-5f000968d4fc"))
//        friendsDelegate?.onFriendsDataReceived(friends: friends)
