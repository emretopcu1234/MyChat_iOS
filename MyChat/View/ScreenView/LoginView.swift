//
//  LoginView.swift
//  MyChat
//
//  Created by Emre Topçu on 24.01.2022.
//

import SwiftUI

struct LoginView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var alert = false
    
    @Binding var loginSuccessful: Bool?
    
    var body: some View {
        
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//            .alert(isPresented: $alert) {
//                Alert(title: Text("Error"), message: Text("There is an existing user with this mobile:"), dismissButton: .default(Text("OK")))
//            }
            .onTapGesture {
//                alert = true
                presentationMode.wrappedValue.dismiss()
                loginSuccessful = true
            }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(loginSuccessful: .constant(false))
    }
}
