//
//  ContentViewModel.swift
//  MyChat
//
//  Created by Emre Topçu on 26.01.2022.
//

import Foundation

class ContentViewModel {
    
    var loginActive: Bool
    
    init(){
        loginActive = !UserDefaultsModel.shared.isKeptLoggedIn
    }
}
