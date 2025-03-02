//
//  DoublyConnectedEdgeList.swift
//  MAPF-Crowd
//
//  Created by Vojtěch Pröschl on 23.02.2025.
//

package class DoublyConnectedEdgeList<VertexPayload,EdgePayload,FacePayload>{
    var halfEdges: Set<Halfedge> = []
    
    var vertexPayloads: Dictionary<Halfedge,VertexPayload?> = [:]
    var edgePayloads: Dictionary<Halfedge,EdgePayload?> = [:]
    var facePayloads: Dictionary<Halfedge,FacePayload?> = [:]

    func TraverseMesh(){
        //TODO: Implement this method
    }
}
