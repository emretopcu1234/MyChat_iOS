//
//  ChatsDelegate.swift
//  MyChat
//
//  Created by Emre Topçu on 11.02.2022.
//

import Foundation

protocol ChatsDelegate {
    
    func onChatsDataReceived(chats: [ChatType])
}
