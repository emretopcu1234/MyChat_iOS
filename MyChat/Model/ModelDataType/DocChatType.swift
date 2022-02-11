//
//  DocChatType.swift
//  MyChat
//
//  Created by Emre Topçu on 11.02.2022.
//

import Foundation
import FirebaseFirestoreSwift

public struct DocChatType: Codable {
    @DocumentID var id: String?
    var user1: String
    var user2: String
    var lastSeen1: TimeInterval
    var lastSeen2: TimeInterval
    var lastDelete1: TimeInterval
    var lastDelete2: TimeInterval
    var lastMessageTime: TimeInterval
    var messages: [DocMessageType]
}

public struct DocMessageType: Codable {
    var time: TimeInterval
    var message: String
    var sender: String
}
