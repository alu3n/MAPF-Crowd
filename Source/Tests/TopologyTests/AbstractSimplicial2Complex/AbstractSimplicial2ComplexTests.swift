import Testing
import Topology

@Test func singleTriangle() {
    let nVertices = 3
    let edge0 = Topology.Edge(0,1)
    let edge1 = Topology.Edge(1,2)
    let edge2 = Topology.Edge(2,0)
    let triangle = Topology.Triangle(0,1,2)

    let as2c = Topology.AbstractSimplicial2Complex(nVertices: nVertices, edges: [edge0, edge1, edge2], triangles: [triangle])

    let adjTo0 = Set(as2c.getAdjacentEdges(vertexIndex: 0))
    let adjTo1 = Set(as2c.getAdjacentEdges(vertexIndex: 1))
    let adjTo2 = Set(as2c.getAdjacentEdges(vertexIndex: 2))

    let incommingTo0 = Set(as2c.getIncommingEdges(vertexIndex: 0))
    let incommingTo1 = Set(as2c.getIncommingEdges(vertexIndex: 1))
    let incommingTo2 = Set(as2c.getIncommingEdges(vertexIndex: 2))
    
    let outgoingFrom0 = Set(as2c.getOutgoingEdges(vertexIndex: 0))
    let outgoingFrom1 = Set(as2c.getOutgoingEdges(vertexIndex: 1))
    let outgoingFrom2 = Set(as2c.getOutgoingEdges(vertexIndex: 2))

    #expect(adjTo0 == Set([edge0,edge2]))
    #expect(adjTo1 == Set([edge0,edge1]))
    #expect(adjTo2 == Set([edge1,edge2]))

    #expect(incommingTo0 == Set([edge2]))
    #expect(incommingTo1 == Set([edge0]))
    #expect(incommingTo2 == Set([edge1]))

    #expect(outgoingFrom0 == Set([edge0]))
    #expect(outgoingFrom1 == Set([edge1]))
    #expect(outgoingFrom2 == Set([edge2]))
}
