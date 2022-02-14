//
//  SpecificChatRowView.swift
//  MyChat
//
//  Created by Emre Topçu on 14.01.2022.
//

import SwiftUI


struct SpecificChatRowView: View {
    
    @Binding var specificChatRowType: SpecificChatRowType
    
    var body: some View {
        HStack {
            switch specificChatRowType.rowEnum {
            case .sender:
                VStack {
                    HStack {
                        Spacer()
                        Text(specificChatRowType.rowInfo1!)
                            .font(.system(size: 17))
                            .padding(EdgeInsets.init(top: 8, leading: 10, bottom: 8, trailing: 70))
                            .overlay(
                                Text(specificChatRowType.rowInfo2!)
                                    .font(.system(size: 12))
                                    .foregroundColor(.gray)
                                    .padding(EdgeInsets.init(top: 8, leading: 0, bottom: 3, trailing: 10))
                                , alignment: .bottomTrailing)
                            .background(Color("LightGreen"))
                            .clipShape(ChatBubbleShape(isSender: true))
                    }
                    .padding(EdgeInsets.init(top: 0, leading: 60, bottom: 0, trailing: 6))
                }
            case .receiver:
                VStack {
                    HStack {
                        Text(specificChatRowType.rowInfo1!)
                            .font(.system(size: 17))
                            .padding(EdgeInsets.init(top: 8, leading: 10, bottom: 8, trailing: 70))
                            .overlay(
                                Text(specificChatRowType.rowInfo2!)
                                    .font(.system(size: 12))
                                    .foregroundColor(.gray)
                                    .padding(EdgeInsets.init(top: 8, leading: 10, bottom: 3, trailing: 10))
                                , alignment: .bottomTrailing)
                            .background(.white)
                            .clipShape(ChatBubbleShape(isSender: false))
                            
                        Spacer()
                    }
                    .padding(EdgeInsets.init(top: 0, leading: 6, bottom: 0, trailing: 60))
                }
                
            case .newDate:
                HStack {
                    Spacer()
                    Text(specificChatRowType.rowInfo1!)
                        .font(.system(size: 13))
                        .padding(5)
                        .foregroundColor(.white)
                        .background(Color("Green"))
                        .clipShape(RoundedRectangle(cornerRadius: CGFloat(10)))
                    Spacer()
                }
            case .unreadMessages:
                HStack {
                    Text("Unread Messages")
                        .font(.system(size: 13))
                        .padding(5)
                        .foregroundColor(.gray)
                        .frame(width: UIScreen.self.main.bounds.width)
                        .background(Color("DarkWhite"))
                }
            case .unknownPerson:
                VStack {
                    Text("This person does not exist in your friend list.")
                        .font(.system(size: 17))
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(width: UIScreen.self.main.bounds.width)
                    Divider()
                        .offset(y: -5)
                    HStack {
                        Spacer()
                        Button {
                            // TODO
                        } label: {
                            Text("Add to friends")
                                .font(.system(size: 20))
                                .padding(10)
                        }
                        Spacer()
                    }
                    .offset(y: -5)
                }
                .background(Color("DarkWhite"))
            }
        }
    }
}

struct SpecificChatRowView_Previews: PreviewProvider {
    static var previews: some View {
        SpecificChatRowView(specificChatRowType: .constant(SpecificChatRowType(id: "", rowEnum: SpecificChatRowEnum.sender, rowInfo1: nil, rowInfo2: nil)))
    }
}
