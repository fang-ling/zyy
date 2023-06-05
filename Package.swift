// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "zyy",
    platforms: [.macOS(.v13)],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser.git",
                 from: "1.2.2")
    ],
    targets: [
        .executableTarget(
            name: "zyy",
            dependencies: [
                "CMark",
                "CSQLite",
                .product(name: "ArgumentParser",
                         package: "swift-argument-parser")
            ]),
        .systemLibrary(
            name: "CMark",
            pkgConfig: "libcmark-gfm",
            providers: [
              .brew(["cmark-gfm"])
            ]
        ),
        .systemLibrary(
            name: "CSQLite",
            pkgConfig: "sqlite3"
        ),
        .testTarget(
            name: "zyyTests",
            dependencies: ["zyy"]),
    ]
)
