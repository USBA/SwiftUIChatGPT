//
//  ContentView.swift
//  SwiftUIChatGPT
//
//  Created by Umayanga Alahakoon on 2023-03-30.
//

import SwiftUI
import OpenAISwift

struct ContentView: View {
    @StateObject var chatVM = ChatVM()
    
    var body: some View {
        NavigationStack {
            VStack {
                
                // chat
                ScrollView {
                    ScrollViewReader { reader in
                        VStack(alignment: .leading, spacing: 10) {
                            
                            if chatVM.chat.isEmpty {
                                // empty state message
                                emptyStateText
                                
                            } else {
                                // message bubbles
                                ForEach(chatVM.chat) { message in
                                    ChatBubble(message: message)
                                        .id(message.id)
                                }
                            }
                            
                        }
                        .onChange(of: chatVM.scrollToMessageID) { newScrollTarget in
                            withAnimation {
                                // automatically scroll to newly added message
                                reader.scrollTo(newScrollTarget)
                            }
                        }
                        
                    }
                }
                
                // text box at the bottom
                ChatBox(chatVM: chatVM)
                
            }
            .navigationTitle(Text("ChatGPT"))
            .refreshable {
                // clean the chat on pull-to-refresh
                chatVM.cleanTheChat()
            }
        }
        // change the theme color
        .tint(Color.blue)
    }
    
    // empty state message (when the chat is empty)
    var emptyStateText: some View {
        Text("Your messages will appear here")
            .multilineTextAlignment(.center)
            .foregroundColor(.gray.opacity(0.5))
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.top, 60)
            .padding(.horizontal, 30)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
