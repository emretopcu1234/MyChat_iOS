//
//  ChatSelection.swift
//  MyChat
//
//  Created by Emre Topçu on 10.02.2022.
//

import Foundation

class ChatSelection: ObservableObject {
    
    static let shared = ChatSelection()
    @Published var selectedChats: [String]
    
    private init(){
        selectedChats = [String]()
    }
    
    func addSelection(selectedChat: String){
        selectedChats.append(selectedChat)
    }
    
    func removeSelection(removedChat: String){
        selectedChats = selectedChats.filter { $0 != removedChat }
    }
    
    func clearSelection(){
        selectedChats.removeAll()
    }

}
