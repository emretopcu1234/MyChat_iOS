//
//  RegisterProtocol.swift
//  MyChat
//
//  Created by Emre Topçu on 27.01.2022.
//

import Foundation

protocol RegisterDelegate {
    
    func onRegisterSuccessful()
    func onRegisterUnsuccessfulWithUnavailableMobile()
    func onRegisterUnsuccessfulWithUnknownReason()
    
}
