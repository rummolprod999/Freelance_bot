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
            let bot = TelegramBot()
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

    func filterPosts(elems: Array<Element>) -> Array<Element> {
        var newArr: Array<Element> = []
        for e in elems {
            do {
                let text = try e.text()
                if text.contains("Для Бизнес-аккаунтов") {
                    continue
                }
                newArr.append(e)
            } catch Exception.Error(_, let message) {
                log.error("Failed extract text from post: \(message)")
            } catch {
                log.error("Failed extract text from post")
            }
        }
        return newArr

    }
}
