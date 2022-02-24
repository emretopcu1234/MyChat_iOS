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
    let contentViewModel: ContentViewModel
    @UIApplicationDelegateAdaptor(AppDelegate.self) fileprivate var appDelegate
    
    init(){
        FirebaseApp.configure()
        contentViewModel = ContentViewModel()
    }

    var body: some Scene {
        WindowGroup {
            ContentView(contentViewModel: contentViewModel)
        }
    }
}

fileprivate class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let sceneConfig = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        sceneConfig.delegateClass = SceneDelegate.self
        return sceneConfig
    }
}


fileprivate class SceneDelegate: NSObject, UIWindowSceneDelegate {
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        ContentModel.shared.enterApp()
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        ContentModel.shared.exitApp()
    }
}


// herhangi bir mesaj geldiginde eger karsidaki kisinin numberofunreadmessages'ı 0'dan büyük ise, her gelen mesajda degeri 1 artır, 0 ise 0'da sabit tut.
