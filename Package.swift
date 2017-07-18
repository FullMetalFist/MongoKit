// swift-tools-version:3.1

import PackageDescription

let package = Package(
    name: "mongokit",
    dependencies: [
        .Package(url: "https://github.com/IBM-Swift/Kitura.git", majorVersion: 1, minor: 3),
        .Package(url: "https://github.com/IBM-Swift/HeliumLogger.git", majorVersion: 1, minor: 3),
        .Package(url: "https://github.com/IBM-Swift/Swift-cfenv.git", majorVersion: 1, minor: 9),
        .Package(url: "https://github.com/IBM-Bluemix/cf-deployment-tracker-client-swift.git", majorVersion: 0, minor: 8),
        .Package(url: "https://github.com/OpenKitten/MongoKitten.git", majorVersion: 3)
    ],
    exclude: ["Makefile", "Package-Builder"]
)
