//
//  FriendRowType.swift
//  MyChat
//
//  Created by Emre Topçu on 3.02.2022.
//

import Foundation

struct FriendType {
    var mobile: String
    var name: String
    var email: String
    var lastSeen: String
    var pictureUrl: String?
    
    init(mobile: String, name: String, email: String, lastSeen: String, pictureUrl: String?){
        self.mobile = mobile
        self.name = name
        self.email = email
        self.lastSeen = lastSeen
        self.pictureUrl = pictureUrl
    }
}
