import Foundation
import SwiftyBeaver

let logFile = "./swiftybeaver.log"
let log = SwiftyBeaver.self
let file = FileDestination()
file.asynchronously = false
file.format = "$DHH:mm:ss.SSS$d $L $N.$F:$l - $M"
log.addDestination(file)

func main() {
    FilesOperations.deleteLogFile(logFile)
    log.info("start parser")
    let b = BotFreelanceRu(url: "https://freelance.ru/projects/?spec=4")
    b.run()
    log.info("end parser")
}

main()
