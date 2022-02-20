//
//  SpecificChatViewModel.swift
//  MyChat
//
//  Created by Emre Topçu on 27.01.2022.
//

import Foundation

class SpecificChatViewModel: ObservableObject, SpecificChatDelegate {
    
    @Published var chat: ChatType
    
    let specificChatModel: SpecificChatModel
    let userDefaultsModel: UserDefaultsModel
    
    init(){
        specificChatModel = SpecificChatModel.shared
        userDefaultsModel = UserDefaultsModel.shared
        chat = ChatType(id: "", mobile: "", name: "", pictureUrl: nil, lastSeen: 0, lastMessage: "", lastMessageTime: 0, unreadMessageNumber: 0, messages: [MessageType]())
        specificChatModel.specificChatDelegate = self
    }
    
    func getData(mobile: String){
        specificChatModel.getChatData(mobile: mobile)
    }
    
    func sendMessage(message: String){
        specificChatModel.sendMessage(mobile: chat.mobile, message: message)
    }
    
    func disappear(){
        specificChatModel.updateLastSeen(mobile: chat.mobile)
    }
    
    
    // MARK: DELEGATE METHODS
    func onChatDataReceived(chat: ChatType) {
        self.chat = chat
    }
}
