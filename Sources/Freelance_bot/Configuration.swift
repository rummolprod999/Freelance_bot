//
// Created by alex on 13.12.2019.
//

import Foundation
import Configuration

class Configuration {
    public var chatIdFreelance: Int
    public var chatIdFl: Int
    public var botToken: String

    init(manager: ConfigurationManager) {
        self.chatIdFreelance = manager["chatIdFreelance"] as? Int ?? 0
        self.chatIdFl = manager["chatIdFl"] as? Int ?? 0
        self.botToken = manager["botToken"] as? String ?? ""
    }
}

extension ConfigurationManager {

    internal func build() -> Configuration {
        let configuration = Configuration(manager: self)
        return configuration
    }
}
