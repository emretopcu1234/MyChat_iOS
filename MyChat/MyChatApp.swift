//
//  MyChatApp.swift
//  MyChat
//
//  Created by Emre Topçu on 12.01.2022.
//

import SwiftUI

@main
struct MyChatApp: App {
    
    var body: some Scene {
        WindowGroup {
            GeneralView()
        }
    }
}

// TODO LIST:
// ProfileTabView'da yer alan @ObservedObject var keyboardHeightHelper = KeyboardHeightHelper() ifadesi o view'dan silinip uygulamanın ilk açılacak ekranına eklenecek. uygulama ilk açıldığında login/enrollment page geleceği için orada mutlaka keyboard kullanılmak zorunda. daha sonra kişi login olup uygulamayı kapatıp yeniden açtığında login page gelmeyecek ama zaten keyboardheight ilk girişte userdefault dosyasına eklenmiş olduğu için sıkıntı olmayacak.
// ChatsTabView'daki TopBar SpecificChatView'a girilip geri dönüş yapılmadan çalışmıyor. (ne butonlar, ne ontapgesture'lar, ne de başka bir şey)
// navigationlink vb ile alakalı olabilir.
