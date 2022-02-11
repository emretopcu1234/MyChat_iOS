//
//  ChatType.swift
//  MyChat
//
//  Created by Emre Topçu on 11.02.2022.
//

import Foundation

struct ChatType: Identifiable {
    var id: String
    var mobile: String
    var name: String
    var pictureUrl: String?
    var lastSeen: TimeInterval
    var lastMessage: String
    var lastMessageTime: TimeInterval
    var unreadMessageNumber: Int
    var messages: [MessageType]
    
    init(id: String, mobile: String, name: String, pictureUrl: String?, lastSeen: TimeInterval, lastMessage: String, lastMessageTime: TimeInterval, unreadMessageNumber: Int, messages: [MessageType]){
        self.id = id
        self.mobile = mobile
        self.name = name
        self.pictureUrl = pictureUrl
        self.lastSeen = lastSeen
        self.lastMessage = lastMessage
        self.lastMessageTime = lastMessageTime
        self.unreadMessageNumber = unreadMessageNumber
        self.messages = messages
    }
}

struct MessageType: Identifiable {
    var time: TimeInterval
    var message: String
    var sender: String
    var id: TimeInterval
    
    init(time: TimeInterval, message: String, sender: String){
        self.time = time
        self.message = message
        self.sender = sender
        id = self.time
    }
}
