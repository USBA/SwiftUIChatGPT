//
//  Message.swift
//  SwiftUIChatGPT
//
//  Created by Umayanga Alahakoon on 2023-03-30.
//

import SwiftUI

struct Message: Identifiable {
    var id = UUID()
    var type: MessageType
    var text: String
    
    enum MessageType {
        case question, response
    }
}
