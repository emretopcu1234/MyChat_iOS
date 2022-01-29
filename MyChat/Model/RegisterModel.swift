//
//  RegisterModel.swift
//  MyChat
//
//  Created by Emre Topçu on 27.01.2022.
//

import Foundation
import FirebaseAuth

class RegisterModel {
    
    static let shared = RegisterModel()
    private let emailDomain = "@mychatapp.com"
    var registerProtocol: RegisterProtocol?
    let userDefaultsModel = UserDefaultsModel.shared
    
    private init(){
    }
    
    func register(registerData: UserType){
        Auth.auth().createUser(withEmail: registerData.mobile + emailDomain, password: registerData.password) { [self] authResult, error in
            if let err = error {
                if let errCode = AuthErrorCode(rawValue: err._code) {
                    if errCode == .emailAlreadyInUse {
                        registerProtocol?.registerUnsuccessfulWithUnavailableMobile()
                    }
                    else {
                        registerProtocol?.registerUnsuccessfulWithUnknownReason()
                    }
                }
                else {
                    registerProtocol?.registerUnsuccessfulWithUnknownReason()
                }
            }
            else {
                userDefaultsModel.mobile = registerData.mobile
                userDefaultsModel.isPasswordSaved = false
                userDefaultsModel.isKeptLoggedIn = false
                userDefaultsModel.password = ""
                registerProtocol?.registerSuccessful()
                do {
                    try Auth.auth().signOut()   // just because user made registration, does not mean s/he logged in.
                } catch {
                    // one more chance to signout
                    do {
                        try Auth.auth().signOut()
                    } catch {
                        // nothing to do anymore
                    }
                }
                // TODO yeni user yaratılacak.
            }
        }
    }
}
