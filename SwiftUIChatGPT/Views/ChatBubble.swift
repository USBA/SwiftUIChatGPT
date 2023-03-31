//
//  ChatBubble.swift
//  SwiftUIChatGPT
//
//  Created by Umayanga Alahakoon on 2023-03-30.
//

import SwiftUI

struct ChatBubble: View {
    @Environment(\.colorScheme) var colorScheme
    
    var message: Message
    
    var body: some View {
        Text(message.text)
            .textSelection(.enabled)
            .multilineTextAlignment(message.type == .question ? .trailing : .leading)
            .foregroundColor(message.type == .question ? .white : .primary)
            .padding(12.5)
            .background(message.type == .question ? Color.accentColor : Color.accentColor.opacity(colorScheme == .dark ? 0.2 : 0.1))
            // set the corner radius for some specific corners
            .cornerRadius(15, corners: message.type == .question ? [.topLeft, .topRight, .bottomLeft] : [.topRight, .bottomRight, .bottomLeft])
            .padding(.horizontal, 12.5)
            // scale animation when appearing a new chat bubble
            .transition(.scale(scale: 0, anchor: message.type == .question ? .bottomTrailing : .topLeading))
            // sender's messages appear on the right side and responses appea on the left side of the screen
            .frame(maxWidth: .infinity, alignment: message.type == .question ? .trailing : .leading)
    }
}

struct ChatBubble_Previews: PreviewProvider {
    static var previews: some View {
        ChatBubble(message: Message(type: .question, text: "Hi ChatGPT, how are you?"))
    }
}
