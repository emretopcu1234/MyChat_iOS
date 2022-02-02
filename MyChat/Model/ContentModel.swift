//
//  ContentModel.swift
//  MyChat
//
//  Created by Emre Topçu on 2.02.2022.
//

import Foundation
import FirebaseAuth

class ContentModel {
    
    static let shared = ContentModel()
    private let emailDomain = "@mychatapp.com"
    var contentProtocol: ContentProtocol?
    let userDefaultsModel: UserDefaultsModel
    
    private init(){
        userDefaultsModel = UserDefaultsModel.shared
    }
    
    func login(){
        Auth.auth().signIn(withEmail: userDefaultsModel.mobile + emailDomain, password: userDefaultsModel.password) { [self] (result, error) in
            if error == nil {
                contentProtocol?.onLoginSuccessful()
            }
            else {
                login()
            }
        }
    }
}
