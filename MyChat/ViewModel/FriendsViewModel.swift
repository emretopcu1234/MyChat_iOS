//
//  FriendsViewModel.swift
//  MyChat
//
//  Created by Emre Topçu on 27.01.2022.
//

import Foundation

enum CreateFriendState {
    case successful
    case unsuccessfulWithInvalidMobile
    case unsuccessfulWithUnknownReason
}

class FriendsViewModel: ObservableObject, FriendsDelegate {
    
    @Published var friends: [FriendType]
    @Published var createFriendState: CreateFriendState?
    
    let friendsModel: FriendsModel
    let userDefaultsModel: UserDefaultsModel
    
    init(){
        friendsModel = FriendsModel.shared
        userDefaultsModel = UserDefaultsModel.shared
        friends = [FriendType]()
        friendsModel.friendsDelegate = self
        createFriendState = nil
    }
        
    func getData(){
        friendsModel.getFriendsData()
    }
    
    func deleteFriend(mobile: String){
        friendsModel.deleteFriend(mobile: mobile)
    }
    
    func deleteFriends(mobile: [String]){
        friendsModel.deleteFriends(mobile: mobile)
    }
    
    func createFriend(mobile: String){
        createFriendState = nil
        friendsModel.createFriend(mobile: mobile)
    }
    
    // MARK: DELEGATE METHODS
    func onFriendsDataReceived(friends: [FriendType]) {
        self.friends = friends
    }
    
    func onCreateFriendSuccessful(friends: [FriendType]) {
        createFriendState = .successful
        self.friends = friends
    }
    
    func onCreateFriendUnsuccessfulWithInvalidMobile() {
        createFriendState = .unsuccessfulWithInvalidMobile
    }
    
    func onCreateFriendUnsuccessfulWithUnknownReason() {
        createFriendState =  .unsuccessfulWithUnknownReason
    }
    
}
