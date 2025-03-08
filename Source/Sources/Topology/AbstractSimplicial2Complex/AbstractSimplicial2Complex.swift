// Todo: Add orientation integrity checks!

package struct AbstractSimplicial2Complex {
    package let vertices: [Int]
    package let edges: [Edge]
    package let triangles: [Triangle]

    let vertexEdgeAdjacency: SparseMatrix<Int>
    let edgeVertexAdjacency: SparseMatrix<Int>
    let edgeTriangleAdjacency: SparseMatrix<Int>
    let triangleEdgeAdjacency: SparseMatrix<Int>

    package init(nVertices: Int, edges: [Edge], triangles: [Triangle]) {
        assert(nVertices > 0, "There must be at least one vertex")
       
        self.vertices = Array(0..<nVertices)
        self.edges = edges
        self.triangles = triangles

        let vertexEdgeAdjacencyList = AbstractSimplicial2Complex.getVertexEdgeAdjacency(nVertices: nVertices, edges: edges)
        let edgeTriangleAdjacencyList = AbstractSimplicial2Complex.getEdgeTriangleAdjacency(edges: edges, triangles: triangles)

        // This effectively transposes the matrix!
        let edgeVertexAdjacencyList = Dictionary(uniqueKeysWithValues:
            vertexEdgeAdjacencyList.keys
                .map{
                    (MatrixIndex(rowIndex: $0.columnIndex, columnIndex: $0.rowIndex), vertexEdgeAdjacencyList[$0]!)
                }
        )

        let triangleEdgeAdjacencyList = Dictionary(uniqueKeysWithValues:
            edgeTriangleAdjacencyList.keys
                .map{
                    (MatrixIndex(rowIndex: $0.columnIndex, columnIndex: $0.rowIndex), edgeTriangleAdjacencyList[$0]!)
                }
        )


        vertexEdgeAdjacency = SparseMatrix(nRows: edges.count, nColumns: vertices.count, indices: vertexEdgeAdjacencyList)
        edgeVertexAdjacency = SparseMatrix(nRows: vertices.count, nColumns: edges.count, indices: edgeVertexAdjacencyList)
        edgeTriangleAdjacency = SparseMatrix(nRows: triangles.count, nColumns: edges.count, indices: edgeTriangleAdjacencyList)
        triangleEdgeAdjacency = SparseMatrix(nRows: edges.count, nColumns: triangles.count, indices: triangleEdgeAdjacencyList)
    }

    private static func getVertexEdgeAdjacency(nVertices: Int, edges: [Edge]) -> [MatrixIndex:Int] {
        var nonZeroValues: [MatrixIndex:Int] = [:]

        for edgeIndex in 0..<edges.count {
            let fromIndex = edges[edgeIndex].from
            let toIndex = edges[edgeIndex].to
             
            assert(fromIndex < nVertices && toIndex < nVertices, "Edge uses undefined vertex") 
            
            nonZeroValues[MatrixIndex(rowIndex: edgeIndex, columnIndex: fromIndex)] = 1
            nonZeroValues[MatrixIndex(rowIndex: edgeIndex, columnIndex: toIndex)] = 1
        }

        return nonZeroValues
    }

    private static func getEdgeTriangleAdjacency(edges: [Edge], triangles: [Triangle]) -> [MatrixIndex:Int] {
        var nonZeroValues: [MatrixIndex:Int] = [:]

        for triangleIndex in 0..<triangles.count {
            let triangle = triangles[triangleIndex]
            
            let edge0 = triangle.edge0
            let edge1 = triangle.edge1
            let edge2 = triangle.edge2

            assert(edge0 >= 0 && edge0 < edges.count)
            assert(edge1 >= 0 && edge1 < edges.count)
            assert(edge2 >= 0 && edge2 < edges.count)

            nonZeroValues[MatrixIndex(rowIndex: triangleIndex, columnIndex: edge0)] = 1
            nonZeroValues[MatrixIndex(rowIndex: triangleIndex, columnIndex: edge1)] = 1
            nonZeroValues[MatrixIndex(rowIndex: triangleIndex, columnIndex: edge2)] = 1
        }

        return nonZeroValues
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

