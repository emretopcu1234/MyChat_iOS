//
//  CreateChatRowView.swift
//  MyChat
//
//  Created by Emre Topçu on 23.01.2022.
//

import SwiftUI

struct CreateChatRowView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @Binding var newChatSelected: Bool
    
    var body: some View {
        ZStack {
            VStack {
                Divider()
                Button {
                    presentationMode.wrappedValue.dismiss()
                    newChatSelected = true
                } label: {
                    HStack {
                        Image(systemName: "person.circle")
                            .resizable()
                            .aspectRatio(1, contentMode: .fill)
                            .frame(width: 50, height: 50)
                        VStack {
                            Text("Michael Clooney")
                                .font(.title2)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("last seen yesterday at 11:38")
                                .font(.system(size: 15))
                                .foregroundColor(Color("Gray"))
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }
                .padding(EdgeInsets.init(top: 0, leading: 10, bottom: 0, trailing: 10))
                .buttonStyle(PlainButtonStyle())
            }
            .padding(.bottom, 5)
            .background(.white)
            
        }
        .padding(.bottom, -7)
        .background(.white)
    }
}

struct CreateChatRowView_Previews: PreviewProvider {
    static var previews: some View {
        CreateChatRowView(newChatSelected: .constant(false))
    }
}
