//
//  ContentViewModel.swift
//  MyChat
//
//  Created by Emre Topçu on 26.01.2022.
//

import Foundation

class ContentViewModel: ObservableObject, ContentDelegate {
    
    @Published var loginResult: LoginState?
    
    let contentModel = ContentModel.shared
    
    var loginActive: Bool
    
    init(){
        loginActive = !UserDefaultsModel.shared.isKeptLoggedIn
        contentModel.contentDelegate = self
    }
    
    func login(){
        loginResult = nil
        contentModel.login()
    }
    
    // MARK: PROTOCOL METHODS
    func onLoginSuccessful() {
        loginResult = LoginState.Successful
    }
}
