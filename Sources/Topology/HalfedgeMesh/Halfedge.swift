//
//  HalfEdge.swift
//  MAPF-Crowd
//
//  Created by Vojtěch Pröschl on 22.02.2025.
//

package class Halfedge : Hashable {
    var next: Halfedge?
    var twin: Halfedge?

    init() {

    }

    init(twin: Halfedge, next: Halfedge){
        self.twin = twin
        self.next = next
    }

    package static func == (lhs: Halfedge, rhs: Halfedge) -> Bool {
        return lhs === rhs
    }
    
    package func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
}
