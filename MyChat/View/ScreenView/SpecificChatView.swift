//
//  SpecificChatView.swift
//  MyChat
//
//  Created by Emre Topçu on 12.01.2022.
//

import SwiftUI

struct SpecificChatView: View {
    
    @EnvironmentObject var specificChatViewModel: SpecificChatViewModel
    
    var keyboardHeight: CGFloat = UserDefaults.standard.object(forKey: "KeyboardHeight") as? CGFloat ?? 340
    var mobile: String
    
    @State var keyboardActive = false
    @State var textFieldMessage: String = ""
    
    @FocusState private var isMessageFocused: Bool

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                ZStack {
                    Image("ChatBackground")
                        .resizable()
                        .scaledToFill()
                        .frame(height: UIScreen.self.main.bounds.height - 185)
                        .opacity(0.8)
                        .offset(y: keyboardActive ? -keyboardHeight + 70 : -10)
                    ScrollView {
                        ForEach(0 ..< 15) { item in
                            SpecificChatRowView(specificChatRowType: SpecificChatRowType.NewDate)
                            SpecificChatRowView(specificChatRowType: SpecificChatRowType.UnreadMessages)
                            SpecificChatRowView(specificChatRowType: SpecificChatRowType.Sender)
                            SpecificChatRowView(specificChatRowType: SpecificChatRowType.Receiver)
                            SpecificChatRowView(specificChatRowType: SpecificChatRowType.UnknownPerson)
                        }
                    }
                    .padding(EdgeInsets.init(top: 25, leading: 0, bottom: 15, trailing: 0))
                    .frame(height: UIScreen.self.main.bounds.height - 155)
                    .offset(y: keyboardActive ? -keyboardHeight + 70 : -10)
                }
                .onTapGesture {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    withAnimation {
                        keyboardActive = false
                        isMessageFocused = false
                    }
                }
                VStack {
                    TopBarView(topBarType: TopBarType.SpecificChat, friendsEditPressed: .constant(false), chatsEditPressed: .constant(false), newChatSelected: .constant(false), friendCreationMobile: .constant(""), friendCreationResult: .constant(nil))
                        .frame(height: 60)
                    Spacer()
                    VStack {
                        HStack {
                            TextField("Message", text: $textFieldMessage)
                                .frame(height:30)
                                .frame(maxWidth: .infinity)
                                .padding(EdgeInsets.init(top: 0, leading: 10, bottom: 0, trailing: 10))
                                .background(.white)
                                .cornerRadius(15)
                                .offset(y: -15)
                                .focused($isMessageFocused)
                                .onTapGesture {
                                    withAnimation {
                                        keyboardActive = true
                                        isMessageFocused = true
                                    }
                                }
                            Spacer()
                            Button {
                                isMessageFocused = true
                            } label: {
                                Image(systemName: "arrow.up.circle.fill")
                                    .scaleEffect(2)
                                    .padding()
                                    .offset(y: -15)
                            }
                        }
                        .padding(EdgeInsets.init(top: 13, leading: 10, bottom: 37, trailing: 10))
                        .background(Color("DarkWhite"))
                        .frame(height: 20)
                        .offset(y: keyboardActive ? -keyboardHeight + 120 : -10)
                    }
                    .disabled(true)
                }
            }
        }
        .padding(EdgeInsets.init(top: CGFloat(UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0), leading: 0, bottom: 10, trailing: 0))
        .ignoresSafeArea(edges: .all)
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
        .adaptsToKeyboard()
        .onAppear {
            UINavigationBar.setAnimationsEnabled(true)
            specificChatViewModel.getData(mobile: mobile)
        }
    }
}

struct SpecificChatView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            SpecificChatView(mobile: "")
        }
    }
}
