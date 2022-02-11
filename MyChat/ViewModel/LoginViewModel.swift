//
//  LoginViewModel.swift
//  MyChat
//
//  Created by Emre Topçu on 27.01.2022.
//

import Foundation

enum LoginState {
    case successful
    case invalidUser
    case wrongPassword
    case unknownError
}

class LoginViewModel: ObservableObject, LoginDelegate {
    
    @Published var loginResult: LoginState?
    var mobile: String
    var password: String
    var isPasswordSaved: Bool
    var isKeptLoggedIn: Bool
    
    let loginModel: LoginModel
    let userDefaultsModel: UserDefaultsModel
    
    
    init(){
        loginModel = LoginModel.shared
        userDefaultsModel = UserDefaultsModel.shared
        mobile = userDefaultsModel.mobile
        password = userDefaultsModel.password
        isPasswordSaved = userDefaultsModel.isPasswordSaved
        isKeptLoggedIn = userDefaultsModel.isKeptLoggedIn
        loginModel.loginDelegate = self
    }
    
    func disappeared(){
        loginResult = nil
    }
    
    func updateData(){
        mobile = userDefaultsModel.mobile
        password = userDefaultsModel.password
        isPasswordSaved = userDefaultsModel.isPasswordSaved
        isKeptLoggedIn = userDefaultsModel.isKeptLoggedIn
    }
    
    func login(loginData: LoginType){
        loginResult = nil
        loginModel.login(loginData: loginData)
    }
    
    // MARK: DELEGATE METHODS
    func onLoginSuccessful() {
        loginResult = .successful
    }
    
    func onLoginUnsuccessfulWithInvalidUser() {
        loginResult = .invalidUser
    }
    
    func onLoginUnsuccessfulWithWrongPassword() {
        loginResult = .wrongPassword
    }
    
    func onLoginUnsuccessfulWithUnknownReason() {
        loginResult = .unknownError
    }
}
