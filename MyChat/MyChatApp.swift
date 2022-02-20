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
// UNUTMA: onchangeof: kendi class'ında gecen bir state ya da binding, onreceive baska bir observable class'ta gecen published variable icin kullanılır.

// TODO LIST:

// specific chat'ten chat'e geri donunce unreadmessagenumber kısmı guncellenmiyor. (ama en son mesaj kısmı guncelleniyor.)

// specific chat view'a girince ilgili chat'in lastseen'ini timestamp max yap, cikinca yeniden cikilan anın timestamp'ine esitle. boylece eger ilgili chat'teyken o chat'e bir mesaj gelirse unreadmessages gorunmemis olur.

// friendstabview onappear metodunda animation false yapılıyor, ancak eger welcomepage'den gelindiyse animation true olmalı, daha sonrasında tablar arası gecislerde false olmalı. bunun icin friendstabview'a bir tane degisken tanımlanıp onappear'da o degiskene gore anımation true ya da false'a cekilebilir.

// uygulamaya girilince timestamp = 2147483647 yap. (online oldugunun anlasilması icin)

// uygulamadan cikilinca once timestamp degerini guncelle, sonra da signout yap (keeploggedin secili olsa bile, cunku uygulamaya her girildiginde manuel ya da otomatik signin yapiliyor)
