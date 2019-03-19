//
// Created by alex on 18.03.19.
//

import Foundation

class FilesOperations {
    static func deleteLogFile(_ logFile: String) {
        let fm = FileManager.default
        if !fm.fileExists(atPath: logFile){
            return
        }
        do {
            let attr = try FileManager.default.attributesOfItem(atPath: logFile)
            let fileSize = attr[FileAttributeKey.size] as! UInt64
            if fileSize > 1_000_000 {
                try fm.removeItem(atPath: logFile)
            }
        } catch {
            log.error("Failed get log file size or delete this file")
        }
    }
}
