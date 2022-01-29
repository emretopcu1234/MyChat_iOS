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

class RegisterViewModel: ObservableObject, RegisterProtocol {
    
    @Published var registerResult: RegisterState?
    
    let registerModel = RegisterModel.shared
    
    init(){
        registerModel.registerProtocol = self
    }
    
    func register(registerData: UserType){
        registerResult = nil
        registerModel.register(registerData: registerData)
    }
    
    // MARK: PROTOCOL METHODS
    func registerSuccessful() {
        registerResult = .Successful
    }
    
    func registerUnsuccessfulWithUnavailableMobile() {
        registerResult = .UnavailableMobile
    }
    
    func registerUnsuccessfulWithUnknownReason() {
        registerResult = .UnknownError
    }
}
