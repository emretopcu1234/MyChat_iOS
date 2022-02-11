//
//  ChatsViewModel.swift
//  MyChat
//
//  Created by Emre Topçu on 27.01.2022.
//

import Foundation

class ChatsViewModel: ObservableObject, ChatsDelegate {
    
    @Published var chats: [ChatType]
    
    let chatsModel: ChatsModel
    let userDefaultsModel: UserDefaultsModel
    
    init(){
        chatsModel = ChatsModel.shared
        userDefaultsModel = UserDefaultsModel.shared
        chats = [ChatType]()
        chatsModel.chatsDelegate = self
    }
    
    func getData(){
        chatsModel.getChatsData()
    }
    
    func deleteChat(id: String){
        chatsModel.deleteChat(id: id)
    }
    
    func deleteChats(id: [String]){
        chatsModel.deleteChats(id: id)
    }
    
    // MARK: DELEGATE METHODS
    func onChatsDataReceived(chats: [ChatType]) {
        self.chats = chats
    }
}
