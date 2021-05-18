// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BenchLearning",
    platforms: [
        .macOS(.v10_14),
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "BenchLearning",
            targets: ["BenchLearning"]),
        .executable(name: "sample-benchmark", targets: ["sample-benchmark"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-collections-benchmark", from: "0.0.1"),
    ],
    targets: [
        .target(
            name: "BenchLearning",
            dependencies: []),
        .target(
            name: "sample-benchmark",
            dependencies: [
                "BenchLearning",
                .product(name: "CollectionsBenchmark", package: "swift-collections-benchmark")
            ]
        ),
        .testTarget(
            name: "BenchLearningTests",
            dependencies: ["BenchLearning"]),
    ]
)
