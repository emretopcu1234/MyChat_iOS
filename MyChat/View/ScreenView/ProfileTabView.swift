//
//  ProfileTabView.swift
//  MyChat
//
//  Created by Emre Topçu on 12.01.2022.
//

import SwiftUI

struct ProfileTabView: View {
    
    @State var showImagePicker: Bool = false
    @State var image: Image? = nil
    @State private var textFieldMobile: String = "905555555555"
    @State private var textFieldName: String = "Michael Clooney"
    @State private var textFieldEmail: String = "mclooney@mychat.com"
    @State private var showMobileAlert = false
    @State private var showLogoutConfirmation = false
    @State private var isLoggedOut: Bool?
    
    @FocusState private var isMobileFocused: Bool
    @FocusState private var isNameFocused: Bool
    @FocusState private var isEmailFocused: Bool
    
    var body: some View {
        NavigationLink(destination: WelcomePageView(), tag: true, selection: $isLoggedOut) {
            VStack(spacing: 10) {
                TopBarView(topBarType: TopBarType.Profile, friendsEditPressed: .constant(false),  chatsEditPressed: .constant(false), newChatSelected: .constant(false))
                    .frame(height: 60)
                ZStack {
                    Image(systemName: "person.circle")
                        .resizable()
                        .aspectRatio(1, contentMode: .fill)
                        .frame(width: UIScreen.self.main.bounds.height > 900 ? 200 : 150, height: UIScreen.self.main.bounds.height > 900 ? 200 : 150)
                        .foregroundColor(.gray)
                        .clipShape(Circle())
                    image?
                        .resizable()
                        .aspectRatio(1, contentMode: .fill)
                        .frame(width: UIScreen.self.main.bounds.height > 900 ? 200 : 150, height: UIScreen.self.main.bounds.height > 900 ? 200 : 150)
                        .clipShape(Circle())
                }
                Button {
                    isMobileFocused = false
                    isNameFocused = false
                    isEmailFocused = false
                    UINavigationBar.setAnimationsEnabled(true)
                    showImagePicker.toggle()
                } label: {
                    HStack {
                        Image(systemName: "camera.fill")
                            .scaleEffect(1.5)
                            .padding(.trailing, 5)
                            .foregroundColor(.blue)
                        Text(image == nil ? "Add Photo" : "Change Photo")
                            .font(.title3)
                            .foregroundColor(.blue)
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
                        TextField("", text: $textFieldMobile)
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
                        TextField("", text: $textFieldName)
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
                        TextField("", text: $textFieldEmail)
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
                        isLoggedOut = true
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
            .buttonStyle(PlainButtonStyle())
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
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(sourceType: .photoLibrary) { pickedImage in
                    image = Image(uiImage: pickedImage)
                }
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct ProfileTabView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            ProfileTabView()
        }
    }
}
