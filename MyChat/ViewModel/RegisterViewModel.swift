//
//  RegisterViewModel.swift
//  MyChat
//
//  Created by Emre Topçu on 27.01.2022.
//

import Foundation

enum RegisterState {
    case successful
    case unavailableMobile
    case unknownError
}

class RegisterViewModel: ObservableObject, RegisterDelegate {
    
    @Published var registerResult: RegisterState?
    
    let registerModel: RegisterModel
    
    init(){
        registerModel = RegisterModel.shared
        registerModel.registerDelegate = self
    }
    
    func disappeared(){
        registerResult = nil
    }
    
    func register(registerData: UserType){
        registerModel.register(registerData: registerData)
    }
    
    // MARK: DELEGATE METHODS
    func onRegisterSuccessful() {
        registerResult = .successful
    }
    
    func onRegisterUnsuccessfulWithUnavailableMobile() {
        registerResult = .unavailableMobile
    }
    
    func onRegisterUnsuccessfulWithUnknownReason() {
        registerResult = .unknownError
    }
}
