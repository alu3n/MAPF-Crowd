import simd

package class RubberBandOptimizer {
    let cost: (simd_float3) -> Float
    let edgeSamples: Int
    let fixedVertices: Set<Int> 
    private var staticMesh: StaticMesh?
    private var edgeSamplesCache: [[simd_float3]] = []
    private var integrals: [Float] = []
    private var meanIntegral: Float = 0
    private var edgeCorrections: [Float] = []

    package init(cost: @escaping (simd_float3) -> Float, edgeSamples: Int, fixedVertices: Set<Int>){
        assert(edgeSamples > 1) 
        self.cost = cost
        self.edgeSamples = edgeSamples
        self.fixedVertices = fixedVertices 
    }

    package func loadStaticMesh(staticMesh: StaticMesh) {
        self.staticMesh = staticMesh
    }

    package func executeIteration() {
        assert(staticMesh != nil)
        sampleEdges()
        integrateEdges()
        computeMean()
        computeCorrections()
        evaluateCorrections()
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
            var temp: [simd_float3] = [] 
            for sample in samples {
                let coord: simd_float3 = mix(coords.0,coords.1,t: sample)
                temp.append(coord)
            }
            edgeSamplesCache.append(temp)
        }
    }

    private func integrateEdges() {
        // Note: I am using trapezoidal approximation to compute the integral
        //
        integrals = []
        for sampleSequence in edgeSamplesCache {
            var edgeCost: Float = 0 
            for i in 0..<(sampleSequence.count-1) {
                let a = sampleSequence[i]
                let b = sampleSequence[i+1]
                let distance = distance(a,b)
                let midpoint = mix(sampleSequence[i],sampleSequence[i+1],t: 0.5)
                let midpointCost = cost(midpoint)
                let segmentCost = midpointCost*distance 
                edgeCost += segmentCost 
            }
            integrals.append(edgeCost)
        }
    }

    private func computeMean() {
        meanIntegral = integrals.reduce(0, {
            x, y in x + y
        })
        meanIntegral /= Float(integrals.count)
        print("Mean integral is \(meanIntegral)") 
    }

    private func computeCorrections() {
        edgeCorrections = [] 
        for i in 0..<integrals.count {
            // let error = integrals[i] - meanIntegral
            let sizeChange = 1.0 / integrals[i]
            // let sizeChange = meanIntegral / integrals[i]
            edgeCorrections.append(sizeChange) 
        }
    }

    private func evaluateCorrections() {
        let correction: Float = 0.95 

        // let fixed = [0,19,399,380,9,390]
        // let fixed = [0]

        for i in 0..<integrals.count {
            // if Double.random(in: 0.0..<1.0) > 0.85 {
            //     continue
            // }

            let ia = staticMesh?.topology.edges[i].from
            let ib = staticMesh?.topology.edges[i].to

            let a = staticMesh?.geometry[ia!]
            let b = staticMesh?.geometry[ib!]
            let midpoint = mix(a!,b!,t: 0.5)

            let dira = a! - midpoint
            let dirb = b! - midpoint

            let desireda = midpoint + edgeCorrections[i] * dira
            let desiredb = midpoint + edgeCorrections[i] * dirb

            let correctiona = desireda - a!
            let correctionb = desiredb - b!


            let dega = staticMesh?.topology.getAdjacentEdges(vertexIndex: ia!).count
            let degb = staticMesh?.topology.getAdjacentEdges(vertexIndex: ib!).count
            
            if !(fixedVertices.contains(ia!)) {
                staticMesh?.geometry[ia!] += correction * correctiona / Float(dega!)
            }
            if !(fixedVertices.contains(ib!)) {
                staticMesh?.geometry[ib!] += correction * correctionb / Float(degb!)
            }
        }
    }



}
