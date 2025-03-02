package struct Edge : Equatable, Hashable {
    let from: Int
    let to: Int

    package init(_ from: Int, _ to: Int) {
        assert(from >= 0 && to >= 0, "Vertices indices must be non-negative integers")   

        self.from = from
        self.to = to
    }
}
