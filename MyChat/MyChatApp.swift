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

// bottombarview'daki tab simgeleri butona çevrilecek. eğer aynı tabdaysak butona basma engellenecek.

// friendsrowview ve chatsrowview butona çevrilecek. (böylece tıklandığında yanıp sönme efekti gelmiş olacak.)


// ProfileTabView'da yer alan @StateObject var keyboardHeightHelper = KeyboardHeightHelper() ifadesi o view'dan silinip uygulamanın ilk açılacak ekranına eklenecek. uygulama ilk açıldığında login/enrollment page geleceği için orada mutlaka keyboard kullanılmak zorunda. daha sonra kişi login olup uygulamayı kapatıp yeniden açtığında login page gelmeyecek ama zaten keyboardheight ilk girişte userdefault dosyasına eklenmiş olduğu için sıkıntı olmayacak.

// ContentView'da simdilik direkt friendstab'ı aciliyor. ileride kullanıcı en son hangi tabdan cikis yaptiysa o tabdan devam edecek sekilde guncelle.
