//
//  SpecificChatRowView.swift
//  MyChat
//
//  Created by Emre Topçu on 14.01.2022.
//

import SwiftUI

enum SpecificChatRowType {
    case Sender
    case Receiver
    case NewDate
    case UnreadMessages
}

struct SpecificChatRowView: View {
    
    var specificChatRowType: SpecificChatRowType
    
    var body: some View {
        HStack {
            switch specificChatRowType {
            case .Sender:
                HStack {
                    Spacer()
                        .frame(width:60)
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt")
                        .font(.system(size: 17))
                        .padding(8)
                        .offset(x:-30)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .background(Color("LightGreen"))
                        .clipShape(ChatBubbleShape(isSender: true))
                        .overlay(
                            Text("19:45")
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                                .padding(5)
                            , alignment: .bottomTrailing)
                }
                .padding(.trailing, 6)
            case .Receiver:
                HStack {
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt")
                        .font(.system(size: 17))
                        .padding(8)
                        .padding(.trailing, 30)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(.white)
                        .clipShape(ChatBubbleShape(isSender: false))
                        .overlay(
                            Text("19:45")
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                                .padding(5)
                            , alignment: .bottomTrailing)
                    Spacer()
                        .frame(width:60)
                }
                .padding(.leading, 6)
            case .NewDate:
                HStack {
                    Spacer()
                    Text("November 24, 2021")
                        .font(.system(size: 13))
                        .padding(5)
                        .foregroundColor(.white)
                        .background(Color("Green"))
                        .clipShape(RoundedRectangle(cornerRadius: CGFloat(10)))
                    Spacer()
                }
            case .UnreadMessages:
                HStack {
                    Text("Unread Messages")
                        .font(.system(size: 13))
                        .padding(5)
                        .foregroundColor(.gray)
                        .clipShape(RoundedRectangle(cornerRadius: CGFloat(10)))
                        .frame(width: UIScreen.self.main.bounds.width)
                        .background(Color("DarkWhite"))
                }
            }
        }
    }
}

struct SpecificChatRowView_Previews: PreviewProvider {
    static var previews: some View {
        SpecificChatRowView(specificChatRowType: SpecificChatRowType.Receiver)
    }
}
