//
// Created by alex on 14.03.19.
//

import Foundation
import SwiftSoup

class Message {
    let element: Element?

    init(element: Element) {
        self.element = element
    }

    func createMessage() -> (id: String, msg: String) {
        let post = Post(element: element!)
        let id = post.id.trimmingCharacters(in: .whitespacesAndNewlines)
        let msg = "<b>Название:</b> \(post.name)\n<b>Описание:</b> \(post.description)\n<b>Цена:</b> \(post.price)\nДата: \(post.date)\nСсылка: \(post.url)"
        return (id: id, msg: msg)
    }
}
