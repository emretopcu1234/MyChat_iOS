//
//  ChatsRowView.swift
//  MyChat
//
//  Created by Emre Topçu on 13.01.2022.
//

import SwiftUI

struct ChatsRowView: View {
    
    @State var selected: Bool?
    
    var body: some View {
        VStack {
            Divider()
            NavigationLink(destination: SpecificChatView(), tag: true, selection: $selected) {
                Button {
                    selected = true
                } label: {
                    HStack {
                        Image(systemName: "person.circle")
                            .resizable()
                            .aspectRatio(1, contentMode: .fill)
                            .frame(width: 60, height: 60)
                        VStack {
                            Text("Michael Clooney")
                                .font(.title2)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
                                .font(.system(size: 15))
                                .foregroundColor(Color("Gray"))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .lineLimit(2)
                        }
                        Spacer()
                        VStack(alignment: .trailing, spacing: 5) {
                            Text("Yesterday")
                                .font(.system(size: 15))
                                .foregroundColor(Color("Gray"))
                                .frame(width: 70, alignment: .trailing)
                                .lineLimit(2)
                            ZStack {
                                Image(systemName: "circle.fill")
                                    .scaleEffect(1.5)
                                    .foregroundColor(.blue)
                                Text("13")
                                    .foregroundColor(.white)
                            }
                            .padding(.top, 3)
                            .padding(.trailing, 3)
                        }
                    }
                }
                .buttonStyle(PlainButtonStyle())
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding(.leading)
        .padding(.trailing)
    }
}

struct ChatsRowView_Previews: PreviewProvider {
    static var previews: some View {
        ChatsRowView()
    }
}
