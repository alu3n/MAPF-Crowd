// Todo: Add orientation integrity checks!

package struct AbstractSimplicial2Complex {
    let nVertices: Int
    let nEdges: Int
    let nFaces: Int

    let vertexEdgeAdjacency: SparseMatrix<Int>
    let edgeVertexAdjacency: SparseMatrix<Int>
    let edgeFaceAdjacency: SparseMatrix<Int>
    let faceEdgeAdjacency: SparseMatrix<Int>

    init(nVertices: Int, edges: [Edge], faces: [Face]) {
        assert(nVertices > 0, "There must be at least one vertex")
       
        self.nVertices = nVertices
        nEdges = edges.count
        nFaces = faces.count
        
    }

    private func getVertexEdgeAdjacency(nVertices: Int, edges: [Edge]) -> SparseMatrix<Int> {
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

    private func getEdgeFaceAdjacency(edges: [Edge], faces: [Face]) -> SparseMatrix<Int> {

        var matrix = SparseMatrix<Int>(nRows: edges.count, nColumns: faces.count)

        for faceIndex in 0..<faces.count {
            
        }
    }


}

