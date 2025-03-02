import Testing
import Topology

@Test func correctAssignment() {
    var matrix = Topology.SparseMatrix<Int>(nRows: 4,nColumns: 3)
    
    matrix.setAt(0, 0, value: 2)
    matrix.setAt(3, 1, value: 3)
    matrix.setAt(2, 2, value: 1)
    matrix.setAt(2, 2, value: 2)

    let val0 = matrix.getAt(0, 0) ?? -1000
    let val1 = matrix.getAt(3, 1) ?? -1000
    let val2 = matrix.getAt(2, 2) ?? -1000
    let val3 = matrix.getAt(2, 0) ?? -1000

    #expect(val0 == 2)
    #expect(val1 == 3)
    #expect(val2 == 2)
    #expect(val3 == -1000)
}

@Test func correctNonEmptyRows() {
    var matrix = Topology.SparseMatrix<Int>(nRows: 4,nColumns: 4)

    matrix.setAt(0, 0, value: 0)
    matrix.setAt(1, 0, value: 1)
    matrix.setAt(2, 0, value: 2)
    matrix.setAt(0, 1, value: 3)
    matrix.setAt(2, 2, value: 4)
    matrix.setAt(3, 2, value: 5)
    matrix.setAt(0, 2, value: 6)
    matrix.setAt(1, 3, value: 7)

    var val0 = matrix.nonEmptyRows(columnIndex: 0)
    var val1 = matrix.nonEmptyRows(columnIndex: 1)
    var val2 = matrix.nonEmptyRows(columnIndex: 2)
    var val3 = matrix.nonEmptyRows(columnIndex: 3)    

    // Sorting because the DS does not guarantee specific order
    val0.sort()
    val1.sort()
    val2.sort()
    val3.sort()

    #expect(val0.count == 3)
    #expect(val1.count == 1)
    #expect(val2.count == 3)
    #expect(val3.count == 1)

    #expect(val0[0] == 0)
    #expect(val0[1] == 1)
    #expect(val0[2] == 2)
    #expect(val1[0] == 0)
    #expect(val2[0] == 0)
    #expect(val2[1] == 2)
    #expect(val2[2] == 3)
    #expect(val3[0] == 1)



}

@Test func correctTranspose() {
    var matrix = Topology.SparseMatrix<Int>(nRows: 5,nColumns: 4)

    matrix.setAt(0, 0, value: 0)
    matrix.setAt(1, 0, value: 1)
    matrix.setAt(2, 0, value: 2)
    matrix.setAt(0, 1, value: 3)
    matrix.setAt(2, 2, value: 4)
    matrix.setAt(3, 2, value: 5)
    matrix.setAt(0, 2, value: 6)
    matrix.setAt(1, 3, value: 7)

    let transposed = matrix.transpose()
    
    // Values transposed correctly?
    #expect(transposed.getAt(0,0) == 0)
    #expect(transposed.getAt(0,1) == 1)
    #expect(transposed.getAt(0,2) == 2)
    #expect(transposed.getAt(1,0) == 3)
    #expect(transposed.getAt(2,2) == 4)
    #expect(transposed.getAt(2,3) == 5)
    #expect(transposed.getAt(2,0) == 6)
    #expect(transposed.getAt(3,1) == 7)

    // Empty values transposed correctly?
    #expect(transposed.getAt(0,3) == nil)
    #expect(transposed.getAt(0,4) == nil)
    #expect(transposed.getAt(1,1) == nil)
    #expect(transposed.getAt(1,2) == nil)
    #expect(transposed.getAt(1,3) == nil)
    #expect(transposed.getAt(1,4) == nil)
    #expect(transposed.getAt(2,1) == nil)
    #expect(transposed.getAt(2,4) == nil)
    #expect(transposed.getAt(3,0) == nil)
    #expect(transposed.getAt(3,2) == nil)
    #expect(transposed.getAt(3,3) == nil)
    #expect(transposed.getAt(3,4) == nil)
}
