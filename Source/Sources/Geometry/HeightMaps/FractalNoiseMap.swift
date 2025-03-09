import simd

// TODO: Swift hasher is not based on user defineable seed, change it for an alternative in the future in order to make terrain persistent over different runtimes
// TODO: Use fractal gradient noise

package class FractalNoiseMap : HeightMap {
    package let seed: Int
    let octaves: [Int]
    let roughness: Float
    let lacunarity: Float
    let frequencies: [Float]
    package let inputScale: simd_float2
    package let outputScale: Float
    package let origin: simd_float2
    private var hashers: [Hasher]

    package init(octaves: Int, roughness: Float, lacunarity: Float, seed: Int, inputScale: simd_float2, outputScale: Float, origin: simd_float2) {
        self.octaves = Array(0..<octaves) 
        self.roughness = roughness
        self.lacunarity = lacunarity
        self.frequencies = self.octaves
            .map{ o in 
                pow(lacunarity,Float(o))    
            }
        self.seed = seed
        self.hashers = (0..<octaves)
            .map{ _ in
                Hasher()
            }
        self.inputScale = inputScale
        self.outputScale = outputScale
        self.origin = origin
    }

    package func transform(_ coordinates: SIMD2<Float>) -> Float {
        var value: Float = 0

        for o in octaves {
            value += pow(roughness,Float(o)) * evaluateOctave(coordinates: coordinates, octave: o)
        }

        return value*outputScale
    }

    private func evaluateOctave(coordinates: SIMD2<Float>, octave: Int) -> Float {
        let transformedCoordinates = frequencies[octave] * coordinates * inputScale
        let bottomLeftFloat = floor(transformedCoordinates)
        let topRightFloat = ceil(transformedCoordinates)
        let bottomLeft = SIMD2<Int>(bottomLeftFloat)
        let topRight = SIMD2<Int>(topRightFloat)
        let bottomRight = SIMD2<Int>(topRight.x,bottomLeft.y)
        let topLeft = SIMD2<Int>(bottomLeft.x,topRight.y)
        let tx = (topRightFloat.x - transformedCoordinates.x)
        let ty = (topRightFloat.y - transformedCoordinates.y)

        let bottomLeftValue = uniformSample(seed: bottomLeft, octave: octave)
        let topRightValue = uniformSample(seed: topRight, octave: octave)
        let bottomRightValue = uniformSample(seed: bottomRight, octave: octave)
        let topLeftValue = uniformSample(seed: topLeft, octave: octave)
        
        let vtop = topLeftValue * tx + topRightValue * (1 - tx)
        let vbottom = bottomLeftValue * tx + bottomRightValue * (1 - tx)

        return vbottom * ty + vtop * (1 - ty) 
    }

    private func uniformSample(seed: SIMD2<Int>, octave: Int) -> Float {
        var hasher = Hasher()
        hasher.combine(seed)
        hasher.combine(octave)
        return Float(hasher.finalize()) / Float(Int.max)
    }


}
