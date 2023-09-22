// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Core",
  platforms: [.iOS(.v14), .macOS(.v11)],
  products: [
    .library(
      name: "Core",
      targets: ["Core"]
    ),
  ],
  dependencies: [
    .package(name: "ComposableArchitecture", url: "https://github.com/pointfreeco/swift-composable-architecture.git", .branch("main")),
  ],
  targets: [
    .target(
      name: "Core",
      dependencies: [
        "ComposableArchitecture"
      ]
    ),
    .testTarget(
      name: "CoreTests",
      dependencies: ["Core"]),
  ]
)
