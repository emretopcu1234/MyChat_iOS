//
//  LoginModel.swift
//  MyChat
//
//  Created by Emre Topçu on 26.01.2022.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class LoginModel {
    
    static let shared = LoginModel()
    private let emailDomain = "@mychatapp.com"
    var loginDelegate: LoginDelegate?
    let userDefaultsModel: UserDefaultsModel
    let dbRef: Firestore
    let usersRef: CollectionReference
    
    private init(){
        userDefaultsModel = UserDefaultsModel.shared
        dbRef = Firestore.firestore()
        usersRef = dbRef.collection("users")
    }
    
    func login(loginData: LoginType){
        Auth.auth().signIn(withEmail: loginData.mobile + emailDomain, password: loginData.password) { [self] (result, error) in
            if let err = error {
                if let errCode = AuthErrorCode(rawValue: err._code) {
                    if errCode == .userNotFound {
                        loginDelegate?.onLoginUnsuccessfulWithInvalidUser()
                    }
                    else if errCode == .wrongPassword {
                        loginDelegate?.onLoginUnsuccessfulWithWrongPassword()
                    }
                    else {
                        loginDelegate?.onLoginUnsuccessfulWithUnknownReason()
                    }
                }
                else {
                    loginDelegate?.onLoginUnsuccessfulWithUnknownReason()
                }
            }
            else {
                userDefaultsModel.mobile = loginData.mobile
                userDefaultsModel.isPasswordSaved = loginData.isPasswordSaved
                userDefaultsModel.isKeptLoggedIn = loginData.isKeptLoggedIn
                if loginData.isPasswordSaved {
                    userDefaultsModel.password = loginData.password
                }
                else {
                    userDefaultsModel.password = ""
                }
                loginDelegate?.onLoginSuccessful()
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
}
