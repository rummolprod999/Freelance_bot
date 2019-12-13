import Foundation
import SwiftyBeaver
import Configuration

let logFile = "./swiftybeaver.log"
let log = SwiftyBeaver.self
let file = FileDestination()
file.asynchronously = false
file.format = "$DHH:mm:ss.SSS$d $L $N.$F:$l - $M"
log.addDestination(file)
let configurationManager = ConfigurationManager()
        .load(file: "configuration.json", relativeFrom: .pwd).build()

func main() {
    FilesOperations.deleteLogFile(logFile)
    log.info("start parser")
    let b = BotFreelanceRu(url: "https://freelance.ru/projects/?spec=4", configuration: configurationManager)
    b.run()
    let f = BotFlRu(url: "https://www.fl.ru/projects/", configuration: configurationManager)
    f.run()
    log.info("end parser")
}

main()
