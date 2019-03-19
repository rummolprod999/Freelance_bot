//
// Created by alex on 14.03.19.
//

import Foundation
import SwiftSoup

struct Post {
    let id: String
    let name: String
    let description: String
    let date: String
    let price: String
    let url: String

    init(element: Element) {
        do {
            id = try element.attr("data-project-id")
        } catch {
            id = ""
        }
        do {
            name = try element.select("a.ptitle > span").first()?.text() ?? ""
        } catch {
            name = ""
        }
        do {
            description = try element.select("a.descr > p > span:nth-child(2)").first()?.text() ?? ""
        } catch {
            description = ""
        }
        do {
            let turl = try element.select("a.descr").first()?.attr("href") ?? ""
            url = "https://freelance.ru\(turl)"
        } catch {
            url = ""
        }
        do {
            date = try element.select("li.pdata.proj-inf").first()?.text() ?? ""
        } catch {
            date = ""
        }
        do {
            price = try element.select("span.cost > a").first()?.text() ?? ""
        } catch {
            price = ""
        }
    }
}


