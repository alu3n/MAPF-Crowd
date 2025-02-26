// Representation of Sparse SparseMatrix

fileprivate struct Position : Hashable {
    let rowIndex: UInt
    let columnIndex: UInt
}

package struct SparseMatrix<ElementType>{
    let nColumns: UInt
    let nRows: UInt
    
    fileprivate var contents: Dictionary<Position,ElementType> = [:]
    
    package init(nRows: UInt, nColumns: UInt) {
        self.nRows = nRows
        self.nColumns = nColumns
    }

    package mutating func setAt(rowIndex: UInt, columnIndex: UInt, value: ElementType) {
        contents[Position(rowIndex: rowIndex, columnIndex: columnIndex)] = value
    }

    package func getAt(rowIndex: UInt, columnIndex: UInt) -> ElementType? {
        return contents[Position(rowIndex: rowIndex, columnIndex: columnIndex)]
    }
}
