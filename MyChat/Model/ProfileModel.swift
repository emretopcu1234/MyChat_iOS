//
//  ProfileModel.swift
//  MyChat
//
//  Created by Emre Topçu on 28.01.2022.
//

import Foundation
import FirebaseFirestore

class ProfileModel {
    
    static let shared = ProfileModel()
    var profileProtocol: ProfileProtocol?
    let userDefaultsModel: UserDefaultsModel
    let dbRef: Firestore
    let usersRef: CollectionReference
    private var user: UserType?
    
    private init(){
        userDefaultsModel = UserDefaultsModel.shared
        dbRef = Firestore.firestore()
        usersRef = dbRef.collection("users")
        user = nil
    }
    
    func getData(){
        if user == nil {
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
                        if let receivedUser = receivedUser {
                            user = UserType(mobile: userDefaultsModel.mobile, password: "", name: receivedUser.name, email: receivedUser.email, pictureUrl: receivedUser.pictureUrl)
                            profileProtocol?.onDataReceived(user: user!)
                        }
                    case .failure(_):
                        break
                    }
                    break // since just one document will be returned
                }
            }
        }
        else {
            profileProtocol?.onDataReceived(user: user!)
        }
    }
    
    func setData(user: UserType){
        usersRef.whereField("mobile", isEqualTo: userDefaultsModel.mobile).getDocuments { [self] querySnapshot, error in
            guard error == nil else {
                return
            }
            for document in querySnapshot!.documents {
                let result = Result {
                    try document.data(as: DocUserType.self)
                }
                switch result {
                case .success(_):
                    if let url = user.pictureUrl {
                        usersRef.document(document.documentID).updateData([
                            "name": user.name,
                            "email": user.email,
                            "pictureUrl": url
                        ]) { error in
                            if error == nil {
                                self.user?.name = user.name
                                self.user?.email = user.email
                                self.user?.pictureUrl = url
                                self.profileProtocol?.onDataReceived(user: self.user!)
                            }
                        }
                    }
                    else {
                        usersRef.document(document.documentID).updateData([
                            "name": user.name,
                            "email": user.email,
                            "pictureUrl": ""
                        ]) { error in
                            if error == nil {
                                self.user?.name = user.name
                                self.user?.email = user.email
                                self.user?.pictureUrl = nil
                                self.profileProtocol?.onDataReceived(user: self.user!)
                            }
                        }
                    }
                case .failure(_):
                    break
                }
                break // since just one document will be returned
            }
        }
        
        
        
        
        
        
        
    }
}
