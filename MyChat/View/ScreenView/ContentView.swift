//
//  ContentView.swift
//  MyChat
//
//  Created by Emre Topçu on 13.01.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            WelcomePageView()
//            GeneralView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
