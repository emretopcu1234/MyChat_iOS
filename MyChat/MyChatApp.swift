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

// UNUTMA: viewmodel'lerin statelerini nil'e (ya da defaultu neyse ona) cekme isini onAppear yerine onDisappear'da yap. cunku onAppear'dan once bazen onReceive, onChange vb handle edilme riski var.

// TODO LIST:

// toplu friend silme işlemini hallet (bi tek model kısmı kaldı)
// default olarak loggedin sekilde uygulama baslayınca olusan sorunu coz (welcomepageview'da guncelleme gerekebilir, workaround tarzı)

// specific bir chat'e girildiginde en alta scroll edilecek. ama eger okunmamıs bir mesaj varsa, örneğin okunmamış 20 mesaj var, bu durumda okunmamış mesaj yazan yere (yani size - 20 gibi bir şey) scroll edilmesi lazım. o durumda da direkt olarak size - 20 degil de size - 17, size - 18 (tabi en az 2-3 mesaj varsa, yoksa out of bound exception olur) gibi bir şey yapılmalı ki, okunmamış mesaj yazısı en altta değil, ekranın biraz üstüne doğru kaysın, altında da okunmamış mesajların 2-3 tanesi görünsün, devamı aşağı kaydırılırsa gelir zaten.

// edit kısımlarından sonra bottombar'daki delete butonunun enable / disable olma durumunu hallet. (aciliyeti yok, yardımcı class'lar olusturulacak, ona gore bir tasarım dusun)

// friendstabview onappear metodunda animation false yapılıyor, ancak eger welcomepage'den gelindiyse animation true olmalı, daha sonrasında tablar arası gecislerde false olmalı. bunun icin friendstabview'a bir tane degisken tanımlanıp onappear'da o degiskene gore anımation true ya da false'a cekilebilir.

// ContentView'da simdilik direkt friendstab aciliyor. ileride kullanıcı en son hangi tabdan cikis yaptiysa o tabdan devam edecek sekilde guncelle.

// uygulamaya girilince timestamp = 2147483647 yap. (online oldugunun anlasilması icin)

// uygulamadan cikilinca once timestamp degerini guncelle, sonra da signout yap (keeploggedin secili olsa bile, cunku uygulamaya her girildiginde manuel ya da otomatik signin yapiliyor)
