// swift-tools-version: 5.9

import PackageDescription

let package = Package(
  name: "zyy",
  platforms: [.macOS(.v13)],
  dependencies: [
    .package(
      url: "https://github.com/apple/swift-argument-parser.git",
      from: "1.2.2"
    ),
    .package(url: "https://github.com/fang-ling/ccmark-gfm", branch: "master"),
    .package(url: "https://github.com/fang-ling/csqlite", from: "0.0.2")
  ],
  targets: [
    .executableTarget(
      name: "zyy",
      dependencies: [
        .product(name: "CSQLite", package: "csqlite"),
        .product(name: "ArgumentParser", package: "swift-argument-parser"),
        .product(name: "cmark-gfm", package: "ccmark-gfm"),
        .product(name: "cmark-gfm-extensions", package: "ccmark-gfm"),
      ]
    ),
    .testTarget(
      name: "zyyTests",
      dependencies: ["zyy"]
    ),
  ]
)
