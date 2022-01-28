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
    let userDefaultsModel = UserDefaultsModel.shared
    
    private init(){
    }
    
    func login(loginData: LoginType){
        Auth.auth().signIn(withEmail: loginData.mobile + emailDomain, password: loginData.password) { [self] (result, error) in
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
                userDefaultsModel.mobile = loginData.mobile
                userDefaultsModel.isPasswordSaved = loginData.isPasswordSaved
                userDefaultsModel.isKeptLoggedIn = loginData.isKeptLoggedIn
                if loginData.isPasswordSaved {
                    userDefaultsModel.password = loginData.password
                }
                else {
                    userDefaultsModel.password = ""
                }
            }
        }
    }
}
