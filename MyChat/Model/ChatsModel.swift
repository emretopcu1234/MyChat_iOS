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
        
        
        
//        var messages = [DocMessageType]()
//        messages.append(DocMessageType(time: 1644596139, message: "message 1", sender: "222222"))
//        messages.append(DocMessageType(time: 1644596239, message: "message 2", sender: "666666"))
//        messages.append(DocMessageType(time: 1644596339, message: "message 3", sender: "666666"))
//        messages.append(DocMessageType(time: 1644596346, message: "message 4", sender: "222222"))
//        let chat = DocChatType(user1: "666666", user2: "222222", lastSeen1: 1644596355, lastSeen2: 1644596347, lastDelete1: 0, lastDelete2: 0, lastMessageTime: 1644596346, messages: messages)
//
//        do {
//            try chatsRef.document().setData(from: chat) { error in
//                if error != nil {
//                    print("\n\n\n error \n\n\n")
//                }
//                else {
//
//                }
//            }
//        }
//        catch {
//
//        }
        
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
                            messages.append(MessageType(time: message.time, message: message.message, sender: message.sender))
                            if message.time > receivedChat.lastSeen1 {
                                unreadMessageNumber += 1
                            }
                        }
                        chatsInfo.append(ChatType(id: document.documentID, mobile: receivedChat.user2, name: friendName, pictureUrl: friendPictureUrl, lastSeen: friendLastSeen, lastMessage: messages[messages.count-1].message, lastMessageTime: receivedChat.lastMessageTime, unreadMessageNumber: unreadMessageNumber, messages: messages))
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
                                messages.append(MessageType(time: message.time, message: message.message, sender: message.sender))
                                if message.time > receivedChat.lastSeen2 {
                                    unreadMessageNumber += 1
                                }
                            }
                            chatsInfo.append(ChatType(id: document.documentID, mobile: receivedChat.user1, name: friendName, pictureUrl: friendPictureUrl, lastSeen: friendLastSeen, lastMessage: messages[messages.count-1].message, lastMessageTime: receivedChat.lastMessageTime, unreadMessageNumber: unreadMessageNumber, messages: messages))
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
