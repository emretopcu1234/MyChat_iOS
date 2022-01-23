//
//  CreateFriendView.swift
//  MyChat
//
//  Created by Emre Topçu on 23.01.2022.
//

import SwiftUI

struct CreateFriendView: View {
    
    @State var textFieldMobile: String = ""
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    // TODO
                } label: {
                    Text("Cancel")
                        .font(.title3)
                        .padding(.leading)
                }
                Spacer()
                Text("New Contact")
                    .font(.system(size: 22))
                    .bold()
                Spacer()
                Button {
                    // TODO
                } label: {
                    Text("Create")
                        .font(.title3)
                        .padding(.trailing)
                        .disabled(true)
                }
            }
            Spacer()
                .frame(height: 30)
            VStack(alignment: .leading, spacing: 0) {
                Text("Mobile")
                    .font(.title3)
                    .padding(.leading)
                TextField("Enter mobile", text: $textFieldMobile)
                    .padding(.leading)
                    .keyboardType(.numberPad)
            }
            .frame(maxWidth: UIScreen.main.bounds.width - 30)
            .padding(EdgeInsets.init(top: 10, leading: 0, bottom: 10, trailing: 0))
            .background(.white)
            .cornerRadius(15)
            .onTapGesture {
                // TODO
            }
            Spacer()
        }
        .frame(width: UIScreen.self.main.bounds.width, height: UIScreen.self.main.bounds.height)
        .padding(.top, CGFloat(UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0))
        .ignoresSafeArea(edges: .top)
        .background(Color("DarkWhite"))
        .adaptsToKeyboard()
        .onAppear {
            UINavigationBar.setAnimationsEnabled(true)
        }
    }
}

struct CreateFriendView_Previews: PreviewProvider {
    static var previews: some View {
        CreateFriendView()
    }
}
