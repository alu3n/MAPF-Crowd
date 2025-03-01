
struct AdjacencyMatrix {
    let nVertices: Int
    let nEdges: Int
    let nFaces: Int

    var edgeTopology: [SparseMatrix<Int>]
    var faceTopology: [SparseMatrix<Int>]
}

