//
// Created by alex on 15.03.19.
//

import Foundation
import SQLite

extension String: Error {
}

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
            let fm = FileManager.default
            if !fm.fileExists(atPath: dbName) {
                if !fm.createFile(atPath: dbName, contents: nil) {
                    throw  "cannot create file database"
                }
            }
        } catch let error {
            log.error("Failed to database connect \(error)")
            return nil
        }
        do {
            connect = try Connection(dbName)
            try connect?.execute("""
                                 BEGIN TRANSACTION;
                                       CREATE TABLE IF NOT EXISTS "Post"
                                             (
                                             id INTEGER not null
                                             constraint Post_pk
                                             primary key autoincrement,
                                             post_id TEXT not null
                                             );
                                 COMMIT TRANSACTION;
                                 """
            )
        } catch Result.error(let message, _, _) {
            log.error("Failed to database connect: \(message)")
            return nil
        } catch let error {
            log.error("Failed to database connect \(error)")
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
