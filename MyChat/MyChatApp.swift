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

// textfield'lara focus yapabilmek için illa textfield'a basılmasın. parent'ına (beyaz background olan kısım) basılması da yeterli olsun.

// ekrandaki herhangi bir yere basılınca textfield'ların focus'u kaybolsun. (textfield'ı olan view'lar için)

// friend ekleme kısmında kayıtlı olmayan bir numara girilirse alerview çıkar.

// ProfileTabView'da yer alan @StateObject var keyboardHeightHelper = KeyboardHeightHelper() ifadesi o view'dan silinip uygulamanın ilk açılacak ekranına eklenecek. uygulama ilk açıldığında login/enrollment page geleceği için orada mutlaka keyboard kullanılmak zorunda. daha sonra kişi login olup uygulamayı kapatıp yeniden açtığında login page gelmeyecek ama zaten keyboardheight ilk girişte userdefault dosyasına eklenmiş olduğu için sıkıntı olmayacak.

// ContentView'da simdilik direkt friendstab'ı aciliyor. ileride kullanıcı en son hangi tabdan cikis yaptiysa o tabdan devam edecek sekilde guncelle.
