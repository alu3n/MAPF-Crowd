import simd

package protocol HeightMap {
    var seed: Int {get}
    func height(coordinates: SIMD2<Float>) -> Float
}

package extension HeightMap {
    func gradient(coordinates: SIMD2<Float>) {
        print("TODO: Not implemented yet")
    }

    func surfaceNormal(coordinates: SIMD2<Float>) {
        print("TODO: Not implemented yet")
    }
}
