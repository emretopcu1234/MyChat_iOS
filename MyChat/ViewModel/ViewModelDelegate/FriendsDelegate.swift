//
//  FriendsDelegate.swift
//  MyChat
//
//  Created by Emre Topçu on 3.02.2022.
//

import Foundation

protocol FriendsDelegate {
    
    func onFriendsDataReceived(friends: [FriendType])
    func onCreateFriendSuccessful(friends: [FriendType])
    func onCreateFriendUnsuccessfulWithInvalidMobile()
    func onCreateFriendUnsuccessfulWithUnknownReason()
}
