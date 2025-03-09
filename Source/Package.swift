// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MAPF-Crowd",
    platforms: [.macOS(.v10_15)],   
    products: [
        .executable(
            name: "Experimental", 
            targets: ["Experimental"]
        ),
        .executable(
            name: "GraphGenerator",
            targets: ["GraphGenerator"]
        ),
        .executable(
            name: "MotionPlanner",
            targets: ["MotionPlanner"]
        ),
        .executable(
            name: "PathPlanner",
            targets: ["PathPlanner"]
        ),
        .library(
            name: "Topology", 
            targets: ["Topology"]
        ),
        .library(
            name: "Geometry",
            targets: ["Geometry"]
        )
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
            name: "GraphGenerator",
            dependencies: [
                "Topology",
                "Geometry",
            ],
            path: "Sources/GraphGenerator"
        ),
        .executableTarget(name: "MotionPlanner"),
        .executableTarget(name: "PathPlanner"),
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
