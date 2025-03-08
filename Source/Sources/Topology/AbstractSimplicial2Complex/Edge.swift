package struct Edge : Equatable, Hashable, Encodable {
    package let from: Int
    package let to: Int

    package init(_ from: Int, _ to: Int) {
        assert(from >= 0 && to >= 0, "Vertices indices must be non-negative integers")   

        self.from = from
        self.to = to
    }
}
