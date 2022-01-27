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
    
    private let loginModel = LoginModel.shared
    
    init(){
        loginModel.loginProtocol = self
    }
    
    func login(mobile: String, password: String, isPasswordSaved: Bool, isKeptLoggedIn: Bool){
        loginResult = nil
        loginModel.login(mobile: mobile, password: password, isPasswordSaved: isPasswordSaved, isKeptLoggedIn: isKeptLoggedIn)
        
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
