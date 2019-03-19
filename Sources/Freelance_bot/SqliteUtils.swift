//
// Created by alex on 15.03.19.
//

import Foundation
import SQLite

extension AnySequence {
    var count: Int {
        return reduce(0) { acc, row in
            acc + 1
        }
    }
}

class SqliteUtils {
    let dbName = "freelance.sqlite3"
    let connect: Connection?

    init?() {
        do {
            connect = try Connection("freelance.sqlite3")
        } catch Result.error(let message, _, _) {
            log.error("Failed to database connect: \(message)")
            return nil
        } catch {
            log.error("Failed to database connect")
            return nil
        }
    }

    func checkPost(id_post: String) -> Bool {
        let posts = Table("Post")
        let post_id = Expression<String>("post_id")
        let exist = try? connect!.prepare(posts.select(post_id).filter(post_id == id_post))
        guard let c = exist else {
            return false
        }
        if c.count != 0 {
            return false
        }
        let _ = try? connect!.run(posts.insert(post_id <- id_post))
        return true
    }
}
