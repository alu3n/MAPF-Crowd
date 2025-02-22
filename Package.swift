// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MAPF-Crowd",
    
    products: [
        .executable(name: "CommandLineInterface", targets: ["CommandLineInterface"]),
        .library(name: "Topology", targets: ["Topology"]),
        .library(name: "Geometry", targets: ["Geometry"]),
        .library(name: "Solver", targets: ["Solver"])
    ],
    
    targets: [
        .executableTarget(name: "Command Line Interface", path: "Sources/CommandLineInterface"),
        .target(name: "Topology", path: "Sources/Topology"),
        .target(name: "Geometry", dependencies: ["Topology"] ,path: "Sources/Geometry"),
        .target(name: "Solver", dependencies: ["Geometry"], path: "Sources/Solver")
    ]
    
)
