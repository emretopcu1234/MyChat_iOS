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
            ContentView()
        }
    }
}

// TODO LIST:

// login ve register view'lara devam et.

// edit kısımlarından sonra bottombar'daki delete butonunun enable / disable olma durumunu hallet. (aciliyeti yok, yardımcı class'lar olusturulacak, ona gore bir tasarım dusun)

// add photo'ya basınca galeri acılacak.

// friendstabview onappear metodunda animation false yapılıyor, ancak eger welcomepage'den gelindiyse animation true olmalı, daha sonrasında tablar arası gecislerde false olmalı. bunun icin de contentview'da bir state tanımlanabilir direkt olarak friendstabview'a mı giriyor, yoksa welcomepage'den mi geliyor anlasılması icin (cunku eger daha onceden girip oturumu da acık tuttuysa direkt friendstabview (ya da chats ya da profile) acılacak)

// ProfileTabView'da yer alan @StateObject var keyboardHeightHelper = KeyboardHeightHelper() ifadesi o view'dan silinip uygulamanın ilk açılacak ekranına eklenecek. uygulama ilk açıldığında login/enrollment page geleceği için orada mutlaka keyboard kullanılmak zorunda. daha sonra kişi login olup uygulamayı kapatıp yeniden açtığında login page gelmeyecek ama zaten keyboardheight ilk girişte userdefault dosyasına eklenmiş olduğu için sıkıntı olmayacak.

// ContentView'da simdilik direkt friendstab'ı aciliyor. ileride kullanıcı en son hangi tabdan cikis yaptiysa o tabdan devam edecek sekilde guncelle.
