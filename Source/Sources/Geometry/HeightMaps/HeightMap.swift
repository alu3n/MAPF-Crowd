import simd

package protocol HeightMap {
    var inputScale: simd_float2 {get}
    var outputScale: Float {get}
    var origin: simd_float2 {get}
    func transform(_ coordinates: SIMD2<Float>) -> Float
}

package extension HeightMap {
    func callAsFunction(_ coordinates: SIMD2<Float>) -> Float {
        let x = coordinates.x - origin.x
        let y = coordinates.y - origin.y
        return transform(simd_float2(x*inputScale.x,y*inputScale.y)) * outputScale
    }

    func gradient(coordinates: SIMD2<Float>) {
        assert(1 == 0, "Not implemented yet")
    }

    func surfaceNormal(coordinates: SIMD2<Float>) {
        assert(1 == 0, "Not implemented yet")
    }
}
