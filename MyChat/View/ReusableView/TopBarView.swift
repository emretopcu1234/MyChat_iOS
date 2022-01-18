//
//  TopBarView.swift
//  MyChat
//
//  Created by Emre Topçu on 12.01.2022.
//

import SwiftUI

enum TopBarType {
    case Friends
    case Chats
    case SpecificChat
    case Profile
}

struct TopBarView: View {
    
    var topBarType: TopBarType
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        
        HStack {
            switch topBarType {
            case .Friends:
                ZStack {
                    HStack {
                        Spacer()
                        Text("Friends")
                            .font(.title2)
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Button {
                            // TODO
                        } label: {
                            Image(systemName: "plus")
                                .foregroundColor(.blue)
                                .scaleEffect(1.5)
                                .padding()
                        }
                    }
                }
            case .Chats:
                ZStack {
                    HStack {
                        Spacer()
                        Text("Chats")
                            .font(.title2)
                        Spacer()
                    }
                    HStack {
                        Button {
                            // TODO
                        } label: {
                            Text("Edit")
                                .font(.title3)
                                .foregroundColor(.blue)
                                .padding()
                        }
                        Spacer()
                        Button {
                            // TODO
                        } label: {
                            Image(systemName: "square.and.pencil")
                                .foregroundColor(.blue)
                                .scaleEffect(1.5)
                                .padding()
                        }
                    }
                }
            case .SpecificChat:
                ZStack {
                    HStack {
                        Spacer()
                        VStack {
                            Text("Michael Clooney")
                                .font(.title2)
                            Text("last seen yesterday at 11:38")
                                .font(.system(size: 15))
                                .foregroundColor(Color("Gray"))
                        }
                        Spacer()
                    }
                    HStack {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.blue)
                                .scaleEffect(1.5)
                                .padding()
                        }
                        Spacer()
                        Image(systemName: "person.circle")
                            .resizable()
                            .aspectRatio(1, contentMode: .fill)
                            .frame(width: 50, height: 50)
                            .padding()
                            .onTapGesture {
                                // TODO
                            }
                    }
                }
            case .Profile:
                VStack {
                    HStack {
                        Spacer()
                        Text("Profile")
                            .font(.title2)
                        Spacer()
                    }
                    Divider()
                        .padding(.leading)
                        .padding(.trailing)
                }
            }
        }
        .frame(height: 60)
        .background(Color("DarkWhite"))
        .padding(.top, CGFloat(UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0))
        .ignoresSafeArea(edges: .top)
    }
}

struct TopBarView_Previews: PreviewProvider {
    static var previews: some View {
        TopBarView(topBarType: TopBarType.SpecificChat)
            .previewLayout(.sizeThatFits)
    }
}
