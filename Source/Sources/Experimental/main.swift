import Geometry
import Foundation
import simd

var mesh = Geometry.StaticMeshFactory.unitGrid(nRows: 20,nColumns: 20)

let cost: (simd_float3) -> Float = { x in
    // return 1
    // return sin(x.x)*cos(x.y) + 2.0
    let vx = x.x - 20
    let vy = x.y - 20
    return 2 + cos(vx) 
}

// var optimizer = Geometry.RubberBandOptimizer(cost: cost, edgeSamples: 4)
// optimizer.loadStaticMesh(staticMesh: mesh)
// for _ in 0..<1000 {
//     optimizer.executeIteration()
// }
// mesh = optimizer.getResult()

do {
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    let jsonData = try encoder.encode(mesh)

    let fileManager = FileManager.default
    let homeDirectory = fileManager.homeDirectoryForCurrentUser
    let repositoriesDirectory = homeDirectory.appendingPathComponent("Repositories/MAPF-Crowd")

    if !fileManager.fileExists(atPath: repositoriesDirectory.path) {
        try fileManager.createDirectory(at: repositoriesDirectory, withIntermediateDirectories: true, attributes: nil)
    }
    
    let fileURL = repositoriesDirectory.appendingPathComponent("numbers.json")
     
    try jsonData.write(to: fileURL)
}
