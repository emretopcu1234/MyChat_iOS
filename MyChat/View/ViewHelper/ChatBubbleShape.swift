//
//  ChatBubbleShape.swift
//  MyChat
//
//  Created by Emre Topçu on 14.01.2022.
//

import Foundation
import SwiftUI

struct ChatBubbleShape: Shape {
    
    var isSender: Bool
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft, .topRight, isSender ? .bottomLeft : .bottomRight], cornerRadii: CGSize(width: 15, height: 15))
        
        return Path(path.cgPath)
    }
}
