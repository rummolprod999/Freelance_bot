//
// Created by alex on 10.12.2019.
//
import SwiftSoup
import Foundation
import Configuration

protocol Bot {
    var url: String? {get}
    init(url: String, configuration: Configuration)
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
        return elems
    }
}
