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
    private var userDocumentID: String
    private var friends: [String]
    private var friendsInfo: [FriendType]
    
    private init(){
        userDefaultsModel = UserDefaultsModel.shared
        dbRef = Firestore.firestore()
        usersRef = dbRef.collection("users")
        storageRef = Storage.storage().reference()
        userDocumentID = ""
        friends = [String]()
        friendsInfo = [FriendType]()
    }
    
    func getFriendsInfo() -> [FriendType] {
        return friendsInfo
    }
    
    func getFriendInfo(mobile: String) -> FriendType? {
        for friend in friendsInfo {
            if friend.mobile == mobile {
                return friend
            }
        }
        return nil
    }
    
    func getFriendsData(){
        usersRef.whereField("mobile", isEqualTo: userDefaultsModel.mobile).getDocuments { [self] querySnapshot, error in
            guard error == nil else {
                return
            }
            for document in querySnapshot!.documents {
                userDocumentID = document.documentID
                let result = Result {
                    try document.data(as: DocUserType.self)
                }
                switch result {
                case .success(let receivedUser):
                    if let receivedUser = receivedUser {
                        friends = receivedUser.friends
                        usersRef.order(by: "lastSeen", descending: true).whereField("friends", arrayContains: userDefaultsModel.mobile).getDocuments { querySnapshot, error in
                            guard error == nil else {
                                return
                            }
                            friendsInfo = [FriendType]()
                            for document in querySnapshot!.documents {
                                let result = Result {
                                    try document.data(as: DocUserType.self)
                                }
                                switch result {
                                case .success(let candidateCrossFriend):
                                    if let candidateCrossFriend = candidateCrossFriend {
                                        if friends.contains(candidateCrossFriend.mobile) {
                                            friendsInfo.append(FriendType(mobile: candidateCrossFriend.mobile, name: candidateCrossFriend.name, email: candidateCrossFriend.email, lastSeen: candidateCrossFriend.lastSeen, pictureUrl: candidateCrossFriend.pictureUrl))
                                        }
                                    }
                                case .failure(_):
                                    break
                                }
                            }
                            var isFriend: Bool
                            for friend in friends {
                                isFriend = false
                                for friendInfo in friendsInfo {
                                    if friendInfo.mobile == friend {
                                        isFriend = true
                                        break
                                    }
                                }
                                if !isFriend {
                                    friendsInfo.append(FriendType(mobile: friend, name: "", email: "", lastSeen: 0, pictureUrl: nil))
                                }
                            }
                            friendsDelegate?.onFriendsDataReceived(friends: friendsInfo)
                        }
                    }
                case .failure(_):
                    break
                }
                break // since just one document will be returned
            }
        }
    }
    
    func deleteFriend(mobile: String){
        usersRef.document(userDocumentID).updateData([
            "friends": FieldValue.arrayRemove([mobile])
        ]) { [self] error in
            if error == nil {
                if let index = friends.firstIndex(of: mobile) {
                    friends.remove(at: index)
                }
                for index in 0..<friendsInfo.count {
                    if friendsInfo[index].mobile == mobile {
                        friendsInfo.remove(at: index)
                        break
                    }
                }
                friendsDelegate?.onFriendsDataReceived(friends: friendsInfo)
            }
        }
    }
    
    func deleteFriends(mobile: [String]){
        usersRef.document(userDocumentID).updateData([
            "friends": FieldValue.arrayRemove(mobile)
        ]) { [self] error in
            if error == nil {
                for m in mobile {
                    if let index = friends.firstIndex(of: m) {
                        friends.remove(at: index)
                    }
                    for index in 0..<friendsInfo.count {
                        if friendsInfo[index].mobile == m {
                            friendsInfo.remove(at: index)
                            break
                        }
                    }
                }
                friendsDelegate?.onFriendsDataReceived(friends: friendsInfo)
            }
        }
    }
    
    func createFriend(mobile: String){
        usersRef.whereField("mobile", isEqualTo: mobile).getDocuments { [self] querySnapshot, error in
            guard error == nil else {
                return
            }
            var userFound = false
            for document in querySnapshot!.documents {
                let result = Result {
                    try document.data(as: DocUserType.self)
                }
                switch result {
                case .success(let receivedUser):
                    if let receivedUser = receivedUser {
                        if receivedUser.mobile != userDefaultsModel.mobile {
                            userFound = true
                            break
                        }
                    }
                case .failure(_):
                    break
                }
            }
            if userFound {
                usersRef.document(userDocumentID).updateData([
                    "friends": FieldValue.arrayUnion([mobile])
                ]) { [self] error in
                    if error == nil {
                        friends.append(mobile)
                        usersRef.order(by: "lastSeen", descending: true).whereField("friends", arrayContains: userDefaultsModel.mobile).getDocuments { querySnapshot2, error2 in
                            guard error2 == nil else {
                                friendsDelegate?.onCreateFriendUnsuccessfulWithUnknownReason()
                                return
                            }
                            friendsInfo = [FriendType]()
                            for document in querySnapshot2!.documents {
                                let result2 = Result {
                                    try document.data(as: DocUserType.self)
                                }
                                switch result2 {
                                case .success(let candidateCrossFriend):
                                    if let candidateCrossFriend = candidateCrossFriend {
                                        if friends.contains(candidateCrossFriend.mobile) {
                                            friendsInfo.append(FriendType(mobile: candidateCrossFriend.mobile, name: candidateCrossFriend.name, email: candidateCrossFriend.email, lastSeen: candidateCrossFriend.lastSeen, pictureUrl: candidateCrossFriend.pictureUrl))
                                        }
                                    }
                                case .failure(_):
                                    friendsDelegate?.onCreateFriendUnsuccessfulWithUnknownReason()
                                    break
                                }
                            }
                            var isFriend: Bool
                            for friend in friends {
                                isFriend = false
                                for friendInfo in friendsInfo {
                                    if friendInfo.mobile == friend {
                                        isFriend = true
                                        break
                                    }
                                }
                                if !isFriend {
                                    friendsInfo.append(FriendType(mobile: friend, name: "", email: "", lastSeen: 0, pictureUrl: nil))
                                }
                            }
                            friendsDelegate?.onCreateFriendSuccessful(friends: friendsInfo)
                        }
                    }
                    else {
                        friendsDelegate?.onCreateFriendUnsuccessfulWithUnknownReason()
                    }
                }
            }
            else {
                friendsDelegate?.onCreateFriendUnsuccessfulWithInvalidMobile()
            }
        }
    }
}
