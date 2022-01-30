//
//  LoginModel.swift
//  MyChat
//
//  Created by Emre Topçu on 26.01.2022.
//

import Foundation
import FirebaseAuth

class LoginModel {
    
    static let shared = LoginModel()
    private let emailDomain = "@mychatapp.com"
    var loginProtocol: LoginProtocol?
    let userDefaultsModel: UserDefaultsModel
    
    private init(){
        userDefaultsModel = UserDefaultsModel.shared
    }
    
    func login(loginData: LoginType){
        Auth.auth().signIn(withEmail: loginData.mobile + emailDomain, password: loginData.password) { [self] (result, error) in
            if let err = error {
                if let errCode = AuthErrorCode(rawValue: err._code) {
                    if errCode == .userNotFound {
                        loginProtocol?.onLoginUnsuccessfulWithInvalidUser()
                    }
                    else if errCode == .wrongPassword {
                        loginProtocol?.onLoginUnsuccessfulWithWrongPassword()
                    }
                    else {
                        loginProtocol?.onLoginUnsuccessfulWithUnknownReason()
                    }
                }
                else {
                    loginProtocol?.onLoginUnsuccessfulWithUnknownReason()
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
                loginProtocol?.onLoginSuccessful()
            }
        }
    }
}
