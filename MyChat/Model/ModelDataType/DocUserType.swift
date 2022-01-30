//
//  DocUserType.swift
//  MyChat
//
//  Created by Emre Topçu on 30.01.2022.
//

import Foundation
import FirebaseFirestoreSwift

public struct DocUserType: Codable {
    
    @DocumentID var id: String?
    var mobile: String
    var name: String
    var email: String
    var lastSeen: TimeInterval
    var pictureUrl: String?
    var friends: [String]?
    
}
