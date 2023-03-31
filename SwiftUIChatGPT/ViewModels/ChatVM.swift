//
//  ChatVM.swift
//  SwiftUIChatGPT
//
//  Created by Umayanga Alahakoon on 2023-03-30.
//

import SwiftUI
import OpenAISwift

class ChatVM: ObservableObject {
    var openAI = OpenAISwift(authToken: "REPLACE-THIS-WITH-YOUR-OPENAI-API-KEY")
    
    // chat history
    @Published var chat: [Message] = []
    
    // automatically scroll to this chat message
    @Published var scrollToMessageID: UUID?
    
    // bottom text-box
    @Published var textBox = ""
    
    // remove extra white spaces in the text entered by the user
    var trimmedTextBox: String {
        textBox.trimmingCharacters(in: .whitespaces)
    }
    
}

extension ChatVM {
    
    // ask a question
    func askQuestion() {
        // add the question to the chat
        let question = Message(type: .question, text: self.trimmedTextBox)
        withAnimation {
            self.chat.append(question)
        }
        // scroll to newly added chat message
        self.scrollToMessageID = question.id
        // clean the text box
        self.textBox = ""
        
        // get the answer from OpenAI
        openAI.sendCompletion(with: trimmedTextBox, maxTokens: 500) { result in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    // add the answer to the chat
                    let responseText = success.choices?.first?.text ?? ""
                    let answer = Message(type: .response, text: responseText)
                    withAnimation {
                        self.chat.append(answer)
                    }
                    print("SUCCESS: \(responseText)")
                    // scroll to newly added chat message
                    self.scrollToMessageID = answer.id
                }
                
            case .failure(let failure):
                DispatchQueue.main.async {
                    // add the error message to the chat
                    let responseText = failure.localizedDescription
                    let answer = Message(type: .response, text: responseText)
                    withAnimation {
                        self.chat.append(answer)
                    }
                    print("FAILURE: \(responseText)")
                    // scroll to newly added chat message
                    self.scrollToMessageID = answer.id
                }
            }
        }
    }
    
    
    // clean the chat
    func cleanTheChat() {
        withAnimation {
            // remove all the messages after 1 second
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.chat.removeAll()
            }
        }
    }
    
}
