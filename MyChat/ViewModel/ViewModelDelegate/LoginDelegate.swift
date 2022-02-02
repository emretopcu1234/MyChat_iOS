//
//  LoginProtocol.swift
//  MyChat
//
//  Created by Emre Topçu on 27.01.2022.
//

import Foundation

protocol LoginDelegate {
    
    func onLoginSuccessful()
    func onLoginUnsuccessfulWithInvalidUser()
    func onLoginUnsuccessfulWithWrongPassword()
    func onLoginUnsuccessfulWithUnknownReason()
    
}
