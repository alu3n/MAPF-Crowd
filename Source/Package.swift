// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MAPF-Crowd",
    platforms: [.macOS(.v10_15)],   
    products: [
        .library(
            name: "Topology", 
            targets: ["Topology"]
        ),
        .library(
            name: "Geometry",
            targets: ["Geometry"]
        ),
        .library(
            name: "TerrainGenerator",
            targets: ["TerrainGenerator"]
        ),
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
        .target(name: "TerrainGenerator", path: "Sources/TerrainGenerator"),
        .executableTarget(
            name: "Experimental",
            dependencies: [
                "Geometry",
                "Topology",
                "TerrainGenerator"
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
