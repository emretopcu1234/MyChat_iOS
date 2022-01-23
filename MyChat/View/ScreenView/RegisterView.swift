//
//  RegisterView.swift
//  MyChat
//
//  Created by Emre Topçu on 24.01.2022.
//

import SwiftUI

struct RegisterView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var alert = false
    
    @Binding var registerSuccessful: Bool?
    
    var body: some View {
        
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//            .alert(isPresented: $alert) {
//                Alert(title: Text("Error"), message: Text("There is an existing user with this mobile:"), dismissButton: .default(Text("OK")))
//            }
            .onTapGesture {
//                alert = true
                presentationMode.wrappedValue.dismiss()
                registerSuccessful = true
            }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(registerSuccessful: .constant(false))
    }
}
