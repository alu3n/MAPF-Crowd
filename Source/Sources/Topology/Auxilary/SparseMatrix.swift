/**
DataStructured intended to store sparse matrices
- this implementation uses the compressed column format
- implementation idea based on lecture 10 (meshes an d manifolds) from http://15462.courses.cs.cmu.edu/fall2021/

Undefined entries are returned as "undefined" optional, not "zero" values 

Time complexities
- Initialization O(nColumns)
- Accessing value O(maxNonZeroEntriesInAColumn)
- Changing value O(nColumns)
- Accessing list of non zero indices of a given column O(maxNonZeroEntriesInAColumn)
- Accessing list of non zero indices of a given row:
    - Would be O(numberOfNonZeroEntries)
    - Is not implemented at the moment

*/
package struct SparseMatrix<ElementType> {
    let nRows: Int
    let nColumns: Int
    
    var values: [ElementType?] = []
    var rowIndices: [Int] = []
    var cummulativeColumnEntries: [Int]
    // cummulativeColumnEntries[k] specifies the total number of entries in the columns {0,...,k}


    package init(nRows: Int, nColumns: Int) {
        self.nRows = nRows
        self.nColumns = nColumns
        self.cummulativeColumnEntries = Array(repeating: 0, count: nColumns)
    }

    package func getAt(_ rowIndex: Int, _ columnIndex: Int) -> ElementType? {
        assert(rowIndex >= 0 && rowIndex < nRows, "Row index \(rowIndex) outside the [0,\(nRows)) interval") 
        assert(columnIndex >= 0 && columnIndex < nColumns, "Column index \(columnIndex) outside the [0,\(nColumns)) interval")

        if let index = getIndex(rowIndex, columnIndex) {
            return values[index]
        }
        else {
            return nil
        }
    }
    
    private func getIndex(_ rowIndex: Int, _ columnIndex: Int) -> Int? {
        let first = columnIndex == 0 ? 0 : cummulativeColumnEntries[columnIndex-1]
        let last = cummulativeColumnEntries[columnIndex]
        
        for i in first..<last {
            if rowIndices[i] == rowIndex {
                return i 
            }
        }

        return nil
    }

    package mutating func setAt(_ rowIndex: Int, _ columnIndex: Int, value: ElementType?) {
        assert(rowIndex >= 0 && rowIndex < nRows, "Row index \(rowIndex) outside the [0,\(nRows)) interval") 
        assert(columnIndex >= 0 && columnIndex < nColumns, "Column index \(columnIndex) outside the [0,\(nColumns)) interval")
        
        if let index = getIndex(rowIndex, columnIndex) {
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

    private func insertionIndex(rowIndex: Int, columnIndex: Int) -> Int {
        let first = columnIndex == 0 ? 0 : cummulativeColumnEntries[columnIndex-1]
        let last = cummulativeColumnEntries[columnIndex]
        
        var index = first 

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

    package func nonEmptyRows(columnIndex: Int) -> [Int] {
        assert(columnIndex >= 0 && columnIndex < nColumns, "Column index \(columnIndex) outside the [0,\(nColumns)) interval")
        
        let first = columnIndex == 0 ? 0 : cummulativeColumnEntries[columnIndex-1]
        let last = cummulativeColumnEntries[columnIndex]
        
        return Array(rowIndices[first..<last])
    }

    package func transpose() -> SparseMatrix<ElementType> {
        var matrix = SparseMatrix<ElementType>(nRows: self.nColumns, nColumns: self.nRows) 

        for columnIndex in 0..<self.nColumns {
            for rowIndex in nonEmptyRows(columnIndex: columnIndex) {
                let value = self.getAt(rowIndex, columnIndex)
                matrix.setAt(columnIndex, rowIndex, value: value)
            }
        }

        return matrix
   }


}

