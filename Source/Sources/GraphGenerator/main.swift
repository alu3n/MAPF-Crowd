import Geometry
import Foundation
import simd

// Flat terrain
let log = "./Log/Experiment3/"
let iterations = 5000
let targetEdgeCost: Float = 1.0
let nRows = 60
let nColumns = 60
let correctionAmount: Float = 0.5
var terrainMap = FlatMap()
func angleCost(_ value: Float) -> Float {
    return 1.0
}

// // Gaussian with constant angle cost  
// let log = "./Log/Experiment1/"
// let iterations = 5000
// let targetEdgeCost: Float = 1.0
// let nRows = 40
// let nColumns = 40
// var terrainMap = GaussianMap(
//     inputScale: simd_float2(0.1,0.1),
//     outputScale: 10,
//     origin: simd_float2(20,20)
// )
// func angleCost(_ value: Float) -> Float {
//     return 1.0
// }


// // Gaussian with variable angle cost
// let log = "./Log/Experiment2/"
// let iterations = 5000
// let targetEdgeCost: Float = 1.0
// let nRows = 60
// let nColumns = 60
// var terrainMap = GaussianMap(
//     inputScale: simd_float2(0.2,0.2),
//     outputScale: 10,
//     origin: simd_float2(30,30)
// )
// func angleCost(_ value: Float) -> Float {
//     return 1.0 + abs(value) * 10
// }


// Terrain with constant angle cost 
// let log = "./Log/Experiment3/"
// let iterations = 5000
// let targetEdgeCost: Float = 1.0
// let nRows = 60
// let nColumns = 60
// var terrainMap = FractalNoiseMap(
//     octaves: 5,
//     roughness: 0.5,
//     lacunarity: 2.01,
//     seed: 23,
//     inputScale: simd_float2(0.1,0.1),
//     outputScale: 5,
//     origin: simd_float2(0.0,0.0)
// )
// func angleCost(_ value: Float) -> Float {
//     return 1.0
// }






// func angleCost(_ value: Float) -> Float {
//     return 1.0 + 15*abs(value)
// }

var mesh = Geometry.StaticMeshFactory.unitGrid(nRows: nRows,nColumns: nColumns)
var config = ElasticOptimizerConfig(
    angleCost: angleCost,
    heightMap: terrainMap,
    targetEdgeCost: targetEdgeCost,
    logIterations: true,
    logPath: log,
    edgeSamples: 2,
    correctionAmount: correctionAmount
)

var optimizer = ElasticOptimizer(staticMesh: mesh, config: config) 
optimizer.optimizeGeometry(numberOfIterations: iterations)
