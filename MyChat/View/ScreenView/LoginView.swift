//
//  LoginView.swift
//  MyChat
//
//  Created by Emre Topçu on 24.01.2022.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var loginViewModel: LoginViewModel
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @StateObject var keyboardHeightHelper = KeyboardHeightHelper()
    
    @State private var showAlert = false
    @State private var textFieldMobile: String = ""
    @State private var textFieldPassword: String = ""
    @State private var passwordToggleActive = false
    @State private var keepLoggedInToggleActive = false
    @State private var alertText: String = ""
    
    @Binding var loginSuccessful: Bool?
    
    @FocusState private var isMobileFocused: Bool
    @FocusState private var isPasswordFocused: Bool
        
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
            .onTapGesture {
                isMobileFocused = true
            }
            VStack(alignment: .leading, spacing: 0) {
                Text("Password")
                    .font(.title3)
                    .padding(.leading)
                SecureField("Enter password", text: $textFieldPassword)
                    .padding(.leading)
                    .focused($isPasswordFocused)
            }
            .frame(maxWidth: UIScreen.main.bounds.width - 30)
            .padding(EdgeInsets.init(top: 10, leading: 0, bottom: 10, trailing: 0))
            .background(.white)
            .cornerRadius(15)
            .onTapGesture {
                isPasswordFocused = true
            }
            Toggle(isOn: $passwordToggleActive) {
                Text("Save password")
                    .font(.system(size: 20))
            }
            .tint(Color("Blue"))
            .padding(EdgeInsets(top: 10, leading: 30, bottom: 0, trailing: 30))
            Toggle(isOn: $keepLoggedInToggleActive) {
                Text("Keep logged in")
                    .font(.system(size: 20))
            }
            .tint(Color("Blue"))
            .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 30))
            Spacer()
                .frame(height: 30)
            Button {
                let loginData = LoginType(mobile: textFieldMobile, password: textFieldPassword, isPasswordSaved: passwordToggleActive, isKeptLoggedIn: keepLoggedInToggleActive)
                loginViewModel.login(loginData: loginData)
            } label: {
                Text("LOGIN")
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
                Alert(title: Text("Error"), message: Text(alertText), dismissButton: .default(Text("OK")))
            }
            Spacer()
        }
        .frame(width: UIScreen.self.main.bounds.width, height: UIScreen.self.main.bounds.height)
        .padding(.top, CGFloat(UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0))
        .ignoresSafeArea(edges: .top)
        .background(Color("DarkWhite"))
        .adaptsToKeyboard()
        .onAppear {
            loginSuccessful = false
            loginViewModel.updateData()
            textFieldMobile = loginViewModel.mobile
            textFieldPassword = loginViewModel.password
            passwordToggleActive = loginViewModel.isPasswordSaved
            keepLoggedInToggleActive = loginViewModel.isKeptLoggedIn
            UINavigationBar.setAnimationsEnabled(true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                isMobileFocused = true
            }
        }
        .onDisappear(perform: {
            loginViewModel.disappeared()
        })
        .onTapGesture {
            isMobileFocused = false
            isPasswordFocused = false
        }
        .onReceive(loginViewModel.$loginResult, perform: { loginResult in
            if let result = loginResult {
                if result == .successful {
                    UINavigationBar.setAnimationsEnabled(true)
                    presentationMode.wrappedValue.dismiss()
                    loginSuccessful = true
                }
                else if result == .invalidUser {
                    alertText = "There does not exist any user with this mobile."
                    showAlert = true
                }
                else if result == .wrongPassword {
                    alertText = "Mismatch on mobile and password."
                    showAlert = true
                }
                else {
                    alertText = "Login unsuccessful with unknown error."
                    showAlert = true
                }
            }
        })
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            LoginView(loginSuccessful: .constant(false))
        }
    }
}
