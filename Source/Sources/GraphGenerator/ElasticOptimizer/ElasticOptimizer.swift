import AppKit
import Geometry
import simd

class ElasticOptimizer {
    let config: ElasticOptimizerConfig
    var cache: ElasticOptimizerCache

    init(staticMesh: StaticMesh, config: ElasticOptimizerConfig) {
        self.cache = ElasticOptimizerCache(staticMesh: staticMesh)
        self.config = config
    }

    package func optimizeGeometry(numberOfIterations: Int) {
        assert(numberOfIterations >= 0)

        projectToSurface()
        
        for i in 0..<numberOfIterations {
            print("Executing iteration \(i)")
            executeIteration()
            
            if config.logIterations {
                logIteration(iteration: i) 
            } 
        }

    }

    func executeIteration() {
        cache.cleanCache()
        projectToSurface()
        computeEdgeCurves()
        computeCurveIntegrals()
        adjustEdges()
    }

    func projectToSurface() {
        cache.staticMesh.geometry = cache.staticMesh.geometry
            .map{ p in 
                simd_float3(p.x,p.y,config.heightMap(SIMD2<Float>(p.x,p.y)))
            }
    }

    func computeEdgeCurves() {
        let alphas = (0..<(config.edgeSamples+1))
            .map { i in
                1.0 - Float(i) / Float(config.edgeSamples)
            }

        for edge in cache.staticMesh.topology.edges {
            let from = cache.staticMesh.geometry[edge.from]
            let to = cache.staticMesh.geometry[edge.to]
            let samples = alphas
                .map{ alpha in
                    from * alpha + to * (1 - alpha) 
                }
            cache.edgeCurves.append(PolygonalChain(vertices: samples))
        }
    }

    func computeCurveIntegrals() {
        let up = simd_float3(0,0,1)
        cache.edgeCostMean = 0

        for curve in cache.edgeCurves {
            var total: Float = 0.0

            

            for i in 0..<(curve.vertices.count - 1) {
                let shift = curve.vertices[i+1] - curve.vertices[i]
                let direction = normalize(shift)
                let angle = acos(dot(direction,up))
                let length = length(shift)
                total += config.angleCost(angle - 3.14/2) * length
            }
            cache.edgeCostMean += total  
            cache.edgeCurveIntegrals.append(total)
        }

        cache.edgeCostMean /= Float(cache.edgeCurves.count)
    }

    func adjustEdges() {
        var changeBuffer: [simd_float3] = Array(repeating: simd_float3(0,0,0), count: cache.staticMesh.geometry.count)

        for (i,edge) in cache.staticMesh.topology.edges.enumerated() {
            // if(Float.random(in: 0.0..<1.0) > 0.85){
            //     continue
            // }
            let iFrom = edge.from
            let iTo = edge.to

            let from = cache.staticMesh.geometry[iFrom]
            let to = cache.staticMesh.geometry[iTo]
            let midpoint = mix(from,to,t: 0.5)

            let midToFrom = from - midpoint
            let midToTo = to - midpoint

            let scaleCoefficient = config.targetEdgeCost / cache.edgeCurveIntegrals[i]

            let correctFrom = midpoint + scaleCoefficient * midToFrom
            let correctTo = midpoint + scaleCoefficient * midToTo
            
            let correctionFrom = correctFrom - from
            let correctionTo = correctTo - to

            changeBuffer[iFrom] += correctionFrom
            changeBuffer[iTo] += correctionTo
        }

        for (i,correction) in changeBuffer.enumerated() {
            cache.staticMesh.geometry[i] += config.correctionAmount * correction
        }
    }

    func logIteration(iteration: Int) {
        let fileURL = URL(fileURLWithPath: (config.logPath + "log_iteration_\(iteration).obj" as NSString).expandingTildeInPath).standardized

        let string = ObjEncoder.encode(mesh: cache.staticMesh)
        do {
            try string.write(to: fileURL, atomically: true, encoding: .utf8)
        }
        catch {
            print("Failed logging \(fileURL)")
        }
    }
}
