//
//  ProfileModel.swift
//  MyChat
//
//  Created by Emre Topçu on 28.01.2022.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class ProfileModel {
    
    static let shared = ProfileModel()
    var profileDelegate: ProfileDelegate?
    let userDefaultsModel: UserDefaultsModel
    let dbRef: Firestore
    let usersRef: CollectionReference
    let storageRef: StorageReference
    private var user: UserType?
    
    private init(){
        userDefaultsModel = UserDefaultsModel.shared
        dbRef = Firestore.firestore()
        usersRef = dbRef.collection("users")
        storageRef = Storage.storage().reference()
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
                            user = UserType(mobile: userDefaultsModel.mobile, password: "", name: receivedUser.name, email: receivedUser.email, pictureUrl: receivedUser.pictureUrl == "" ? nil : receivedUser.pictureUrl)
                            profileDelegate?.onDataReceived(user: user!)
                        }
                    case .failure(_):
                        break
                    }
                    break // since just one document will be returned
                }
            }
        }
        else {
            profileDelegate?.onDataReceived(user: user!)
        }
    }
    
    func setData(user: UserType){
        if self.user?.pictureUrl != user.pictureUrl && !(self.user?.pictureUrl == nil && user.pictureUrl == nil)  {
            if let url = user.pictureUrl {
                if self.user?.pictureUrl == nil {
                    let imageRef = storageRef.child("\(userDefaultsModel.mobile)")
                    imageRef.putFile(from: URL(string: url)!, metadata: nil) { [self] _, error in
                        imageRef.downloadURL { (url, error) in
                            guard let downloadURL = url else {
                                return
                            }
                            self.user?.pictureUrl = downloadURL.absoluteString
                            user.pictureUrl = downloadURL.absoluteString
                            updateDatabase(user: user)
                        }
                    }
                }
                else {
                    let deletedImageRef = storageRef.child("\(userDefaultsModel.mobile)")
                    deletedImageRef.delete { [self] error in
                        guard error == nil else {
                            return
                        }
                        let imageRef = storageRef.child("\(userDefaultsModel.mobile)")
                        imageRef.putFile(from: URL(string: url)!, metadata: nil) { [self] _, error in
                            imageRef.downloadURL { (url, error) in
                                guard let downloadURL = url else {
                                    return
                                }
                                self.user?.pictureUrl = downloadURL.absoluteString
                                user.pictureUrl = downloadURL.absoluteString
                                updateDatabase(user: user)
                            }
                        }
                    }
                }
            }
            else {
                if self.user?.pictureUrl == nil {
                    // impossible
                }
                else {
                    let deletedImageRef = storageRef.child("\(userDefaultsModel.mobile)")
                    deletedImageRef.delete { [self] error in
                        guard error == nil else {
                            return
                        }
                        self.user?.pictureUrl = nil
                        updateDatabase(user: user)
                    }
                }
            }
        }
        else {
            updateDatabase(user: user)
        }
    }
    
    private func updateDatabase(user: UserType){
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
                                self.profileDelegate?.onDataReceived(user: self.user!)
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
                                self.profileDelegate?.onDataReceived(user: self.user!)
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
    
    func logout(){
        do {
            userDefaultsModel.isKeptLoggedIn = false
            try Auth.auth().signOut()
        }
        catch {
            logout()
        }
    }
}
