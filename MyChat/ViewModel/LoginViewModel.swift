//
//  LoginViewModel.swift
//  MyChat
//
//  Created by Emre Topçu on 27.01.2022.
//

import Foundation

enum LoginState {
    case Successful
    case InvalidUser
    case WrongPassword
    case UnknownError
}

class LoginViewModel: ObservableObject, LoginProtocol {
    
    @Published var loginResult: LoginState?
    var mobile: String
    var password: String
    var isPasswordSaved: Bool
    var isKeptLoggedIn: Bool
    
    let loginModel = LoginModel.shared
    let userDefaultsModel = UserDefaultsModel.shared
    
    
    init(){
        mobile = userDefaultsModel.mobile
        password = userDefaultsModel.password
        isPasswordSaved = userDefaultsModel.isPasswordSaved
        isKeptLoggedIn = userDefaultsModel.isKeptLoggedIn
        loginModel.loginProtocol = self
    }
    
    func getUserDefaults(){
        mobile = userDefaultsModel.mobile
        password = userDefaultsModel.password
        isPasswordSaved = userDefaultsModel.isPasswordSaved
        isKeptLoggedIn = userDefaultsModel.isKeptLoggedIn
    }
    
    func login(loginData: LoginType){
        loginResult = nil
        loginModel.login(loginData: loginData)
        
    }
    
    // MARK: PROTOCOL METHODS
    
    func loginSuccessful() {
        loginResult = .Successful
    }
    
    func loginUnsuccessfulWithInvalidUser() {
        loginResult = .InvalidUser
    }
    
    func loginUnsuccessfulWithWrongPassword() {
        loginResult = .WrongPassword
    }
    
    func loginUnsuccessfulWithUnknownReason() {
        loginResult = .UnknownError
    }
}
