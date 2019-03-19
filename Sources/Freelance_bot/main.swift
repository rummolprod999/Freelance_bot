import Foundation
import SwiftyBeaver

let logFile = "./swiftybeaver.log"
FilesOperations.deleteLogFile(logFile)
let log = SwiftyBeaver.self
let file = FileDestination()
file.format = "$DHH:mm:ss.SSS$d $L $N.$F:$l - $M"
log.addDestination(file)

func main() {
    log.info("start parser")
    let b = Bot(url: "https://freelance.ru/projects/?spec=4")
    b.run()
    log.info("end parser")
}

main()
