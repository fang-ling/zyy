// swift-tools-version: 5.10

import PackageDescription

let package = Package(
  name: "zyy",
  platforms: [.macOS(.v14)],
  dependencies: [
    .package(
      url: "https://github.com/apple/swift-argument-parser.git",
      from: "1.0.0"
    ),
    .package(url: "https://github.com/fang-ling/ccmark-gfm", branch: "master"),
    .package(url: "https://github.com/fang-ling/system-sqlite", from: "0.1.0"),
    .package(url: "https://github.com/vapor/vapor.git", from: "4.93.0"),
    .package(url: "https://github.com/vapor/fluent.git", from: "4.9.0"),
    .package(
      url: "https://github.com/vapor/fluent-sqlite-driver.git",
      from: "4.6.0"
    ),
  ],
  targets: [
    .executableTarget(
      name: "zyy",
      dependencies: [
        .product(name: "SystemSQLite", package: "system-sqlite"),
        .product(name: "ArgumentParser", package: "swift-argument-parser"),
        .product(name: "cmark-gfm", package: "ccmark-gfm"),
        .product(name: "cmark-gfm-extensions", package: "ccmark-gfm"),
      ],
      linkerSettings: [
        .unsafeFlags([
          "-Xlinker", "-sectcreate",
          "-Xlinker", "__TEXT",
          "-Xlinker", "__info_plist",
          "-Xlinker", "Sources/Resources/Info.plist"
        ])
      ]
    ),
    .executableTarget(
      name: "zyy-deprecate",
      dependencies: [
        .product(name: "Vapor", package: "vapor"),
        .product(name: "Fluent", package: "fluent"),
        .product(name: "FluentSQLiteDriver", package: "fluent-sqlite-driver")
      ],
      resources: [
        .copy("Resources/zyy.css"),
        .copy("Resources/zyy.js")
      ]
    ),
    .testTarget(
      name: "zyyTests",
      dependencies: ["zyy"]
    ),
    .testTarget(
      name: "zyy-deprecateTests",
      dependencies: [
        .target(name: "zyy-deprecate"),
        .product(name: "XCTVapor", package: "vapor")
      ]
    )
  ]
)
