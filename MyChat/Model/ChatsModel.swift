//
//  ChatsModel.swift
//  MyChat
//
//  Created by Emre Topçu on 26.01.2022.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

class ChatsModel {
    
    static let shared = ChatsModel()
    var chatsDelegate: ChatsDelegate?
    let userDefaultsModel: UserDefaultsModel
    let dbRef: Firestore
    let chatsRef: CollectionReference
    let storageRef: StorageReference

    private init(){
        userDefaultsModel = UserDefaultsModel.shared
        dbRef = Firestore.firestore()
        chatsRef = dbRef.collection("chats")
        storageRef = Storage.storage().reference()
    }
}
