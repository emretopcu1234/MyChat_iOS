//
//  CreateFriendView.swift
//  MyChat
//
//  Created by Emre Topçu on 23.01.2022.
//

import SwiftUI

struct CreateFriendView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var textFieldMobile: String = ""
    
    @FocusState private var isMobileFocused: Bool
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    presentationMode.wrappedValue.dismiss()
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
                        .disabled(textFieldMobile.count == 0 ? true : false)
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
                    .focused($isMobileFocused)
            }
            .frame(maxWidth: UIScreen.main.bounds.width - 30)
            .padding(EdgeInsets.init(top: 10, leading: 0, bottom: 10, trailing: 0))
            .background(.white)
            .cornerRadius(15)
            Spacer()
        }
        .frame(width: UIScreen.self.main.bounds.width, height: UIScreen.self.main.bounds.height)
        .padding(.top, CGFloat(UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0))
        .ignoresSafeArea(edges: .top)
        .background(Color("DarkWhite"))
        .adaptsToKeyboard()
        .onAppear {
            UINavigationBar.setAnimationsEnabled(true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                isMobileFocused = true
            }
        }
    }
}

struct CreateFriendView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            CreateFriendView()
        }
    }
}
