//
//  ChatBox.swift
//  SwiftUIChatGPT
//
//  Created by Umayanga Alahakoon on 2023-03-31.
//

import SwiftUI

struct ChatBox: View {
    @ObservedObject var chatVM: ChatVM
    
    var body: some View {
        HStack(spacing: 12.5) {
            // text field
            TextField("Type here...", text: $chatVM.textBox)
                .onSubmit {
                    if !chatVM.trimmedTextBox.isEmpty {
                        chatVM.askQuestion()
                    }
                }
                .padding(12.5)
                .background {
                    RoundedRectangle(cornerRadius: 12.5)
                        .foregroundColor(Color.gray.opacity(0.1))
                }
            
            // send button
            Button {
                if !chatVM.trimmedTextBox.isEmpty {
                    chatVM.askQuestion()
                }
            } label: {
                Image(systemName: "arrow.up.circle.fill")
                    .resizable()
                    .frame(width: 32.5, height: 32.5)
                    .foregroundColor(Color.accentColor)
            }

        }
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
    }
}

struct ChatBox_Previews: PreviewProvider {
    static var previews: some View {
        ChatBox(chatVM: ChatVM())
    }
}
