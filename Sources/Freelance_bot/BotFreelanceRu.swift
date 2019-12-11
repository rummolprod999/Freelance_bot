//
// Created by alex on 14.03.19.
//

import Foundation
import SwiftSoup

class BotFreelanceRu: Bot {
    var url: String?

    required init(url: String) {
        self.url = url
    }

    internal func CreatePost(p: Element, sqlite: SqliteUtils?) {
        let message = MessageFreelance(element: p)
        let (id, msg) = message.createMessage()
        if let notExist = sqlite?.checkPost(id_post: id), notExist {
            let bot = TelegramBot(sender: SenderFreelance())
            bot.sendMessage(msg)
        }

    }

    func getAllPost(html: String) -> Array<Element>? {
        do {
            let doc: Document = try SwiftSoup.parse(html)
            let elements = try doc.select("div.proj")
            return elements.array()
        } catch Exception.Error(_, let message) {
            log.error("Failed get elements from page: \(message)")
            return nil
        } catch {
            log.error("Failed get elements from page")
            return nil
        }
    }

}
