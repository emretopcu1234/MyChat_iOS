//
//  FriendProfileView.swift
//  MyChat
//
//  Created by Emre Topçu on 20.01.2022.
//

import SwiftUI

struct FriendProfileView: View {
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "person.circle")
                .resizable()
                .aspectRatio(1, contentMode: .fill)
                .frame(width: 200, height: 200)
                .foregroundColor(.gray)
            Spacer()
                .frame(height: 30)
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text("Name")
                        .font(.title3)
                        .padding(.leading)
                    Spacer()
                }
                Text("Michael Clooney")
                    .padding(.leading)
            }
            .frame(maxWidth: UIScreen.main.bounds.width - 50)
            .padding(.top, 10)
            .padding(.bottom, 10)
            .background(.white)
            .cornerRadius(15)
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text("Mobile")
                        .font(.title3)
                        .padding(.leading)
                    Spacer()
                }
                Text("905555555555")
                    .padding(.leading)
                    .keyboardType(.numberPad)
            }
            .frame(maxWidth: UIScreen.main.bounds.width - 50)
            .padding(.top, 10)
            .padding(.bottom, 10)
            .background(.white)
            .cornerRadius(15)
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text("E-mail")
                        .font(.title3)
                        .padding(.leading)
                    Spacer()
                }
                Text("mclooney@mychat.com")
                    .padding(.leading)
                
            }
            .frame(maxWidth: UIScreen.main.bounds.width - 50)
            .padding(.top, 10)
            .padding(.bottom, 10)
            .background(.white)
            .cornerRadius(15)
            Spacer()
        }
        .frame(width: UIScreen.self.main.bounds.width, height: UIScreen.self.main.bounds.height)
        .padding(.top, 200)
        .background(Color("DarkWhite"))
        .onAppear {
            UINavigationBar.setAnimationsEnabled(true)
        }
    }
}

struct FriendProfileView_Previews: PreviewProvider {
    static var previews: some View {
        FriendProfileView()
    }
}
