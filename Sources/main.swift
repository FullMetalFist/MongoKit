import Foundation
import Kitura
import LoggerAPI
import HeliumLogger
import CloudFoundryEnv
import CloudFoundryDeploymentTracker

do {
    HeliumLogger.use(LoggerMessageType.info)
    let controller = try Controller()
    Log.info("Server will be started on \(controller.url)")
    CloudFoundryDeploymentTracker(repositoryURL: "https://github.com/FullMetalFist/MongoKit.git", codeVersion: nil).track()
    Kitura.addHTTPServer(onPort: controller.port, with: controller.router)
    // start Kitura
    Kitura.run()
} catch let error {
    Log.error(error.localizedDescription)
    Log.error("Oh no! Something is wrong. The server won't start!")
}
