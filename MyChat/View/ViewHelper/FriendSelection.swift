//
//  FriendSelection.swift
//  MyChat
//
//  Created by Emre Topçu on 8.02.2022.
//

import Foundation

class FriendSelection: ObservableObject {
    
    static let shared = FriendSelection()
    @Published var selectedFriends: [String]
    
    private init(){
        selectedFriends = [String]()
    }
    
    func addSelection(selectedFriend: String){
        selectedFriends.append(selectedFriend)
    }
    
    func removeSelection(removedFriend: String){
        selectedFriends = selectedFriends.filter { $0 != removedFriend }
    }
    
    func clearSelection(){
        selectedFriends.removeAll()
    }
}
