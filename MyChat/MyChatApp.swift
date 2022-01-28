//
//  MyChatApp.swift
//  MyChat
//
//  Created by Emre Topçu on 12.01.2022.
//

import SwiftUI
import Firebase

@main
struct MyChatApp: App {
    
    let contentViewModel = ContentViewModel()
    
    init(){
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView(contentViewModel: contentViewModel)
        }
    }
}

// TODO LIST:

// logout olunca userdefaulttaki keeploggedin kısmı false yapılacak.

// specific bir chat'e girildiginde en alta scroll edilecek. ama eger okunmamıs bir mesaj varsa, örneğin okunmamış 20 mesaj var, bu durumda okunmamış mesaj yazan yere (yani size - 20 gibi bir şey) scroll edilmesi lazım. o durumda da direkt olarak size - 20 degil de size - 17, size - 18 (tabi en az 2-3 mesaj varsa, yoksa out of bound exception olur) gibi bir şey yapılmalı ki, okunmamış mesaj yazısı en altta değil, ekranın biraz üstüne doğru kaysın, altında da okunmamış mesajların 2-3 tanesi görünsün, devamı aşağı kaydırılırsa gelir zaten.

// edit kısımlarından sonra bottombar'daki delete butonunun enable / disable olma durumunu hallet. (aciliyeti yok, yardımcı class'lar olusturulacak, ona gore bir tasarım dusun)

// friendstabview onappear metodunda animation false yapılıyor, ancak eger welcomepage'den gelindiyse animation true olmalı, daha sonrasında tablar arası gecislerde false olmalı. bunun icin friendstabview'a bir tane degisken tanımlanıp onappear'da o degiskene gore anımation true ya da false'a cekilebilir.

// ContentView'da simdilik direkt friendstab aciliyor. ileride kullanıcı en son hangi tabdan cikis yaptiysa o tabdan devam edecek sekilde guncelle.

// uygulamadan cikilinca signout yap (keeploggedin secili olsa bile, cunku uygulamaya her girildiginde manuel ya da otomatik signin yapiliyor)
