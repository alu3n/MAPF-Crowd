import simd
import Geometry

struct ElasticOptimizerCache {
    var staticMesh: StaticMesh
    var edgeCurves: [PolygonalChain] = []
    var edgeCurveIntegrals: [Float] = []
    var edgeCorrections: [Float] = [] 
    var edgeCostMean: Float = 0
    init(staticMesh: StaticMesh) {
        self.staticMesh = staticMesh
    }

    mutating func cleanCache() {
        edgeCurves = []
        edgeCurveIntegrals = []
        edgeCorrections = []
    }

    
}
