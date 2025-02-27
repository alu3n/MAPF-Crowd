
struct AdjacencyMatrix<VertexPayload, EdgePayload, FacePayload> {
    let nVertices: Int
    let nEdges: Int
    let nFaces: Int

    var vertices: [VertexPayload?]
    var edges: [EdgePayload?]
    var faces: [FacePayload?]
}
