//
//  LoginModel.swift
//  MyChat
//
//  Created by Emre Topçu on 26.01.2022.
//

import Foundation
import Firebase

class LoginModel {
    
    static let shared = LoginModel()
    private let emailDomain = "@mychatapp.com"
    var loginProtocol: LoginProtocol?
    
    
    private init(){
    }
    
    func login(mobile: String, password: String, isPasswordSaved: Bool, isKeptLoggedIn: Bool){
        Auth.auth().signIn(withEmail: mobile + emailDomain, password: password) { [self] (result, error) in
            if let err = error {
                if let errCode = AuthErrorCode(rawValue: err._code) {
                    if errCode == .userNotFound {
                        loginProtocol?.loginUnsuccessfulWithInvalidUser()
                    }
                    else if errCode == .wrongPassword {
                        loginProtocol?.loginUnsuccessfulWithWrongPassword()
                    }
                    else {
                        loginProtocol?.loginUnsuccessfulWithUnknownReason()
                    }
                }
            }
            else {
                loginProtocol?.loginSuccessful()
            }
        }
    }
}
