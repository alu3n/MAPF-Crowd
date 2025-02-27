//
//  main.swift
//  MAPF-Crowd
//
//  Created by Vojtěch Pröschl on 22.02.2025.
//

import Topology

var matrix = Topology.SparseMatrix<Int>(nRows: 4,nColumns: 3)

print("First one")
matrix.setAt(rowIndex: 0,columnIndex: 0,value: 2)
print("Second one")
matrix.setAt(rowIndex: 3,columnIndex: 1,value: 3)
print("Third one")
matrix.setAt(rowIndex: 2,columnIndex: 2,value: 1)
print("Fourth one")
matrix.setAt(rowIndex: 2,columnIndex: 2,value: 2)

let val0 = matrix.getAt(rowIndex: 0, columnIndex: 0) ?? -1000
let val1 = matrix.getAt(rowIndex: 3, columnIndex: 1) ?? -1000
let val2 = matrix.getAt(rowIndex: 2, columnIndex: 2) ?? -1000
let val3 = matrix.getAt(rowIndex: 2, columnIndex: 0) ?? -1000

assert(val0 == 2)
assert(val1 == 3)
assert(val2 == 2)
assert(val3 == -1000)

