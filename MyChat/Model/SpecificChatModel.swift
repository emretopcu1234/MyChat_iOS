//
//  SpecificChatModel.swift
//  MyChat
//
//  Created by Emre Topçu on 14.02.2022.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

class SpecificChatModel{

    static let shared = SpecificChatModel()
    let friendsModel: FriendsModel
    private var friendInfo: FriendType
    var specificChatDelegate: SpecificChatDelegate?
    let userDefaultsModel: UserDefaultsModel
    let dbRef: Firestore
    let chatsRef: CollectionReference
    let storageRef: StorageReference
    private var chatDocumentID: String
    private var chatInfo: ChatType

    private init(){
        friendsModel = FriendsModel.shared
        friendInfo = FriendType(mobile: "", name: "", email: "", lastSeen: 0, pictureUrl: nil)
        userDefaultsModel = UserDefaultsModel.shared
        dbRef = Firestore.firestore()
        chatsRef = dbRef.collection("chats")
        storageRef = Storage.storage().reference()
        chatDocumentID = ""
        chatInfo = ChatType(id: "", mobile: "", name: "", pictureUrl: nil, lastSeen: 0, lastMessage: "", lastMessageTime: 0, unreadMessageNumber: 0, messages: [MessageType]())
    }
    
    func getChatData(mobile: String){
        friendInfo = friendsModel.getFriendInfo(mobile: mobile) ?? FriendType(mobile: mobile, name: "", email: "", lastSeen: 0, pictureUrl: nil)
        chatsRef.whereField("user1", isEqualTo: userDefaultsModel.mobile).whereField("user2", isEqualTo: mobile).getDocuments { [self] querySnapshot, error in
            guard error == nil else {
                return
            }
            var chatExist = false
            for document in querySnapshot!.documents {
                chatDocumentID = document.documentID
                let result = Result {
                    try document.data(as: DocChatType.self)
                }
                switch result {
                case .success(let receivedChat):
                    chatExist = true
                    if let receivedChat = receivedChat {
                        let friendName: String = friendInfo.name
                        let friendPictureUrl: String? = friendInfo.pictureUrl
                        let friendLastSeen: TimeInterval = friendInfo.lastSeen
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
                        chatInfo = ChatType(id: chatDocumentID, mobile: receivedChat.user2, name: friendName, pictureUrl: friendPictureUrl, lastSeen: friendLastSeen, lastMessage: messages.count > 0 ? messages[messages.count-1].message : "", lastMessageTime: receivedChat.lastMessageTime, unreadMessageNumber: unreadMessageNumber, messages: messages)
                        specificChatDelegate?.onChatDataReceived(chat: chatInfo)
                    }
                case .failure(_):
                    break
                }
                break   // since just one document will be returned
            }
            if chatExist {
                return
            }
            chatsRef.whereField("user2", isEqualTo: userDefaultsModel.mobile).whereField("user1", isEqualTo: mobile).getDocuments { [self] querySnapshot, error in
                guard error == nil else {
                    return
                }
                for document in querySnapshot!.documents {
                    let result = Result {
                        try document.data(as: DocChatType.self)
                    }
                    switch result {
                    case .success(let receivedChat):
                        chatExist = true
                        if let receivedChat = receivedChat {
                            let friendName: String = friendInfo.name
                            let friendPictureUrl: String? = friendInfo.pictureUrl
                            let friendLastSeen: TimeInterval = friendInfo.lastSeen
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
                            chatInfo = ChatType(id: chatDocumentID, mobile: receivedChat.user2, name: friendName, pictureUrl: friendPictureUrl, lastSeen: friendLastSeen, lastMessage: messages.count > 0 ? messages[messages.count-1].message : "", lastMessageTime: receivedChat.lastMessageTime, unreadMessageNumber: unreadMessageNumber, messages: messages)
                            specificChatDelegate?.onChatDataReceived(chat: chatInfo)
                        }
                    case .failure(_):
                        break
                    }
                    break   // since just one document will be returned
                }
                if chatExist {
                    return
                }
                specificChatDelegate?.onChatDataReceived(chat: ChatType(id: chatDocumentID, mobile: mobile, name: friendInfo.name, pictureUrl: friendInfo.pictureUrl, lastSeen: friendInfo.lastSeen, lastMessage: "", lastMessageTime: 0, unreadMessageNumber: 0, messages: [MessageType]()))
            }
        }
    }
    
}
