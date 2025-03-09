import Foundation
import Topology
import simd


package class StaticMesh : Encodable {
   package var geometry: [simd_float3]
   package let topology: AbstractSimplicial2Complex

   package init(topology: AbstractSimplicial2Complex, geometry: [simd_float3]){
        self.topology = topology
        self.geometry = geometry

        assert(topology.vertices.count == geometry.count, "Geometric array must exactly match the number of vertices in topological DS")
    }
    package func encode(to encoder: any Encoder) throws {
        let vertices = Array(0..<geometry.count)
        let edges = vertices
            .flatMap{
                topology.getAdjacentEdges(vertexIndex: $0)
            }
        
        var container = encoder.container(keyedBy: Keys.self)

        try container.encode(geometry, forKey: .coordinates)
        try container.encode(vertices, forKey: .vertices)
        try container.encode(edges, forKey: .edges)
    }

    package enum Keys: CodingKey {
        case coordinates
        case vertices
        case edges
        case faces 
    }
}
