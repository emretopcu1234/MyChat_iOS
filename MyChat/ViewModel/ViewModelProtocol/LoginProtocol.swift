//
//  LoginProtocol.swift
//  MyChat
//
//  Created by Emre Topçu on 27.01.2022.
//

import Foundation

protocol LoginProtocol {
    
    func loginSuccessful()
    func loginUnsuccessfulWithInvalidUser()
    func loginUnsuccessfulWithWrongPassword()
    func loginUnsuccessfulWithUnknownReason()
    
}
