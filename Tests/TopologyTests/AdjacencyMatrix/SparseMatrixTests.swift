import Testing
import Topology

@Test func correctAssignment() {
    var matrix = Topology.SparseMatrix<Int>(nRows: 4,nColumns: 3)
    
    matrix.setAt(rowIndex: 0,columnIndex: 0,value: 2)
    matrix.setAt(rowIndex: 3,columnIndex: 1,value: 3)
    matrix.setAt(rowIndex: 2,columnIndex: 2,value: 1)
    matrix.setAt(rowIndex: 2,columnIndex: 2,value: 2)

    let val0 = matrix.getAt(rowIndex: 0, columnIndex: 0) ?? -1000
    let val1 = matrix.getAt(rowIndex: 3, columnIndex: 1) ?? -1000
    let val2 = matrix.getAt(rowIndex: 2, columnIndex: 2) ?? -1000
    let val3 = matrix.getAt(rowIndex: 2, columnIndex: 0) ?? -1000

    #expect(val0 == 2)
    #expect(val1 == 3)
    #expect(val2 == 2)
    #expect(val3 == -1000)
}
