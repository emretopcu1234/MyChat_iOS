//
//  GeneralView.swift
//  MyChat
//
//  Created by Emre Topçu on 12.01.2022.
//

import SwiftUI

struct GeneralView: View {
    
    init(){
        UITabBar.appearance().backgroundColor = UIColor(named: "DarkWhite")
        UINavigationBar.setAnimationsEnabled(false)
    }
    
    var body: some View {
//        NavigationView {
//            FriendsTabView()
//        }
        FriendsTabView()
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
    }
}

struct GeneralView_Previews: PreviewProvider {
    static var previews: some View {
        GeneralView()
    }
}
