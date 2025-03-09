import simd

package struct PolygonalChain : Curve {
    package var domain: ClosedRange<Float>
    package let vertices: [simd_float3]

    package init(vertices: [simd_float3]) {
        self.vertices = vertices
        self.domain = 0.0...1.0
    }

    package func callAsFunction(_ value: Float) -> simd_float3 {
        assert(domain.contains(value), "You cannot evaluate outside the defined interval")
        let transformedDomain = value * Float(vertices.count)
        
        let fromVertexFloat = floor(transformedDomain)
        let toVertexFloat = ceil(transformedDomain)
        
        assert(fromVertexFloat == toVertexFloat)

        let t = transformedDomain - fromVertexFloat
        
        let fromPosition = vertices[Int(fromVertexFloat)]
        let toPosition = vertices[Int(toVertexFloat)]

        return t * fromPosition + (1 - t) * toPosition
    }
}
