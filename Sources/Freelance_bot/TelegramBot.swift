//
// Created by alex on 14.03.19.
//

import ZEGBot
import Foundation

class TelegramBot {
    let bot: ZEGBot?
    let sender: Sendable?

    init(sender: Sendable, botToken: String) {
        bot = ZEGBot(token: botToken)
        self.sender = sender
    }

    func sendMessage(_ message: String) {
        do {
            try bot!.send(message: message, to: sender!, parseMode: .html)
        } catch let error {
            //print("Failed to send message due to: \(error)")
            log.error("Failed to send message due to: \(error)")
        }
    }

}
