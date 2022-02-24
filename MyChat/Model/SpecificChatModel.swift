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
        chatInfo = ChatType(id: "", mobile: "", name: "", email: "", pictureUrl: nil, lastSeen: 0, lastMessage: "", lastMessageTime: 0, unreadMessageNumber: 0, messages: [MessageType]())
    }
    
    func getChatData(mobile: String){
        friendInfo = friendsModel.getFriendInfo(mobile: mobile) ?? FriendType(mobile: mobile, name: "", email: "", lastSeen: 0, pictureUrl: nil)
        chatsRef.whereField("user1", isEqualTo: userDefaultsModel.mobile).whereField("user2", isEqualTo: mobile).addSnapshotListener { [self] querySnapshot, error in
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
                        let friendEmail: String = friendInfo.email
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
                        chatInfo = ChatType(id: chatDocumentID, mobile: receivedChat.user2, name: friendName, email: friendEmail, pictureUrl: friendPictureUrl, lastSeen: friendLastSeen, lastMessage: "", lastMessageTime: receivedChat.lastMessageTime, unreadMessageNumber: unreadMessageNumber, messages: messages)
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
            chatsRef.whereField("user2", isEqualTo: userDefaultsModel.mobile).whereField("user1", isEqualTo: mobile).addSnapshotListener { [self] querySnapshot, error in
                guard error == nil else {
                    return
                }
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
                            let friendEmail: String = friendInfo.email
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
                            chatInfo = ChatType(id: chatDocumentID, mobile: receivedChat.user1, name: friendName, email: friendEmail, pictureUrl: friendPictureUrl, lastSeen: friendLastSeen, lastMessage: "", lastMessageTime: receivedChat.lastMessageTime, unreadMessageNumber: unreadMessageNumber, messages: messages)
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
                chatDocumentID = ""
                specificChatDelegate?.onChatDataReceived(chat: ChatType(id: chatDocumentID, mobile: mobile, name: friendInfo.name, email: friendInfo.email, pictureUrl: friendInfo.pictureUrl, lastSeen: friendInfo.lastSeen, lastMessage: "", lastMessageTime: 0, unreadMessageNumber: 0, messages: [MessageType]()))
            }
        }
    }
    
    func sendMessage(mobile: String, message: String){
        if chatDocumentID != "" {
            chatsRef.document(chatDocumentID).getDocument { [self] querySnapshot, error in
                guard error == nil else {
                    return
                }
                let result = Result {
                    try querySnapshot!.data(as: DocChatType.self)
                }
                switch result {
                case .success(let receivedChat):
                    if let receivedChat = receivedChat {
                        let time: TimeInterval = NSDate().timeIntervalSince1970
                        let docMessageInfo: [String:Any] = ["time": TimeInterval(Int(time)), "message": message, "sender": userDefaultsModel.mobile]
                        if receivedChat.user1 == userDefaultsModel.mobile {
                            chatsRef.document(chatDocumentID).updateData([
                                "messages": FieldValue.arrayUnion([docMessageInfo]),
                                "lastMessageTime": TimeInterval(Int(time)),
                                "lastSeen1": TimeInterval(Int(time))
                            ])
                        }
                        else {
                            chatsRef.document(chatDocumentID).updateData([
                                "messages": FieldValue.arrayUnion([docMessageInfo]),
                                "lastMessageTime": TimeInterval(Int(time)),
                                "lastSeen2": TimeInterval(Int(time))
                            ])
                        }
                    }
                case .failure(_):
                    break
                }
            }
        }
        else {
            let time: TimeInterval = NSDate().timeIntervalSince1970
            let newChatDoc = chatsRef.document()
            chatDocumentID = newChatDoc.documentID
            let newChat = DocChatType(user1: userDefaultsModel.mobile, user2: mobile, lastSeen1: TimeInterval(Int(time)), lastSeen2: 0, lastDelete1: 0, lastDelete2: 0, lastMessageTime: TimeInterval(Int(time)), messages: [DocMessageType(time: TimeInterval(Int(time)), message: message, sender: userDefaultsModel.mobile)])
            do {
                try chatsRef.document(chatDocumentID).setData(from: newChat) { [self] error in
                    guard error == nil else {
                        return
                    }
                    friendInfo = friendsModel.getFriendInfo(mobile: mobile) ?? FriendType(mobile: mobile, name: "", email: "", lastSeen: 0, pictureUrl: nil)
                }
            }
            catch {}
        }
    }
    
    func updateLastSeen(mobile: String){
        chatsRef.document(chatDocumentID).getDocument { [self] querySnapshot, error in
            guard error == nil else {
                return
            }
            let result = Result {
                try querySnapshot!.data(as: DocChatType.self)
            }
            switch result {
            case .success(let receivedChat):
                if let receivedChat = receivedChat {
                    let time: TimeInterval = NSDate().timeIntervalSince1970
                    if receivedChat.user1 == userDefaultsModel.mobile {
                        chatsRef.document(chatDocumentID).updateData([
                            "lastSeen1": TimeInterval(Int(time))
                        ]) { [self] error in
                            guard error == nil else {
                                return
                            }
                            chatInfo.unreadMessageNumber = 0
                            specificChatDelegate?.onChatDataReceived(chat: chatInfo)
                        }
                    }
                    else {
                        chatsRef.document(chatDocumentID).updateData([
                            "lastSeen2": TimeInterval(Int(time))
                        ]) { [self] error in
                            guard error == nil else {
                                return
                            }
                            chatInfo.unreadMessageNumber = 0
                            specificChatDelegate?.onChatDataReceived(chat: chatInfo)
                        }
                    }
                }
            case .failure(_):
                break
            }
        }
    }
    
}
