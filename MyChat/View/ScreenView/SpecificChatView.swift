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
    
    @State private var rows = [SpecificChatRowType]()
    @State private var keyboardActive = false
    @State private var textFieldMessage: String = ""
    @State private var sendDisabled = true
    @State private var writeDisabled = false
    @State private var scrollId: String = ""
    
    @FocusState private var isMessageFocused: Bool

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                VStack {
                    ZStack {
                        Image("ChatBackground")
                            .resizable()
                            .scaledToFill()
                            .frame(height: keyboardActive ? UIScreen.self.main.bounds.height - 185 - (keyboardHeight - 30) : UIScreen.self.main.bounds.height - 185)
                            .opacity(0.8)
                            .offset(y: keyboardActive ? 40 : -10)
                        ScrollViewReader { scrollIndex in
                            ScrollView {
                                ForEach($rows) { row in
                                    SpecificChatRowView(specificChatRowType: row)
                                        .id(row.id)
                                }
                            }
                            .padding(EdgeInsets.init(top: 25, leading: 0, bottom: 15, trailing: 0))
                            .frame(height: keyboardActive ? UIScreen.self.main.bounds.height - 155 - (keyboardHeight - 30) : UIScreen.self.main.bounds.height - 155)
                            .offset(y: keyboardActive ? 40 : -10)
                            .onChange(of: scrollId, perform: { id in
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                    withAnimation {
                                        if id == "unreadMessages" {
                                            scrollIndex.scrollTo(id as String?, anchor: .center)
                                        }
                                        else {
                                            scrollIndex.scrollTo(id as String?, anchor: .bottom)
                                        }
                                    }
                                }
                            })
                            .onChange(of: keyboardActive) { active in
                                if active {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                        withAnimation {
                                            if rows.count > 0 {
                                                scrollId = rows[rows.count - 1].id
                                            }
                                            else {
                                                scrollId = ""
                                            }
                                            scrollIndex.scrollTo(scrollId as String?, anchor: .bottom)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .onTapGesture {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        withAnimation {
                            keyboardActive = false
                            isMessageFocused = false
                        }
                    }
                    Spacer()
                        .frame(height: keyboardActive ? keyboardHeight - 30 : 0)
                }
                VStack {
                    TopBarView(topBarType: TopBarType.specificChat, friendsEditPressed: .constant(false), chatsEditPressed: .constant(false), newChatSelected: .constant(false), chatInfo: $specificChatViewModel.chat, friendCreationMobile: .constant(""), friendCreationResult: .constant(nil))
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
                                withAnimation {
                                    keyboardActive = true
                                    isMessageFocused = true
                                }
                                specificChatViewModel.sendMessage(message: textFieldMessage)
                                textFieldMessage = ""
                            } label: {
                                Image(systemName: "arrow.up.circle.fill")
                                    .scaleEffect(2)
                                    .padding()
                                    .offset(y: -15)
                            }
                            .disabled(sendDisabled)
                        }
                        .padding(EdgeInsets.init(top: 13, leading: 10, bottom: 37, trailing: 10))
                        .background(Color("DarkWhite"))
                        .frame(height: 20)
                        .offset(y: keyboardActive ? -keyboardHeight + 120 : -10)
                    }
                    .disabled(writeDisabled)
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
        .onDisappear(perform: {
            if rows.count > 0 {
                specificChatViewModel.disappear()
            }
        })
        .onChange(of: textFieldMessage, perform: { message in
            if message == "" {
                withAnimation(.easeIn(duration: 0.2)) {
                    sendDisabled = true
                }
            }
            else {
                withAnimation(.easeIn(duration: 0.2)) {
                    sendDisabled = false
                }
            }
        })
        .onReceive(specificChatViewModel.$chat) { chat in
            writeDisabled = false
            rows = [SpecificChatRowType]()
            if chat.messages.isEmpty {
                return
            }
            var sentMessageExist = chat.messages[0].sender != mobile
            var id = chat.messages[0].time.stringFormattedMessageDay()
            rows.append(SpecificChatRowType(id: id, rowEnum: SpecificChatRowEnum.newDate, rowInfo1: id, rowInfo2: nil))
            rows.append(SpecificChatRowType(id: chat.messages[0].time.stringFormattedDefault(), rowEnum: chat.messages[0].sender != mobile ? .sender : .receiver, rowInfo1: chat.messages[0].message, rowInfo2: chat.messages[0].time.stringFormattedMessageHour()))
            for index in 1..<chat.messages.count {
                if !Calendar.current.isDate(Date.init(timeIntervalSince1970: chat.messages[index].time), inSameDayAs: Date.init(timeIntervalSince1970: chat.messages[index-1].time)) {
                    id = chat.messages[index].time.stringFormattedMessageDay()
                    rows.append(SpecificChatRowType(id: id, rowEnum: SpecificChatRowEnum.newDate, rowInfo1: id, rowInfo2: nil))
                }
                let isSender = chat.messages[index].sender != mobile
                if isSender {
                    sentMessageExist = true
                }
                rows.append(SpecificChatRowType(id: chat.messages[index].time.stringFormattedDefault(), rowEnum: isSender ? .sender : .receiver, rowInfo1: chat.messages[index].message, rowInfo2: chat.messages[index].time.stringFormattedMessageHour()))
            }
            if chat.name == "" && !sentMessageExist {
                rows.append(SpecificChatRowType(id: "unknownPerson", rowEnum: SpecificChatRowEnum.unknownPerson, rowInfo1: nil, rowInfo2: nil))
                writeDisabled = true
            }
            else if chat.unreadMessageNumber != 0 && chat.messages.count != chat.unreadMessageNumber {
                var insert = 0
                var subtract = chat.unreadMessageNumber + 1
                for index in stride(from: rows.count - 1, through: 0, by: -1) {
                    if rows[index].rowEnum == .sender || rows[index].rowEnum == .receiver {
                        subtract -= 1
                    }
                    if subtract == 0 {
                        insert = index + 1
                        break
                    }
                }
                rows.insert(SpecificChatRowType(id: "unreadMessages", rowEnum: SpecificChatRowEnum.unreadMessages, rowInfo1: nil, rowInfo2: nil), at: insert)
                scrollId = rows[insert + 1].id
            }
            if chat.unreadMessageNumber == 0 {
                scrollId = rows[rows.count - 1].id
            }
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
