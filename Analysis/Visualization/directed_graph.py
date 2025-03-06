import networkx as nx
import matplotlib.pyplot as plt

def drawDirectedGraph(description):
    positions = {i:(description["coordinates"][i][0],description["coordinates"][i][2]) for i in range(len(description["coordinates"]))}
    vertices = positions.keys()

    edges = [(edge["from"],edge["to"]) for edge in description["edges"]]
    
    G = nx.DiGraph()
    G.add_nodes_from(vertices)
    G.add_edges_from(edges)
   

    plt.figure()
    nx.draw(G, pos=positions, with_labels=True, node_color='lightblue', edge_color='gray', arrows=True)
    plt.show()
