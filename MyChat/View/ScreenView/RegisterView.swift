//
//  RegisterView.swift
//  MyChat
//
//  Created by Emre Topçu on 24.01.2022.
//

import SwiftUI

struct RegisterView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var showAlert = false
    @State private var textFieldMobile: String = ""
    @State private var textFieldPassword: String = ""
    @State private var textFieldPasswordAgain: String = ""
    @State private var textFieldName: String = ""
    @State private var textFieldEmail: String = ""
    
    @Binding var registerSuccessful: Bool?
    
    @FocusState private var isMobileFocused: Bool
    @FocusState private var isPasswordFocused: Bool
    @FocusState private var isPasswordAgainFocused: Bool
    @FocusState private var isNameFocused: Bool
    @FocusState private var isEmailFocused: Bool
    
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
            }
            Spacer()
                .frame(height: 20)
            VStack(alignment: .leading, spacing: 0) {
                Text("Mobile")
                    .font(.title3)
                    .padding(.leading)
                TextField("Enter mobile", text: $textFieldMobile)
                    .padding(.leading)
                    .keyboardType(.numberPad)
                    .focused($isMobileFocused)
            }
            .onTapGesture {
                isMobileFocused = true
            }
            .frame(maxWidth: UIScreen.main.bounds.width - 30)
            .padding(EdgeInsets.init(top: 5, leading: 0, bottom: 5, trailing: 0))
            .background(.white)
            .cornerRadius(15)
            VStack(alignment: .leading, spacing: 0) {
                Text("Password")
                    .font(.title3)
                    .padding(.leading)
                TextField("Enter password", text: $textFieldPassword)
                    .padding(.leading)
                    .focused($isPasswordFocused)
            }
            .onTapGesture {
                isPasswordFocused = true
            }
            .frame(maxWidth: UIScreen.main.bounds.width - 30)
            .padding(EdgeInsets.init(top: 5, leading: 0, bottom: 5, trailing: 0))
            .background(.white)
            .cornerRadius(15)
            VStack(alignment: .leading, spacing: 0) {
                Text("Password")
                    .font(.title3)
                    .padding(.leading)
                TextField("Enter password again", text: $textFieldPasswordAgain)
                    .padding(.leading)
                    .focused($isPasswordAgainFocused)
            }
            .onTapGesture {
                isPasswordAgainFocused = true
            }
            .frame(maxWidth: UIScreen.main.bounds.width - 30)
            .padding(EdgeInsets.init(top: 5, leading: 0, bottom: 5, trailing: 0))
            .background(.white)
            .cornerRadius(15)
            VStack(alignment: .leading, spacing: 0) {
                Text("Name")
                    .font(.title3)
                    .padding(.leading)
                TextField("Enter name", text: $textFieldName)
                    .padding(.leading)
                    .focused($isNameFocused)
            }
            .onTapGesture {
                isNameFocused = true
            }
            .frame(maxWidth: UIScreen.main.bounds.width - 30)
            .padding(EdgeInsets.init(top: 5, leading: 0, bottom: 5, trailing: 0))
            .background(.white)
            .cornerRadius(15)
            VStack(alignment: .leading, spacing: 0) {
                Text("E-mail")
                    .font(.title3)
                    .padding(.leading)
                TextField("Enter e-mail", text: $textFieldEmail)
                    .padding(.leading)
                    .focused($isEmailFocused)
            }
            .onTapGesture {
                isEmailFocused = true
            }
            .frame(maxWidth: UIScreen.main.bounds.width - 30)
            .padding(EdgeInsets.init(top: 5, leading: 0, bottom: 5, trailing: 0))
            .background(.white)
            .cornerRadius(15)
            Spacer()
                .frame(height: 20)
            Button {
                UINavigationBar.setAnimationsEnabled(true)
                presentationMode.wrappedValue.dismiss()
                registerSuccessful = true
//                showAlert = true
            } label: {
                Text("REGISTER")
                    .font(.system(size: 30))
                    .bold()
                    .padding(5)
                    .foregroundColor(.white)
                    .frame(width: 200)
                    .background(Color("Blue"))
                    .clipShape(RoundedRectangle(cornerRadius: CGFloat(15)))
            }
            .buttonStyle(PlainButtonStyle())
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text("There is an existing user with this mobile"), dismissButton: .default(Text("OK")))
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
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                isMobileFocused = true
            }
        }
        .onTapGesture {
            isMobileFocused = false
            isPasswordFocused = false
            isPasswordAgainFocused = false
            isNameFocused = false
            isEmailFocused = false
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            RegisterView(registerSuccessful: .constant(false))
        }
    }
}
