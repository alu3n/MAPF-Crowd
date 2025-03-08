// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MAPF-Crowd",
    platforms: [.macOS(.v10_15)],   
    products: [
        .executable(
            name: "CommandLineInterface", 
            targets: ["CommandLineInterface"]
        ),
        .library(
            name: "Topology", 
            targets: ["Topology"]
        ),
        .library(
            name: "Geometry",
            targets: ["Geometry"]
        ),
        .executable(
            name: "Experimental", 
            targets: ["Experimental"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/swiftlang/swift-testing.git",
            branch: "main"
        )],
    targets: [

        .target(name: "Geometry", dependencies: ["Topology"], path: "Sources/Geometry"),
        .target(name: "Topology", path: "Sources/Topology"),
        .executableTarget(
            name: "Experimental",
            dependencies: [
                "Geometry",
                "Topology",
            ],
            path: "Sources/Experimental"
        ),
        .executableTarget(
            name: "CommandLineInterface",
            dependencies: [
                "Topology",
                "Geometry",
            ],
            path: "Sources/CommandLineInterface"
        ),
        .testTarget(
            name: "TopologyTests",
            dependencies: [
                .product(
                    name: "Testing", 
                    package: "swift-testing"
                ),
                .target(name: "Topology"),
            ],
            path: "Tests/TopologyTests"
        ),
    ]
    
)
