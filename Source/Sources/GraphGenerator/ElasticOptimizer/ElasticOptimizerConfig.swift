import Geometry

struct ElasticOptimizerConfig {
    let angleCost: (Float) -> Float
    let heightMap: HeightMap
    let targetEdgeCost: Float
    let logIterations: Bool
    let logPath: String
    let edgeSamples: Int
    let correctionAmount: Float
}

