//
//  ProfileViewModel.swift
//  MyChat
//
//  Created by Emre Topçu on 27.01.2022.
//

import Foundation
import SwiftUI

class ProfileViewModel: ObservableObject, ProfileDelegate {
    
    @Published var dataReceived: Bool?
    var mobile: String
    var name: String
    var email: String
    var pictureUrl: String?
    
    let profileModel = ProfileModel.shared
    let userDefaultsModel = UserDefaultsModel.shared
    
    init(){
        mobile = ""
        name = ""
        email = ""
        pictureUrl = nil
        profileModel.profileDelegate = self
    }
    
    func disappeared(){
        dataReceived = nil
    }
    
    func getData(){
        if mobile != userDefaultsModel.mobile {
            profileModel.getData()
        }
    }
    
    func updateData(user: UserType){
        profileModel.setData(user: user)
    }
    
    func logout(){
        mobile = ""
        name = ""
        email = ""
        pictureUrl = nil
        profileModel.logout()
    }
    
    // MARK: PROTOCOL METHODS
    func onDataReceived(user: UserType) {
        mobile = userDefaultsModel.mobile
        name = user.name
        email = user.email
        pictureUrl = user.pictureUrl
        dataReceived = true
    }
}
