//
//  ContentModel.swift
//  MyChat
//
//  Created by Emre Topçu on 2.02.2022.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class ContentModel {
    
    static let shared = ContentModel()
    private let emailDomain = "@mychatapp.com"
    var contentDelegate: ContentDelegate?
    let userDefaultsModel: UserDefaultsModel
    let dbRef: Firestore
    let usersRef: CollectionReference
    
    private init(){
        userDefaultsModel = UserDefaultsModel.shared
        dbRef = Firestore.firestore()
        usersRef = dbRef.collection("users")
    }
    
    func login(){
        Auth.auth().signIn(withEmail: userDefaultsModel.mobile + emailDomain, password: userDefaultsModel.password) { [self] (result, error) in
            guard error == nil else {
                login()
                return
            }
            contentDelegate?.onLoginSuccessful()
            if userDefaultsModel.mobile != "" {
                usersRef.whereField("mobile", isEqualTo: userDefaultsModel.mobile).getDocuments { [self] querySnapshot, error in
                    guard error == nil else {
                        return
                    }
                    for document in querySnapshot!.documents {
                        let result = Result {
                            try document.data(as: DocUserType.self)
                        }
                        switch result {
                        case .success(let receivedUser):
                            if receivedUser != nil {
                                usersRef.document(document.documentID).updateData([
                                    "lastSeen": 2147483647
                                ])
                            }
                        case .failure(_):
                            break
                        }
                        break // since just one document will be returned
                    }
                }
            }
        }
    }
    
    func enterApp() {
        if userDefaultsModel.mobile != "" && userDefaultsModel.isKeptLoggedIn == true && FriendsModel.shared.getUserDocumentID() != "" {
            Auth.auth().signIn(withEmail: userDefaultsModel.mobile + emailDomain, password: userDefaultsModel.password) { [self] (result, error) in
                guard error == nil else {
                    enterApp()
                    return
                }
                usersRef.document(FriendsModel.shared.getUserDocumentID()).updateData([
                    "lastSeen": 2147483647
                ])
            }
        }
    }
    
    func exitApp(){
        if userDefaultsModel.mobile != "" && userDefaultsModel.isKeptLoggedIn == true && FriendsModel.shared.getUserDocumentID() != "" {
            let time: TimeInterval = NSDate().timeIntervalSince1970
            usersRef.document(FriendsModel.shared.getUserDocumentID()).updateData([
                "lastSeen": TimeInterval(Int(time))
            ])
            { [self] error in
                if error == nil {
                    do {
                        try Auth.auth().signOut()
                    }
                    catch {
                        exitApp()
                    }
                }
                else {
                    exitApp()
                }
            }
        }
    }
}
