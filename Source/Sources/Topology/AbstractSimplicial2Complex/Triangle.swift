// Positive edge index i means edge as is defined in the edge matrix
// Negative edge index i means reversed edge abs(i)

/**
Triangle serves as intermediate DS during the creation of AbstractSimplicial2Complex

Edge flips are represented explicitly to avoid ambiguity of 0 indexed edge when using sign to represent orientation.

*/

package struct Triangle : Equatable, Hashable, Encodable {
    package let edge0: Int
    package let edge1: Int
    package let edge2: Int

    let flip0: Bool
    let flip1: Bool
    let flip2: Bool

    package init(_ edge0: Int, _ edge1: Int, _ edge2: Int) {
        self.edge0 = edge0
        self.edge1 = edge1
        self.edge2 = edge2

        flip0 = false
        flip1 = false
        flip2 = false
    }

    package init(_ edge0: Int, _ edge1: Int, _ edge2: Int, _ flip0: Bool, _ flip1: Bool, _ flip2: Bool) {
        self.edge0 = edge0
        self.edge1 = edge1
        self.edge2 = edge2

        self.flip0 = flip0 
        self.flip1 = flip1
        self.flip2 = flip2
    }

}
