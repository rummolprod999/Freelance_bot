//
// Created by alex on 10.12.2019.
//

import Foundation
import SwiftSoup

class BotFlRu: Bot {
    var url: String?

    required init(url: String) {
        self.url = url
    }

    func getAllPost(html: String) -> Array<Element>? {
        do {
            let doc: Document = try SwiftSoup.parse(html)
            let elements = try doc.select("div.b-post")
            return elements.array()
        } catch Exception.Error(_, let message) {
            log.error("Failed get elements from page: \(message)")
            return nil
        } catch {
            log.error("Failed get elements from page")
            return nil
        }
    }

    internal func CreatePost(p: Element, sqlite: SqliteUtils?) {
        let message = MessageFl(element: p)
        let (id, msg) = message.createMessage()
        if let notExist = sqlite?.checkPost(id_post: id), notExist {
            let bot = TelegramBot(sender: SenderFl())
            bot.sendMessage(msg)
        }
    }

}
