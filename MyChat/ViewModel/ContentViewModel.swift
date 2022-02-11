//
//  ContentViewModel.swift
//  MyChat
//
//  Created by Emre Topçu on 26.01.2022.
//

import Foundation

class ContentViewModel: ObservableObject, ContentDelegate {
    
    @Published var loginResult: LoginState?
    
    let contentModel: ContentModel
    
    var loginActive: Bool
    
    init(){
        contentModel = ContentModel.shared
        loginActive = !UserDefaultsModel.shared.isKeptLoggedIn
        contentModel.contentDelegate = self
    }
    
    func login(){
        loginResult = nil
        contentModel.login()
    }
    
    // MARK: DELEGATE METHODS
    func onLoginSuccessful() {
        loginResult = LoginState.successful
    }
}
