//
//  KeyboardAction.swift
//  MyChat
//
//  Created by Emre Topçu on 17.01.2022.
//

import SwiftUI
import Foundation
import Combine

// in order for views to stay their own position instead of moving up when keyboard becomes active - START
struct AdaptsToKeyboard: ViewModifier {
    
    @State var currentHeight: CGFloat = 0
    
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            content
                .padding(.bottom, self.currentHeight)
                .onAppear(perform: {
                    NotificationCenter.Publisher(center: NotificationCenter.default, name: UIResponder.keyboardWillShowNotification)
                        .merge(with: NotificationCenter.Publisher(center: NotificationCenter.default, name: UIResponder.keyboardWillChangeFrameNotification))
                        .compactMap { notification in
                            withAnimation(.easeOut(duration: 0.16)) {
                                notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
                            }
                    }
                    .map { rect in
                        rect.height - geometry.safeAreaInsets.bottom
                    }
                    .subscribe(Subscribers.Assign(object: self, keyPath: \.currentHeight))
                    
                    NotificationCenter.Publisher(center: NotificationCenter.default, name: UIResponder.keyboardWillHideNotification)
                        .compactMap { notification in
                            CGFloat.zero
                    }
                    .subscribe(Subscribers.Assign(object: self, keyPath: \.currentHeight))
                })
        }
    }
}

extension View {
    func adaptsToKeyboard() -> some View {
        return modifier(AdaptsToKeyboard())
    }
}
// in order for views to stay their own position instead of moving up when keyboard becomes active - END


// in order to get keyboard height - START
class KeyboardHeightHelper: ObservableObject {
    
    @Published var keyboardHeight: CGFloat = 0
    
    init() {
        self.listenForKeyboardNotifications()
    }
    
    private func listenForKeyboardNotifications() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidShowNotification,
                                               object: nil,
                                               queue: .main) { (notification) in
            guard let userInfo = notification.userInfo,
                  let keyboardRect = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
            
            withAnimation(.easeIn) {
                self.keyboardHeight = keyboardRect.height
                if UserDefaults.standard.object(forKey: "KeyboardHeight") == nil {
                    UserDefaults.standard.set(self.keyboardHeight, forKey: "KeyboardHeight")
                }
            }
            
        }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidHideNotification,
                                               object: nil,
                                               queue: .main) { (notification) in
            withAnimation(.easeIn) {
                self.keyboardHeight = 0
            }
        }
    }
}
// in order to get keyboard height - END
