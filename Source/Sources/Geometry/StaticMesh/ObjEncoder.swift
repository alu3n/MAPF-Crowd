

package enum ObjEncoder {
    package static func encode(mesh: StaticMesh) -> String {
        var obj = ""
        
        for i in mesh.geometry {
            obj += "v \(i.x) \(i.y) \(i.z)\n"
        }

        for e in mesh.topology.edges {
            obj += "l \(e.from + 1) \(e.to + 1)\n"
        }

        return obj
    }
}
