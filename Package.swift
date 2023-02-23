// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to
// build this package.

import PackageDescription

let package = Package(
    name: "zyy",
    dependencies: [
        // Dependencies declare other packages that this package depends on.
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
        .target(
            name: "CMark",
            path: "Sources/CMark"//,
            //exclude: ["include/case_fold_switch.inc"]
        ),
        .target(
            name: "CSQLite",
            path: "Sources/CSQLite"
        ),
        .testTarget(
            name: "zyyTests",
            dependencies: ["zyy"]),
    ]
)
