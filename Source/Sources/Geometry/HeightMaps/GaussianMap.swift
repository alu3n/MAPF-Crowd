import simd

package class GaussianMap : HeightMap {
    package let inputScale: simd_float2
    package let outputScale: Float
    package let origin: simd_float2

    package init(inputScale: simd_float2, outputScale: Float, origin: simd_float2) {
        self.inputScale = inputScale
        self.outputScale = outputScale
        self.origin = origin
    }

    package func transform(_ coordinates: SIMD2<Float>) -> Float {
        let x = (coordinates.x)
        let y = (coordinates.y)
        return expf(-x*x)*expf(-y*y)
    }

}
