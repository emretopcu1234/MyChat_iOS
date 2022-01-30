//
//  UserType.swift
//  MyChat
//
//  Created by Emre Topçu on 28.01.2022.
//

import Foundation
import SwiftUI

class UserType {
    var mobile: String
    var password: String
    var name: String
    var email: String
    var pictureUrl: String?
    
    init(mobile: String, password: String, name: String, email: String, pictureUrl: String?){
        self.mobile = mobile
        self.password = password
        self.name = name
        self.email = email
        self.pictureUrl = pictureUrl
    }
}
