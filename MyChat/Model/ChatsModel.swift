//
//  ChatsModel.swift
//  MyChat
//
//  Created by Emre Topçu on 26.01.2022.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

class ChatsModel {
    
    static let shared = ChatsModel()
    let friendsModel: FriendsModel
    private var friendsInfo: [FriendType]
    var chatsDelegate: ChatsDelegate?
    let userDefaultsModel: UserDefaultsModel
    let dbRef: Firestore
    let chatsRef: CollectionReference
    let storageRef: StorageReference
    private var chatsInfo: [ChatType]
    

    private init(){
        friendsModel = FriendsModel.shared
        friendsInfo = friendsModel.getFriendsInfo()
        userDefaultsModel = UserDefaultsModel.shared
        dbRef = Firestore.firestore()
        chatsRef = dbRef.collection("chats")
        storageRef = Storage.storage().reference()
        chatsInfo = [ChatType]()
    }
    
    func getChatsData(){
        friendsInfo = friendsModel.getFriendsInfo()
        chatsRef.whereField("user1", isEqualTo: userDefaultsModel.mobile).getDocuments { [self] querySnapshot, error in
            guard error == nil else {
                return
            }
            chatsInfo = [ChatType]()
            for document in querySnapshot!.documents {
                let result = Result {
                    try document.data(as: DocChatType.self)
                }
                switch result {
                case .success(let receivedChat):
                    if let receivedChat = receivedChat {
                        var friendName: String = ""
                        var friendPictureUrl: String? = nil
                        var friendLastSeen: TimeInterval = 0
                        for friend in friendsInfo {
                            if receivedChat.user2 == friend.mobile {
                                friendName = friend.name
                                friendPictureUrl = friend.pictureUrl
                                friendLastSeen = friend.lastSeen
                                break
                            }
                        }
                        var messages = [MessageType]()
                        var unreadMessageNumber = 0
                        for message in receivedChat.messages {
                            if message.time > receivedChat.lastDelete1 {
                                messages.append(MessageType(time: message.time, message: message.message, sender: message.sender))
                                if message.time > receivedChat.lastSeen1 {
                                    unreadMessageNumber += 1
                                }
                            }
                        }
                        if messages.count > 0 {
                            chatsInfo.append(ChatType(id: document.documentID, mobile: receivedChat.user2, name: friendName, pictureUrl: friendPictureUrl, lastSeen: friendLastSeen, lastMessage: messages[messages.count-1].message, lastMessageTime: receivedChat.lastMessageTime, unreadMessageNumber: unreadMessageNumber, messages: messages))
                        }
                    }
                case .failure(_):
                    break
                }
            }
            chatsRef.whereField("user2", isEqualTo: userDefaultsModel.mobile).getDocuments { [self] querySnapshot, error in
                guard error == nil else {
                    return
                }
                for document in querySnapshot!.documents {
                    let result = Result {
                        try document.data(as: DocChatType.self)
                    }
                    switch result {
                    case .success(let receivedChat):
                        if let receivedChat = receivedChat {
                            var friendName: String = ""
                            var friendPictureUrl: String? = nil
                            var friendLastSeen: TimeInterval = 0
                            for friend in friendsInfo {
                                if receivedChat.user1 == friend.mobile {
                                    friendName = friend.name
                                    friendPictureUrl = friend.pictureUrl
                                    friendLastSeen = friend.lastSeen
                                    break
                                }
                            }
                            var messages = [MessageType]()
                            var unreadMessageNumber = 0
                            for message in receivedChat.messages {
                                if message.time > receivedChat.lastDelete2 {
                                    messages.append(MessageType(time: message.time, message: message.message, sender: message.sender))
                                    if message.time > receivedChat.lastSeen2 {
                                        unreadMessageNumber += 1
                                    }
                                }
                            }
                            if messages.count > 0 {
                                chatsInfo.append(ChatType(id: document.documentID, mobile: receivedChat.user1, name: friendName, pictureUrl: friendPictureUrl, lastSeen: friendLastSeen, lastMessage: messages[messages.count-1].message, lastMessageTime: receivedChat.lastMessageTime, unreadMessageNumber: unreadMessageNumber, messages: messages))
                            }
                        }
                    case .failure(_):
                        break
                    }
                }
                chatsInfo = chatsInfo.sorted(by: { $0.lastMessageTime > $1.lastMessageTime })
                chatsDelegate?.onChatsDataReceived(chats: chatsInfo)
            }
        }
    }
    
    func deleteChat(id: String){
        
    }
    
    func deleteChats(id: [String]){
        
    }
}
