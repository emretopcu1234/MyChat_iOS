//
//  ProfileTabView.swift
//  MyChat
//
//  Created by Emre Topçu on 12.01.2022.
//

import SwiftUI

struct ProfileTabView: View {
    
    @StateObject var keyboardHeightHelper = KeyboardHeightHelper() // delete this line, and add it to the first view (related to the login or enrollment process) that includes textfield (in order to get the height of keyboard)
    
    @State private var textFieldMobile: String = ""
    @State private var textFieldName: String = ""
    @State private var textFieldEmail: String = ""
    @State private var showMobileAlert = false
    @State private var showLogoutConfirmation = false
    
    @FocusState private var isMobileFocused: Bool
    @FocusState private var isNameFocused: Bool
    @FocusState private var isEmailFocused: Bool
    
    var body: some View {
        VStack(spacing: 10) {
            TopBarView(topBarType: TopBarType.Profile, friendsEditPressed: .constant(false),  chatsEditPressed: .constant(false), newChatSelected: .constant(false))
                .frame(height: 60)
            Image(systemName: "person.circle")
                .resizable()
                .aspectRatio(1, contentMode: .fill)
                .frame(width: UIScreen.self.main.bounds.height > 900 ? 200 : 150, height: UIScreen.self.main.bounds.height > 900 ? 200 : 150)
                .foregroundColor(.gray)
                // TODO dışarıdan bir resim eklenince clipShape(Circle()) yapılacak.
            Button {
                isMobileFocused = false
                isNameFocused = false
                isEmailFocused = false
            } label: {
                HStack {
                    Image(systemName: "camera.fill")
                        .scaleEffect(1.5)
                        .padding(.trailing, 5)
                    Text("Add Photo")
                        .font(.title3)
                }
                .frame(maxWidth: UIScreen.main.bounds.width - 30)
                .padding(EdgeInsets.init(top: 10, leading: 0, bottom: 10, trailing: 0))
                .background(.white)
                .cornerRadius(15)
            }
            Spacer()
            Group {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Mobile")
                        .font(.title3)
                        .padding(.leading)
                    TextField("905555555555", text: $textFieldMobile)
                        .padding(.leading)
                        .keyboardType(.numberPad)
                        .focused($isMobileFocused)
                        .alert(isPresented: $showMobileAlert) {
                            Alert(title: Text("Error"), message: Text("There is an existing user with this mobile: \(textFieldMobile)"), dismissButton: .default(Text("OK")))
                        }
                }
                .frame(maxWidth: UIScreen.main.bounds.width - 30)
                .padding(EdgeInsets.init(top: 10, leading: 0, bottom: 10, trailing: 0))
                .background(.white)
                .cornerRadius(15)
                .onTapGesture {
                    isMobileFocused = true
                }
                VStack(alignment: .leading, spacing: 0) {
                    Text("Name")
                        .font(.title3)
                        .padding(.leading)
                    TextField("Michael Clooney", text: $textFieldName)
                        .padding(.leading)
                        .focused($isNameFocused)
                }
                .frame(maxWidth: UIScreen.main.bounds.width - 30)
                .padding(EdgeInsets.init(top: 10, leading: 0, bottom: 10, trailing: 0))
                .background(.white)
                .cornerRadius(15)
                .onTapGesture {
                    isNameFocused = true
                }
                VStack(alignment: .leading, spacing: 0) {
                    Text("E-mail")
                        .font(.title3)
                        .padding(.leading)
                    TextField("mclooney@mychat.com", text: $textFieldEmail)
                        .padding(.leading)
                        .focused($isEmailFocused)
                    
                }
                .frame(maxWidth: UIScreen.main.bounds.width - 30)
                .padding(EdgeInsets.init(top: 10, leading: 0, bottom: 10, trailing: 0))
                .background(.white)
                .cornerRadius(15)
                .onTapGesture {
                    isEmailFocused = true
                }
            }
            Spacer()
            Button {
                UINavigationBar.setAnimationsEnabled(true)
                isMobileFocused = false
                isNameFocused = false
                isEmailFocused = false
                showLogoutConfirmation = true
            } label: {
                Text("Logout")
                    .font(.title3)
                    .frame(maxWidth: UIScreen.main.bounds.width - 30)
                    .padding(EdgeInsets.init(top: 10, leading: 0, bottom: 10, trailing: 0))
                    .foregroundColor(.red)
                    .background(.white)
                    .cornerRadius(15)
            }
            .confirmationDialog("", isPresented: $showLogoutConfirmation) {
                Button("Logout", role: .destructive) {
                    // TODO struct'ın içinde bir state tanımlanacak. o state'in değeri burada true'ya çekilecek, böylece logout yapılmış olacak ve login ekranına geçiş yapılacak.
                }
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("Are you sure you want to logout?")
            }
            Divider()
                .padding(EdgeInsets.init(top: 0, leading: 10, bottom: 10, trailing: 10))
            BottomBarView(bottomBarType: BottomBarType.Profile)
        }
        .background(Color("DarkWhite"))
        .padding(.top, CGFloat(UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0))
        .ignoresSafeArea(edges: .top)
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
        .onAppear {
            UINavigationBar.setAnimationsEnabled(false)
        }
        .onTapGesture {
            isMobileFocused = false
            isNameFocused = false
            isEmailFocused = false
        }
        .onChange(of: isMobileFocused) { focused in
            if !focused {
                // tabii ki boyle olmayacak. buradan database'e request yapılacak, eger duplicate mobile durumu varsa database'den ona gore cevap donecek, viewmodel'daki ilgili state degisecek, boylece buradaki view'da alert cikacak. deneme amacli boyle su anda.
                UINavigationBar.setAnimationsEnabled(true)
                showMobileAlert = true
                isMobileFocused = true
                isNameFocused = false
                isEmailFocused = false
            }
        }
        .onChange(of: isNameFocused) { focused in
            if !focused {
                // TODO database'e kaydet.
            }
        }
        .onChange(of: isEmailFocused) { focused in
            if !focused {
                // TODO database'e kaydet.
            }
        }
    }
}

struct ProfileTabView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            ProfileTabView()
        }
    }
}
