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
    var registerProtocol: RegisterProtocol?
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
                        registerProtocol?.onRegisterUnsuccessfulWithUnavailableMobile()
                    }
                    else {
                        registerProtocol?.onRegisterUnsuccessfulWithUnknownReason()
                    }
                }
                else {
                    registerProtocol?.onRegisterUnsuccessfulWithUnknownReason()
                }
            }
            else {
                let user = DocUserType(mobile: registerData.mobile, name: registerData.name, email: registerData.email, lastSeen: 0, pictureUrl: nil, friends: nil)
                do {
                    try usersRef.document().setData(from: user) { error in
                        if error != nil {
                            registerProtocol?.onRegisterUnsuccessfulWithUnknownReason()
                        }
                        else {
                            userDefaultsModel.mobile = registerData.mobile
                            userDefaultsModel.isPasswordSaved = false
                            userDefaultsModel.isKeptLoggedIn = false
                            userDefaultsModel.password = ""
                            registerProtocol?.onRegisterSuccessful()
                            do {
                                try Auth.auth().signOut()
                            }
                            catch {}
                        }
                    }
                }
                catch _ {
                    registerProtocol?.onRegisterUnsuccessfulWithUnknownReason()
                }
            }
        }
    }
}
