//
//  FriendRowType.swift
//  MyChat
//
//  Created by Emre Topçu on 3.02.2022.
//

import Foundation

struct FriendType: Identifiable {
    var mobile: String
    var name: String
    var email: String
    var lastSeen: TimeInterval
    var pictureUrl: String?
    var id: String
    
    init(mobile: String, name: String, email: String, lastSeen: TimeInterval, pictureUrl: String?){
        self.mobile = mobile
        self.name = name
        self.email = email
        self.lastSeen = lastSeen
        self.pictureUrl = pictureUrl
        id = self.mobile
    }
}
