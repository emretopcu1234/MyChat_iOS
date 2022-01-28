//
//  UserDefaultsModel.swift
//  MyChat
//
//  Created by Emre Topçu on 26.01.2022.
//

import Foundation

class UserDefaultsModel {
    
    static let shared = UserDefaultsModel()
    
    var mobile: String {
        get {
            return UserDefaults.standard.string(forKey: "mobile") ?? ""
        }
        set (newValue) {
            UserDefaults.standard.set(newValue, forKey: "mobile")
        }
    }
    var password: String {
        get {
            return UserDefaults.standard.string(forKey: "password") ?? ""
        }
        set (newValue) {
            UserDefaults.standard.set(newValue, forKey: "password")
        }
    }
    var isPasswordSaved: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "isPasswordSaved")
        }
        set (newValue) {
            UserDefaults.standard.set(newValue, forKey: "isPasswordSaved")
        }
    }
    var isKeptLoggedIn: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "isKeptLoggedIn")
        }
        set (newValue) {
            UserDefaults.standard.set(newValue, forKey: "isKeptLoggedIn")
        }
    }
    
    private init(){
    }
}
