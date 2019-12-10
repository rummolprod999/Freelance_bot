//
// Created by alex on 10.12.2019.
//
import SwiftSoup
import Foundation

protocol Bot {
    var url: String? {get}
    init(url: String)
    func getAllPost(html: String) -> Array<Element>?
    func filterPosts(elems: Array<Element>) -> Array<Element>
    func CreatePost(p: Element, sqlite: SqliteUtils?)
}

extension Bot{

    func run() {
        guard let p = DownloadPage.download(page: url!) else {
            log.error("Failed download page")
            return
        }
        guard let posts = getAllPost(html: p) else {
            log.error("Can not find post on page")
            return
        }
        let fPost = filterPosts(elems: posts)
        let sqlite = SqliteUtils()
        for p in fPost {
            CreatePost(p: p, sqlite: sqlite)
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
