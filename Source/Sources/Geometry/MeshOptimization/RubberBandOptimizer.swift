import simd

package class RubberBandOptimizer {
    let cost: (Vec3) -> Float
    let edgeSamples: Int
    
    private var staticMesh: StaticMesh?
    private var edgeSamplesCache: [[simd_float3]] = []
    private var integrals: [Float] = []
    private var meanIntegral: Float = 0
    private var vertexCorrections: [[simd_float3]] = []

    package init(cost: @escaping (simd_float3) -> Float, edgeSamples: Int){
        assert(edgeSamples > 1) 
        self.cost = cost
        self.edgeSamples = edgeSamples
    }

    package func loadStaticMesh(staticMesh: StaticMesh) {
        self.staticMesh = staticMesh
    }

    package func executeIteration() {
        assert(staticMesh != nil)
        sampleEdges()
    }

    package func getResult() -> StaticMesh {
        assert(staticMesh != nil)
        return staticMesh!
    }

    private func sampleEdges() {
        // TODO: Write tests for this 
        edgeSamplesCache = [[]]
        let mesh = staticMesh!
        
        let coordinateTouples = mesh.topology.edges
            .map{
                (mesh.geometry[$0.from],mesh.geometry[$0.to])
            }
        
        let samples = Array(0..<(edgeSamples + 1))
            .map{
                Float($0) / Float(edgeSamples) 
            }

        self.edgeSamplesCache = []
        for coords in coordinateTouples {
            var temp: [Vec3] = [] 
            for sample in samples {
                let coord: Vec3 = (1 - sample) * coords.0 + sample * coords.1
                temp.append(coord)
            }
            edgeSamplesCache.append(temp)
        }
    }

    private func integrateEdges() {
        // Note: I am using trapezoidal approximation to compute the integral
        //
        // for sampleSequence in edgeSamplesCache {
        //     let values = sampleSequence.map{
        //         cost($0)
        //     }
        //     for i in 0..<(sampleSequence.count - 1) {
        //         let midpoint = sampleSequence[i]
        //     }
        // }
    }

    private func computeMean() {

    }

    private func computeCorrections() {

    }

    private func evaluateCorrections() {

    }



}
