import simd

package class FlatMap : HeightMap {
    package let inputScale: simd_float2 = simd_float2(0,0)
    package let outputScale: Float = 0
    package let origin: simd_float2 = simd_float2(0,0)

    package init() {}

    package func transform(_ coordinates: SIMD2<Float>) -> Float {
        return 0
    }

}
