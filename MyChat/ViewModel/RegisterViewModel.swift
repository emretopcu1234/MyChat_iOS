//
//  RegisterViewModel.swift
//  MyChat
//
//  Created by Emre Topçu on 27.01.2022.
//

import Foundation

enum RegisterState {
    case Successful
    case UnavailableMobile
    case UnknownError
}

class RegisterViewModel: ObservableObject, RegisterDelegate {
    
    @Published var registerResult: RegisterState?
    
    let registerModel = RegisterModel.shared
    
    init(){
        registerModel.registerDelegate = self
    }
    
    func disappeared(){
        registerResult = nil
    }
    
    func register(registerData: UserType){
        registerModel.register(registerData: registerData)
    }
    
    // MARK: PROTOCOL METHODS
    func onRegisterSuccessful() {
        registerResult = .Successful
    }
    
    func onRegisterUnsuccessfulWithUnavailableMobile() {
        registerResult = .UnavailableMobile
    }
    
    func onRegisterUnsuccessfulWithUnknownReason() {
        registerResult = .UnknownError
    }
}
