//
//  ProfileTabView.swift
//  MyChat
//
//  Created by Emre Topçu on 12.01.2022.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var profileViewModel: ProfileViewModel
    
    @State var showImagePicker: Bool = false
    @State var image: Image? = nil
    @State private var textFieldName: String = ""
    @State private var textFieldEmail: String = ""
    @State private var showMobileAlert = false
    @State private var showLogoutConfirmation = false
    @State private var isLoggedOut: Bool?
    
    @FocusState private var isNameFocused: Bool
    @FocusState private var isEmailFocused: Bool
    
    var body: some View {
        
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
                    HStack {
                        Text("Mobile")
                            .font(.title3)
                            .padding(.leading)
                        Spacer()
                    }
                    Text(profileViewModel.mobile)
                        .padding(.leading)
                }
                .frame(maxWidth: UIScreen.main.bounds.width - 30)
                .padding(EdgeInsets.init(top: 10, leading: 0, bottom: 10, trailing: 0))
                .background(.white)
                .opacity(0.5)
                .cornerRadius(15)
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
            NavigationLink(destination: WelcomePageView(), tag: true, selection: $isLoggedOut) {
                Button {
                    UINavigationBar.setAnimationsEnabled(true)
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
                    }
                    Button("Cancel", role: .cancel) { }
                } message: {
                    Text("Are you sure you want to logout?")
                }
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
            profileViewModel.appeared()
            // TODO verileri burada depola (picture, name, email)
        }
        .onDisappear {
            profileViewModel.disappeared()
            // TODO appear'da depolanan veriler degistiyse model'e gönder ki degisiklikler database'e kaydedilsin.
        }
        .onTapGesture {
            isNameFocused = false
            isEmailFocused = false
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(sourceType: .photoLibrary) { pickedImage in
                image = Image(uiImage: pickedImage)
            }
        }
        .onReceive(profileViewModel.$dataReceived, perform: { dataReceived in
            if let received = dataReceived {
                if received {
//                    image = profileViewModel.image
                    textFieldName = profileViewModel.name
                    textFieldEmail = profileViewModel.email
                }
            }
        })
    }
}

struct ProfileTabView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            ProfileView()
        }
    }
}
