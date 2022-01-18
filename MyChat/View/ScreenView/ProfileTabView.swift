//
//  ProfileTabView.swift
//  MyChat
//
//  Created by Emre Topçu on 12.01.2022.
//

import SwiftUI

struct ProfileTabView: View {
    
    @StateObject var keyboardHeightHelper = KeyboardHeightHelper() // delete this line, and add it to the first view (related to the login or enrollment process) that includes textfield (in order to get the height of keyboard)
    
    @State var textFieldName: String = ""
    @State var textFieldMobile: String = ""
    @State var textFieldEmail: String = ""
    
    var body: some View {
        VStack(spacing: 10) {
            TopBarView(topBarType: TopBarType.Profile)
                .frame(height: 60)
            
            Image(systemName: "person.circle")
                .resizable()
                .aspectRatio(1, contentMode: .fill)
                .frame(width: 150, height: 150)
                .foregroundColor(.gray)
                // TODO dışarıdan bir resim eklenince clipShape(Circle()) yapılacak.
            Button {
                // TODO
            } label: {
                HStack {
                    Image(systemName: "camera.fill")
                        .scaleEffect(1.5)
                        .padding(.trailing, 5)
                    Text("Add Photo")
                        .font(.title3)
                }
                .frame(maxWidth: UIScreen.main.bounds.width - 30)
                .padding(.top, 10)
                .padding(.bottom, 10)
                .foregroundColor(.blue)
                .background(.white)
                .cornerRadius(15)
            }

            Spacer()
                .padding(.bottom, 30)
            Group {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Name")
                        .font(.title3)
                        .padding(.leading)
                    TextField("Michael Clooney", text: $textFieldName)
                        .padding(.leading)
                }
                .frame(maxWidth: UIScreen.main.bounds.width - 30)
                .padding(.top, 10)
                .padding(.bottom, 10)
                .background(.white)
                .cornerRadius(15)
                .onTapGesture {
                    // TODO
                }
                VStack(alignment: .leading, spacing: 0) {
                    Text("Mobile")
                        .font(.title3)
                        .padding(.leading)
                    TextField("905555555555", text: $textFieldMobile)
                        .padding(.leading)
                        .keyboardType(.numberPad)
                }
                .frame(maxWidth: UIScreen.main.bounds.width - 30)
                .padding(.top, 10)
                .padding(.bottom, 10)
                .background(.white)
                .cornerRadius(15)
                .onTapGesture {
                    // TODO
                }
                VStack(alignment: .leading, spacing: 0) {
                    Text("E-mail")
                        .font(.title3)
                        .padding(.leading)
                    TextField("mclooney@mychat.com", text: $textFieldEmail)
                        .padding(.leading)
                    
                }
                .frame(maxWidth: UIScreen.main.bounds.width - 30)
                .padding(.top, 10)
                .padding(.bottom, 10)
                .background(.white)
                .cornerRadius(15)
                .onTapGesture {
                    // TODO
                }
            }
            
            Spacer()
                .padding(.bottom, 100)
            Button {
                // TODO
            } label: {
                Text("Logout")
                    .font(.title3)
                    .frame(maxWidth: UIScreen.main.bounds.width - 30)
                    .padding(.top, 10)
                    .padding(.bottom, 10)
                    .foregroundColor(.red)
                    .background(.white)
                    .cornerRadius(15)
            }
            
            Divider()
                .padding(.leading)
                .padding(.trailing)
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
    }
}

struct ProfileTabView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileTabView()
    }
}
