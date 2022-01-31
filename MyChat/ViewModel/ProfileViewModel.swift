//
//  ProfileViewModel.swift
//  MyChat
//
//  Created by Emre Topçu on 27.01.2022.
//

import Foundation
import SwiftUI

class ProfileViewModel: ObservableObject, ProfileProtocol {
    
    @Published var dataReceived: Bool?
    var mobile: String
    var name: String
    var email: String
    var pictureUrl: String?
    
    let profileModel = ProfileModel.shared
    let userDefaultsModel = UserDefaultsModel.shared
    
    init(){
        mobile = userDefaultsModel.mobile
        name = ""
        email = ""
        pictureUrl = nil
        profileModel.profileProtocol = self
    }
    
    func appeared(){
        profileModel.getData()
    }
    
    func disappeared(){
        dataReceived = nil
    }
    
    func updateData(user: UserType){
        profileModel.setData(user: user)
    }
    
    // MARK: PROTOCOL METHODS
    
    func onDataReceived(user: UserType) {
        name = user.name
        email = user.email
        pictureUrl = user.pictureUrl
        dataReceived = true
    }
}
