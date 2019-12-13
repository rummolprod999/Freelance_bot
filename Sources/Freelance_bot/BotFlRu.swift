//
// Created by alex on 10.12.2019.
//

import Foundation
import SwiftSoup

class BotFlRu: Bot {
    var url: String?
    var configuration: Configuration

    required init(url: String, configuration: Configuration) {
        self.url = url
        self.configuration = configuration
    }

    func getAllPost(html: String) -> Array<Element>? {
        do {
            let cleanHtml = html.replacingOccurrences(of: "<script type=\"text/javascript\">document.write('", with: "").replacingOccurrences(of: "');</script>", with: "")
            let doc: Document = try SwiftSoup.parse(cleanHtml)
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
            let bot = TelegramBot(sender: Sender(chatId: configuration.chatIdFl), botToken: configuration.botToken)
            bot.sendMessage(msg)
        }
    }

    func filterPosts(elems: Array<Element>) -> Array<Element> {
        var newArr: Array<Element> = []
        for e in elems {
            do {
                let text = try e.html()
                if !text.contains("Для всех") {
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
