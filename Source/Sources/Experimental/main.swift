import Geometry
import Foundation
import simd

var mesh = StaticMeshFactory.unitGrid(nRows: 7,nColumns: 7)

let cost: (simd_float3) -> Float = { x in
    return 0
}    

var optimizer = RubberBandOptimizer(cost: cost, edgeSamples: 5)
optimizer.loadStaticMesh(staticMesh: mesh)
optimizer.executeIteration()
mesh = optimizer.getResult()

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
