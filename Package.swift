// swift-tools-version: 5.9

import PackageDescription

let package = Package(
  name: "zyy",
  platforms: [.macOS(.v13)],
  dependencies: [
    .package(
      url: "https://github.com/apple/swift-argument-parser.git",
      from: "1.3.1"
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
      ]
    ),
    .executableTarget(
      name: "zyy-reactions",
      dependencies: [
        .product(name: "Vapor", package: "vapor"),
        .product(name: "Fluent", package: "fluent"),
        .product(name: "FluentSQLiteDriver", package: "fluent-sqlite-driver")
      ],
      resources: [
        .copy("Resources/zyy.css")
      ]
    ),
    .testTarget(
      name: "zyyTests",
      dependencies: ["zyy"]
    ),
    .testTarget(
      name: "zyy-reactionsTests",
      dependencies: [
        .target(name: "zyy-reactions"),
        .product(name: "XCTVapor", package: "vapor")
      ]
    )
  ]
)
