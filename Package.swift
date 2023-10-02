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
    .package(url: "https://github.com/fang-ling/ccmark-gfm", branch: "master")
  ],
  targets: [
    .executableTarget(
      name: "zyy",
      dependencies: [
        "CSQLite",
        .product(name: "ArgumentParser", package: "swift-argument-parser"),
        .product(name: "cmark-gfm", package: "ccmark-gfm"),
        .product(name: "cmark-gfm-extensions", package: "ccmark-gfm"),
      ]
    ),
    .systemLibrary(name: "CSQLite"),
    .testTarget(
      name: "zyyTests",
      dependencies: ["zyy"]
    ),
  ]
)
