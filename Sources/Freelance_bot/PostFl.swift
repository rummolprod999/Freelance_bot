//
// Created by alex on 14.03.19.
//

import Foundation
import SwiftSoup

public struct PostFl {
    let id: String
    let name: String
    let description: String
    let date: String
    let price: String
    let url: String

    init(element: Element) {
        do {
            let Tid = try element.attr("id")
            id = Tid.replacingOccurrences(of: "project-item", with: "")
        } catch {
            id = ""
        }
        do {
            name = try element.select("h2 > a").first()?.text() ?? ""
        } catch {
            name = ""
        }
        do {
            description = try element.select("div.b-post__body div.b-post__txt").first()?.text() ?? ""
        } catch {
            description = ""
        }
        do {
            let turl = try element.select("h2 > a").first()?.attr("href") ?? ""
            url = "https://www.fl.ru\(turl)"
        } catch {
            url = ""
        }
        do {
            let dateT = try element.select("div.b-post__foot div.b-post__txt").first()
            date = dateT?.textNodes().last?.text().trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        } catch {
            date = ""
        }
        do {
            price = try element.select("div.b-post__price").first()?.text() ?? ""
        } catch {
            price = ""
        }
    }
}


