//
// Created by alex on 11.12.2019.
//

import ZEGBot
import Foundation

class Sender: Sendable {
    var chatId: Int
    var replyToMessageId: Int?

    init(chatId: Int){
        self.chatId = chatId
    }
}
