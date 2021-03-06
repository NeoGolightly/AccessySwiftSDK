// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "AccessySwiftSDK",
  platforms: [.iOS(.v14), .macOS(.v10_15)],
  products: [
    // Products define the executables and libraries a package produces, and make them visible to other packages.
    .library(
      name: "AccessySwiftSDK",
      targets: ["AccessySwiftSDK"]),
  ],
  dependencies: [
    .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.4.0")),
    .package(url: "https://github.com/apple/swift-log.git", from: "1.0.0"),
    .package(url: "https://github.com/Quick/Quick.git", branch: "main"),
    .package(url: "https://github.com/Quick/Nimble.git", branch: "main"),
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages this package depends on.
    .target(
      name: "AccessySwiftSDK",
      dependencies: [
        .product(name: "Logging", package: "swift-log"),
        .product(name: "Alamofire", package: "Alamofire"),
        
      ]),
    .testTarget(
      name: "AccessySwiftSDKTests",
      dependencies: ["AccessySwiftSDK", "Quick", "Nimble"]),
  ]
)
