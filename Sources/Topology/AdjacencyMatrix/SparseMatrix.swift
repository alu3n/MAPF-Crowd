// Representation of Sparse SparseMatrix
// This DataStructure uses the compressed column format
// Source: http://15462.courses.cs.cmu.edu/fall2021/
// cummulativeColumnEntries[k] specifies the total number of entries in the columns {0,...,k}

// Undefined entries are returned as "undefined" optional, not "zero" values 


package struct SparseMatrix<ElementType> {
    let nRows: Int
    let nColumns: Int
    
    var values: [ElementType] = []
    var rowIndices: [Int] = []
    var cummulativeColumnEntries: [Int]
    
    package init(nRows: Int, nColumns: Int) {
        self.nRows = nRows
        self.nColumns = nColumns
        self.cummulativeColumnEntries = Array(repeating: 0, count: nColumns)
    }

    package func getAt(rowIndex: Int, columnIndex: Int) -> ElementType? {
        assert(rowIndex >= 0 && rowIndex < nRows, "Row index \(rowIndex) outside the [0,\(nRows)) interval") 
        assert(columnIndex >= 0 && columnIndex < nColumns, "Column index \(columnIndex) outside the [0,\(nColumns)) interval")

        if let index = getIndex(rowIndex: rowIndex, columnIndex: columnIndex) {
            return values[index]
        }
        else {
            return nil
        }
    }
    
    private func getIndex(rowIndex: Int, columnIndex: Int) -> Int? {
        let first = columnIndex == 0 ? 0 : cummulativeColumnEntries[columnIndex-1]
        let last = cummulativeColumnEntries[columnIndex]
        
        for i in first..<last {
            if rowIndices[i] == rowIndex {
                return i 
            }
        }

        return nil
    }

    package mutating func setAt(rowIndex: Int, columnIndex: Int, value: ElementType) {
        assert(rowIndex >= 0 && rowIndex < nRows, "Row index \(rowIndex) outside the [0,\(nRows)) interval") 
        assert(columnIndex >= 0 && columnIndex < nColumns, "Column index \(columnIndex) outside the [0,\(nColumns)) interval")
        
        if let index = getIndex(rowIndex: rowIndex, columnIndex: columnIndex) {
            values[index] = value 
        }
        else {
            let newIndex = insertionIndex(rowIndex: rowIndex, columnIndex: columnIndex)         
            values.insert(value, at: newIndex)
            rowIndices.insert(rowIndex, at: newIndex)

            for i in columnIndex..<nColumns {
                cummulativeColumnEntries[i] += 1
            }
        }

    }

    func insertionIndex(rowIndex: Int, columnIndex: Int) -> Int {
        let first = columnIndex == 0 ? 0 : cummulativeColumnEntries[columnIndex-1]
        let last = cummulativeColumnEntries[columnIndex]
        
        var index = cummulativeColumnEntries[columnIndex]

        if first == last {
            return index
        }
        else {
            for _ in first..<last {
                if rowIndex > rowIndices[index] {
                    index += 1
                }
                else{
                    break
                }
            }
            return index
        }
    }
    
}

