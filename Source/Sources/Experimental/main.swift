import Geometry
import TerrainGenerator
import Foundation
import simd
 
let nRows = 50
let nColumns = 50
let nFixed = 0

var mesh = Geometry.StaticMeshFactory.unitGrid(nRows: nRows,nColumns: nColumns)
var terrainMap = FractalNoiseMap(
    octaves: 4,
    roughness: 0.52,
    lacunarity: 2.11,
    seed: 23,
    scale: 0.015
)

mesh.geometry = mesh.geometry.map{
    let coords = SIMD2<Float>($0.x,$0.y)
    return simd_float3($0.x,$0.y,10*terrainMap.height(coordinates: coords))
}

let cost: (simd_float3) -> Float = { x in
    return 1
}

let fixed = (0..<nFixed)
    .map{ _ in
        Int.random(in: 0..<(nRows*nColumns))
    }

var optimizer = Geometry.RubberBandOptimizer(cost: cost, edgeSamples: 3, fixedVertices: Set(fixed))
optimizer.loadStaticMesh(staticMesh: mesh)

do {
        // let fileManager = FileManager.default
        // let homeDirectory = fileManager.homeDirectoryForCurrentUser
        // let repositoriesDirectory = homeDirectory.appendingPathComponent("Repositories/MAPF-Crowd/temp/")
        //
        // if !fileManager.fileExists(atPath: repositoriesDirectory.path) {
        //     try fileManager.createDirectory(at: repositoriesDirectory, withIntermediateDirectories: true, attributes: nil)
        // }
        //
        // let fileURL = repositoriesDirectory.appendingPathComponent("meeesh.obj")
        // let string = ObjEncoder.encode(mesh: mesh)
        // try string.write(to: fileURL, atomically: true, encoding: .utf8)
 

    for i in 0..<10000 {

        optimizer.executeIteration()
        print("Iteration \(i)")
        let fileManager = FileManager.default
        let homeDirectory = fileManager.homeDirectoryForCurrentUser
        let repositoriesDirectory = homeDirectory.appendingPathComponent("Repositories/MAPF-Crowd/temp/")

        if !fileManager.fileExists(atPath: repositoriesDirectory.path) {
            try fileManager.createDirectory(at: repositoriesDirectory, withIntermediateDirectories: true, attributes: nil)
        }

        let fileURL = repositoriesDirectory.appendingPathComponent("step\(i).obj")
        let string = ObjEncoder.encode(mesh: optimizer.getResult())
        try string.write(to: fileURL, atomically: true, encoding: .utf8)
    }
}
