// Todo: Add orientation integrity checks!

package struct AbstractSimplicial2Complex {
    let nVertices: Int
    let edges: [Edge]
    let triangles: [Triangle]

    let vertexEdgeAdjacency: SparseMatrix<Int>
    let edgeVertexAdjacency: SparseMatrix<Int>
    let edgeTriangleAdjacency: SparseMatrix<Int>
    let triangleEdgeAdjacency: SparseMatrix<Int>

    package init(nVertices: Int, edges: [Edge], triangles: [Triangle]) {
        assert(nVertices > 0, "There must be at least one vertex")
       
        self.nVertices = nVertices
        self.edges = edges
        self.triangles = triangles

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
            
            matrix.setAt(edgeIndex, fromIndex, value: 1)
            matrix.setAt(edgeIndex, toIndex, value: 1)
        }

        return matrix
    }

    private static func getEdgeTriangleAdjacency(edges: [Edge], triangles: [Triangle]) -> SparseMatrix<Int> {

        var matrix = SparseMatrix<Int>(nRows: triangles.count, nColumns: edges.count)

        for triangleIndex in 0..<triangles.count {
            let triangle = triangles[triangleIndex]
            
            let edge0 = triangle.edge0
            let edge1 = triangle.edge1
            let edge2 = triangle.edge2

            assert(edge0 >= 0 && edge0 < edges.count)
            assert(edge1 >= 0 && edge1 < edges.count)
            assert(edge2 >= 0 && edge2 < edges.count)

            matrix.setAt(triangleIndex, edge0, value: 1)
            matrix.setAt(triangleIndex, edge1, value: 1)
            matrix.setAt(triangleIndex, edge2, value: 1)
        }

        return matrix
    }

    package func getAdjacentEdges(vertexIndex: Int) -> [Edge] {
        let connectedRowIndicies = vertexEdgeAdjacency.nonEmptyRows(columnIndex: vertexIndex)       
        
        return connectedRowIndicies
            .map{
                edges[$0]         
            }
    }

    package func getIncommingEdges(vertexIndex: Int) -> [Edge] {
        let connectedRowIndicies = vertexEdgeAdjacency.nonEmptyRows(columnIndex: vertexIndex)       
        
        return connectedRowIndicies
            .map{
                edges[$0]         
            }
            .filter{
                $0.to == vertexIndex
            }
    }

    package func getOutgoingEdges(vertexIndex: Int) -> [Edge] {
        let connectedRowIndicies = vertexEdgeAdjacency.nonEmptyRows(columnIndex: vertexIndex)       
        
        return connectedRowIndicies
            .map{
                edges[$0]         
            }
            .filter{
                $0.from == vertexIndex
            }
    }


    package func getAdjacentTriangles(edgeIndex: Int) -> [Triangle] {
        let connectedTriangles = edgeTriangleAdjacency.nonEmptyRows(columnIndex: edgeIndex)
        
        return connectedTriangles
            .map{
                triangles[$0]
            }
    }














}

