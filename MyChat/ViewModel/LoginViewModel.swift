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

class LoginViewModel: ObservableObject, LoginDelegate {
    
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
        loginModel.loginDelegate = self
    }
    
    func appeared(){
        mobile = userDefaultsModel.mobile
        password = userDefaultsModel.password
        isPasswordSaved = userDefaultsModel.isPasswordSaved
        isKeptLoggedIn = userDefaultsModel.isKeptLoggedIn
    }
    
    func disappeared(){
        loginResult = nil
    }
    
    func login(loginData: LoginType){
        loginResult = nil
        loginModel.login(loginData: loginData)
    }
    
    // MARK: PROTOCOL METHODS
    func onLoginSuccessful() {
        loginResult = .Successful
    }
    
    func onLoginUnsuccessfulWithInvalidUser() {
        loginResult = .InvalidUser
    }
    
    func onLoginUnsuccessfulWithWrongPassword() {
        loginResult = .WrongPassword
    }
    
    func onLoginUnsuccessfulWithUnknownReason() {
        loginResult = .UnknownError
    }
}
