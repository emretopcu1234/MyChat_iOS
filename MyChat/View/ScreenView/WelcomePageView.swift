//
//  WelcomePageView.swift
//  MyChat
//
//  Created by Emre Topçu on 23.01.2022.
//

import SwiftUI

struct WelcomePageView: View {
    
    @State private var showLoginView = false
    @State private var showRegisterView = false
    @State var loginSuccessful: Bool?
    @State var registerSuccessful: Bool?
    
    
    var body: some View {
        NavigationLink(destination: GeneralView(), tag: true, selection: $loginSuccessful) {
            VStack {
                Text("Welcome to MyChat!")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 40))
                    .padding(30)
                Spacer()
                Text("Login or register to start chatting with your friends!")
                    .multilineTextAlignment(.center)
                    .font(.title)
                    .padding(30)
                Button {
                    UINavigationBar.setAnimationsEnabled(true)
                    showLoginView = true
                } label: {
                    Text("LOGIN")
                        .font(.system(size: 30))
                        .bold()
                        .padding(10)
                        .foregroundColor(.white)
                        .frame(width: 250)
                        .background(Color("Blue"))
                        .clipShape(RoundedRectangle(cornerRadius: CGFloat(20)))
                }
                .buttonStyle(PlainButtonStyle())
                .sheet(isPresented: $showLoginView) {
                    LoginView(loginSuccessful: $loginSuccessful)
                }
                Spacer()
                    .frame(height: 15)
                Button {
                    UINavigationBar.setAnimationsEnabled(true)
                    showRegisterView = true
                } label: {
                    Text("REGISTER")
                        .font(.system(size: 30))
                        .bold()
                        .padding(10)
                        .foregroundColor(.white)
                        .frame(width: 250)
                        .background(Color("Blue"))
                        .clipShape(RoundedRectangle(cornerRadius: CGFloat(20)))
                }
                .buttonStyle(PlainButtonStyle())
                .sheet(isPresented: $showRegisterView) {
                    RegisterView(registerSuccessful: $registerSuccessful)
                }
                Spacer()
                    .frame(minHeight: 100)
            }
            .frame(width: UIScreen.self.main.bounds.width, height: UIScreen.self.main.bounds.height)
            .padding(EdgeInsets.init(top: 350, leading: 10, bottom: 0, trailing: 10))
            .background(Color("DarkWhite"))
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
            .onTapGesture {
                loginSuccessful = false
            }
            .onAppear {
                UINavigationBar.setAnimationsEnabled(false)
            }
            .onChange(of: registerSuccessful) { successful in
                if successful! {
                    UINavigationBar.setAnimationsEnabled(true)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        showLoginView = true
                    }
                }
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct WelcomePageView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomePageView()
    }
}
