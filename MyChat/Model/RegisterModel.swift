//
//  RegisterModel.swift
//  MyChat
//
//  Created by Emre Topçu on 27.01.2022.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class RegisterModel {
    
    static let shared = RegisterModel()
    private let emailDomain = "@mychatapp.com"
    var registerDelegate: RegisterDelegate?
    let userDefaultsModel: UserDefaultsModel
    let dbRef: Firestore
    let usersRef: CollectionReference
    
    private init(){
        userDefaultsModel = UserDefaultsModel.shared
        dbRef = Firestore.firestore()
        usersRef = dbRef.collection("users")
    }
    
    func register(registerData: UserType){
        Auth.auth().createUser(withEmail: registerData.mobile + emailDomain, password: registerData.password) { [self] authResult, error in
            if let err = error {
                if let errCode = AuthErrorCode(rawValue: err._code) {
                    if errCode == .emailAlreadyInUse {
                        registerDelegate?.onRegisterUnsuccessfulWithUnavailableMobile()
                    }
                    else {
                        registerDelegate?.onRegisterUnsuccessfulWithUnknownReason()
                    }
                }
                else {
                    registerDelegate?.onRegisterUnsuccessfulWithUnknownReason()
                }
            }
            else {
                let user = DocUserType(mobile: registerData.mobile, name: registerData.name, email: registerData.email, lastSeen: 0, pictureUrl: "", friends: [String]())
                do {
                    try usersRef.document().setData(from: user) { error in
                        if error != nil {
                            registerDelegate?.onRegisterUnsuccessfulWithUnknownReason()
                        }
                        else {
                            userDefaultsModel.mobile = registerData.mobile
                            userDefaultsModel.isPasswordSaved = false
                            userDefaultsModel.isKeptLoggedIn = false
                            userDefaultsModel.password = ""
                            registerDelegate?.onRegisterSuccessful()
                            do {
                                try Auth.auth().signOut()
                            }
                            catch {}
                        }
                    }
                }
                catch _ {
                    registerDelegate?.onRegisterUnsuccessfulWithUnknownReason()
                }
            }
        }
    }
}
