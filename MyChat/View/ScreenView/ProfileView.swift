//
//  ProfileView.swift
//  MyChat
//
//  Created by Emre Topçu on 12.01.2022.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var profileViewModel: ProfileViewModel
    
    @State var showImagePicker: Bool = false
    @State private var image = UIImage()
    @State private var imageUrl = URL(string: "")
    @State private var textFieldName: String = ""
    @State private var textFieldEmail: String = ""
    @State private var showAlert = false
    @State private var alertText: String = ""
    @State private var showLogoutConfirmation = false
    @State private var isLoggedOut: Bool?
    
    @FocusState private var isNameFocused: Bool
    @FocusState private var isEmailFocused: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            TopBarView(topBarType: TopBarType.profile, friendsEditPressed: .constant(false),  chatsEditPressed: .constant(false), newChatSelected: .constant(false), chatInfo: .constant(ChatType(id: "", mobile: "", name: "", email: "", pictureUrl: nil, lastSeen: 0, lastMessage: "", lastMessageTime: 0, unreadMessageNumber: 0, messages: [MessageType]())), friendCreationMobile: .constant(""), friendCreationResult: .constant(nil))
                .frame(height: 60)
            if imageUrl == URL(string: ""){
                Image(systemName: "person.circle")
                    .resizable()
                    .aspectRatio(1, contentMode: .fill)
                    .frame(width: UIScreen.self.main.bounds.height > 900 ? 200 : 150, height: UIScreen.self.main.bounds.height > 900 ? 200 : 150)
                    .foregroundColor(.gray)
            }
            else {
                AsyncImage(url: imageUrl) { image in
                    image
                        .resizable()
                        .aspectRatio(1, contentMode: .fill)
                        .frame(width: UIScreen.self.main.bounds.height > 900 ? 200 : 150, height: UIScreen.self.main.bounds.height > 900 ? 200 : 150)
                        .clipShape(Circle())
                } placeholder: {
                    Image(systemName: "person.circle")
                        .resizable()
                        .aspectRatio(1, contentMode: .fill)
                        .frame(width: UIScreen.self.main.bounds.height > 900 ? 200 : 150, height: UIScreen.self.main.bounds.height > 900 ? 200 : 150)
                        .foregroundColor(.gray)
                }
            }
            Spacer()
                .frame(height: 10)
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
                    Text(imageUrl == URL(string: "") ? "Add Photo" : "Change Photo")
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
                Spacer()
                    .frame(height: 10)
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
                Spacer()
                    .frame(height: 10)
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
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text(alertText), dismissButton: .default(Text("OK")))
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
                        profileViewModel.logout()
                        isLoggedOut = true
                    }
                    Button("Cancel", role: .cancel) { }
                } message: {
                    Text("Are you sure you want to logout?")
                }
            }
            Group {
                Spacer()
                    .frame(height: 10)
                Divider()
                    .padding(EdgeInsets.init(top: 0, leading: 10, bottom: 10, trailing: 10))
            }
            BottomBarView(bottomBarType: BottomBarType.profile, deleteFriendPressed: .constant(false), deleteChatPressed: .constant(false))
        }
        .background(Color("DarkWhite"))
        .padding(.top, CGFloat(UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0))
        .ignoresSafeArea(edges: .top)
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
        .onAppear {
            imageUrl = URL(string: profileViewModel.pictureUrl ?? "")
            textFieldName = profileViewModel.name
            textFieldEmail = profileViewModel.email
            
            UINavigationBar.setAnimationsEnabled(false)
            profileViewModel.getData()
        }
        .onDisappear {
            profileViewModel.disappeared()
            if imageUrl != URL(string: profileViewModel.pictureUrl ?? "") || textFieldName != profileViewModel.name || textFieldEmail != profileViewModel.email {
                if let url = imageUrl {
                    let user = UserType(mobile: profileViewModel.mobile, password: "", name: textFieldName, email: textFieldEmail, pictureUrl: url.absoluteString)
                    profileViewModel.updateData(user: user)
                }
                else {
                    let user = UserType(mobile: profileViewModel.mobile, password: "", name: textFieldName, email: textFieldEmail, pictureUrl: nil)
                    profileViewModel.updateData(user: user)
                }
            }
        }
        .onTapGesture {
            isNameFocused = false
            isEmailFocused = false
        }
        .onChange(of: isNameFocused, perform: { focused in
            if !focused && textFieldName == "" {
                alertText = "Please indicate your name."
                showAlert = true
                isNameFocused = true
            }
        })
        .onChange(of: isEmailFocused, perform: { focused in
            if !focused && textFieldEmail == "" {
                alertText = "Please indicate your e-mail."
                showAlert = true
                isEmailFocused = true
            }
        })
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(selectedImage: $image, imageUrl: $imageUrl)
        }
        .onReceive(profileViewModel.$dataReceived, perform: { dataReceived in
            if let received = dataReceived {
                if received {
                    imageUrl = URL(string: profileViewModel.pictureUrl ?? "")
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
