//
//  SpecificChatDelegate.swift
//  MyChat
//
//  Created by Emre Topçu on 14.02.2022.
//

import Foundation

protocol SpecificChatDelegate {
    
    func onChatDataReceived(chat: ChatType)
}
