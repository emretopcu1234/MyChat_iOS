//
//  FriendProfileView.swift
//  MyChat
//
//  Created by Emre Topçu on 20.01.2022.
//

import SwiftUI

struct FriendProfileView: View {
    
    var friend: FriendType
    
    @State private var image = UIImage()
    @State private var imageUrl = URL(string: "")
    
    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                Image(systemName: "person.circle")
                    .resizable()
                    .aspectRatio(1, contentMode: .fill)
                    .frame(width: 200, height: 200)
                    .foregroundColor(.gray)
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(1, contentMode: .fill)
                    .frame(width: 200, height: 200)
                    .foregroundColor(.gray)
                    .clipShape(Circle())
            }
            Spacer()
                .frame(height: 30)
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text("Mobile")
                        .font(.title3)
                        .padding(.leading)
                    Spacer()
                }
                Text(friend.mobile)
                    .foregroundColor(Color("Gray"))
                    .padding(.leading)
            }
            .frame(maxWidth: UIScreen.main.bounds.width - 50)
            .padding(EdgeInsets.init(top: 10, leading: 0, bottom: 10, trailing: 0))
            .background(.white)
            .cornerRadius(15)
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text("Name")
                        .font(.title3)
                        .padding(.leading)
                    Spacer()
                }
                Text(friend.name)
                    .foregroundColor(Color("Gray"))
                    .padding(.leading)
            }
            .frame(maxWidth: UIScreen.main.bounds.width - 50)
            .padding(EdgeInsets.init(top: 10, leading: 0, bottom: 10, trailing: 0))
            .background(.white)
            .cornerRadius(15)
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text("E-mail")
                        .font(.title3)
                        .padding(.leading)
                    Spacer()
                }
                Text(friend.email)
                    .foregroundColor(Color("Gray"))
                    .padding(.leading)
                
            }
            .frame(maxWidth: UIScreen.main.bounds.width - 50)
            .padding(EdgeInsets.init(top: 10, leading: 0, bottom: 10, trailing: 0))
            .background(.white)
            .cornerRadius(15)
            Spacer()
        }
        .frame(width: UIScreen.self.main.bounds.width, height: UIScreen.self.main.bounds.height)
        .padding(.top, 200)
        .background(Color("DarkWhite"))
        .onAppear(perform: {
            UINavigationBar.setAnimationsEnabled(true)
            imageUrl = URL(string: friend.pictureUrl ?? "")
            if imageUrl != URL(string: "") {
                let data = try? Data(contentsOf: imageUrl!)
                image = UIImage(data: data!)!
            }
        })
    }
}

struct FriendProfileView_Previews: PreviewProvider {
    static var previews: some View {
        FriendProfileView(friend: FriendType(mobile: "", name: "", email: "", lastSeen: "", pictureUrl: nil))
    }
}
