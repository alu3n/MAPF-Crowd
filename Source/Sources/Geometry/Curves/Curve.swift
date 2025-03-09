import simd

package protocol Curve {
    var domain: ClosedRange<Float> {get}
    func callAsFunction(_ value: Float) -> simd_float3
}

package extension Curve {
    func derivative(value: Float) -> simd_float3 {
        return simd_float3(0,0,0)
    }

    func direction(value: Float) -> simd_float3 {
        return simd_float3(0,0,0)
    }
}

