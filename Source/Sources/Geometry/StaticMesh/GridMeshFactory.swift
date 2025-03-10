import Topology
import simd

package enum StaticMeshFactory{
    package static func unitGrid(nRows: Int, nColumns: Int) -> StaticMesh {
        let vertexIndices: [Int] = Array(0..<(nRows*nColumns))
        let integerCoordinates = vertexIndices.map{
            unravelGridCoordinates(index: $0, rows: nRows, columns: nColumns)
        }
        let floatCoordinates = integerCoordinates.map(integerToFloatCoordinates)
        let edges = integerCoordinates
            .flatMap{
                outgoingEdges($0.0,$0.1,nRows,nColumns)
            }

        let triangles: [Triangle] = []
        // Todo: Add triangles
        let as2c = AbstractSimplicial2Complex(nVertices: vertexIndices.count, edges: edges, triangles: triangles)
        return StaticMesh(topology: as2c, geometry: floatCoordinates) 
    }

    private static func unravelGridCoordinates(index: Int, rows: Int, columns: Int) -> (Int,Int) {
        assert(index >= 0 && rows * columns > index, "Cannot unravel coordinate outside the defined range")  
        let row = index / columns
        let col = index - (row * columns)
        return (row,col)
    }

    private static func flattenCoordinates(_ row: Int, _ column: Int, _ nRows: Int, _ nColumns: Int) -> Int {
        assert(row >= 0 && row < nRows && column >= 0 && column < nColumns, "Cannot flatten outside the defined range")
        return column + row * nColumns 
    }

    private static func integerToFloatCoordinates(_ x: Int, _ y: Int) -> simd_float3 {
        simd_float3(Float(x),Float(y),0)
    }

    private static func outgoingEdges(_ row: Int, _ column: Int, _ nRows: Int, _ nColumns: Int) -> [Topology.Edge] {
        var outgoing: [Edge] = []
        let from = flattenCoordinates(row,column,nRows,nColumns)
        if (row < nRows - 1) {
            let to = flattenCoordinates(row + 1, column, nRows, nColumns)
            outgoing.append(Edge(from, to)) 
        }
        if (column < nColumns - 1) {
            let to = flattenCoordinates(row, column + 1, nRows, nColumns)
            outgoing.append(Edge(from, to))
        }
        if (row < nRows - 1 && column < nColumns - 1) {
            let to = flattenCoordinates(row + 1, column + 1, nRows, nColumns)
            outgoing.append(Edge(from, to))
        }

        return outgoing
    }
}
