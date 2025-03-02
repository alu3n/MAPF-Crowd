// Todo: Add orientation integrity checks!

package struct AbstractSimplicial2Complex {
    let nVertices: Int
    let nEdges: Int
    let nTriangles: Int

    let vertexEdgeAdjacency: SparseMatrix<Int>
    let edgeVertexAdjacency: SparseMatrix<Int>
    let edgeTriangleAdjacency: SparseMatrix<Int>
    let triangleEdgeAdjacency: SparseMatrix<Int>
    


    init(nVertices: Int, edges: [Edge], triangles: [Triangle]) {
        assert(nVertices > 0, "There must be at least one vertex")
       
        self.nVertices = nVertices
        nEdges = edges.count
        nTriangles = triangles.count
        
        vertexEdgeAdjacency = AbstractSimplicial2Complex.getVertexEdgeAdjacency(nVertices: nVertices, edges: edges)
        edgeVertexAdjacency = vertexEdgeAdjacency.transpose() 

        edgeTriangleAdjacency = AbstractSimplicial2Complex.getEdgeTriangleAdjacency(edges: edges, triangles: triangles)
        triangleEdgeAdjacency = edgeTriangleAdjacency.transpose()
    }

    private static func getVertexEdgeAdjacency(nVertices: Int, edges: [Edge]) -> SparseMatrix<Int> {
        var matrix = SparseMatrix<Int>(nRows: edges.count, nColumns: nVertices)
        
        for edgeIndex in 0..<edges.count {
            let fromIndex = edges[edgeIndex].from
            let toIndex = edges[edgeIndex].to
             
            assert(fromIndex < nVertices && toIndex < nVertices, "Edge uses undefined vertex") 
            
            matrix.setAt(edgeIndex, fromIndex, value: -1)
            matrix.setAt(edgeIndex, toIndex, value: 1)
        }

        return matrix
    }

    private static func getEdgeTriangleAdjacency(edges: [Edge], triangles: [Triangle]) -> SparseMatrix<Int> {

        var matrix = SparseMatrix<Int>(nRows: edges.count, nColumns: triangles.count)

        for triangleIndex in 0..<triangles.count {
            let triangle = triangles[triangleIndex]

            matrix.setAt(triangleIndex, triangle.edge0, value: triangle.flip0 ? -1 : 1)
            matrix.setAt(triangleIndex, triangle.edge1, value: triangle.flip1 ? -1 : 1)
            matrix.setAt(triangleIndex, triangle.edge2, value: triangle.flip2 ? -1 : 1)
        }

        return matrix
    }


}

