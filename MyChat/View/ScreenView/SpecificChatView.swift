//
//  SpecificChatView.swift
//  MyChat
//
//  Created by Emre Topçu on 12.01.2022.
//

import SwiftUI

struct SpecificChatView: View {
    
    var keyboardHeight: CGFloat = UserDefaults.standard.object(forKey: "KeyboardHeight") as? CGFloat ?? 340

    @State var keyboardActive = false
    @State var textFieldMessage: String = ""

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
                            
                        }
                    }
                    .padding(.top, 25)
                    .padding(.bottom, 15)
                    .frame(height: UIScreen.self.main.bounds.height - 155)
                    .offset(y: keyboardActive ? -keyboardHeight + 70 : -10)
                }
                .onTapGesture {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    withAnimation {
                        keyboardActive = false
                    }
                }
                VStack {
                    TopBarView(topBarType: TopBarType.SpecificChat)
                        .frame(height: 60)
                    Spacer()
                    VStack {
                        HStack {
                            TextField("Message", text: $textFieldMessage)
                                .frame(height:30)
                                .frame(maxWidth: .infinity)
                                .padding(.leading)
                                .padding(.trailing)
                                .background(.white)
                                .cornerRadius(15)
                                .offset(y: -15)
                                .onTapGesture {
                                    withAnimation {
                                        keyboardActive = true
                                    }
                                }
                            Spacer()
                            Button {
                                // TODO
                            } label: {
                                Image(systemName: "arrow.up.circle.fill")
                                    .foregroundColor(.blue)
                                    .scaleEffect(2)
                                    .padding()
                                    .offset(y: -15)
                            }
                        }
                        .padding()
                        .padding(.bottom, 20)
                        .background(Color("DarkWhite"))
                        .frame(height: 20)
                        .offset(y: keyboardActive ? -keyboardHeight + 120 : -10)
                    }
                }
            }
        }
        .padding(.top, CGFloat(UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0))
        .padding(.bottom, 10)
        .ignoresSafeArea(edges: .all)
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
        .adaptsToKeyboard()
        .onAppear {
            UINavigationBar.setAnimationsEnabled(true)
        }
    }
}

struct SpecificChatView_Previews: PreviewProvider {
    static var previews: some View {
        SpecificChatView()
    }
}
