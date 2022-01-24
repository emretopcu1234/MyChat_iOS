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

// login ve register view'larda login/register butonuna basıldıktan sonra hata olustugu durumda cikacak alert'ları hallet.

// edit kısımlarından sonra bottombar'daki delete butonunun enable / disable olma durumunu hallet. (aciliyeti yok, yardımcı class'lar olusturulacak, ona gore bir tasarım dusun)

// friendstabview onappear metodunda animation false yapılıyor, ancak eger welcomepage'den gelindiyse animation true olmalı, daha sonrasında tablar arası gecislerde false olmalı. bunun icin friendstabview'a bir tane degisken tanımlanıp onappear'da o degiskene gore anımation true ya da false'a cekilebilir.

// ProfileTabView'da yer alan @StateObject var keyboardHeightHelper = KeyboardHeightHelper() ifadesi o view'dan silinip uygulamanın ilk açılacak ekranına eklenecek. uygulama ilk açıldığında login/enrollment page geleceği için orada mutlaka keyboard kullanılmak zorunda. daha sonra kişi login olup uygulamayı kapatıp yeniden açtığında login page gelmeyecek ama zaten keyboardheight ilk girişte userdefault dosyasına eklenmiş olduğu için sıkıntı olmayacak.

// ContentView'da simdilik direkt friendstab'ı aciliyor. ileride kullanıcı en son hangi tabdan cikis yaptiysa o tabdan devam edecek sekilde guncelle.
