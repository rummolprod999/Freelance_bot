//
// Created by alex on 14.03.19.
//

import Foundation

class DownloadPage {
    static func download(page: String) -> String? {
        guard let url = URL(string: page) else {
            return nil
        }
        do {
            let html = try String(contentsOf: url)
            return html
        } catch let error {
            log.error("Failed to send message due to: \(error)")
            return nil
        }
    }
}
