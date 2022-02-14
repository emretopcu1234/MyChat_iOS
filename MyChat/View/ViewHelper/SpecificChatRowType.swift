//
//  SpecificChatRowType.swift
//  MyChat
//
//  Created by Emre Topçu on 15.02.2022.
//

import Foundation

struct SpecificChatRowType: Identifiable {
    // if enum = sender / receiver, id = timeInterval (in string), if enum = newDate, id = rowInfo1, if enum = unreadMessages / unknownPerson, id = unreadMessages / unknownPerson
    var id: String
    var rowEnum: SpecificChatRowEnum
    var rowInfo1: String?
    var rowInfo2: String?
    
    init(id: String, rowEnum: SpecificChatRowEnum, rowInfo1: String?, rowInfo2: String?){
        self.id = id
        self.rowEnum = rowEnum
        self.rowInfo1 = rowInfo1
        self.rowInfo2 = rowInfo2
    }
}

enum SpecificChatRowEnum {
    case sender
    case receiver
    case newDate
    case unreadMessages
    case unknownPerson
}
