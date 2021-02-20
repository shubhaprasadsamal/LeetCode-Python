"""representation of graph using Adjacency Matrix"""

class Graph:
    def __init__(self, numOfVertices):
        self.numOfVertices = numOfVertices
        self.adjMatrix = [[-1]*numOfVertices for i in range(numOfVertices)] # Created an Matrix which is 2-Dimensional array
        self.vertices = {}  # Created a dictionary
        self.vertices_List = [0]*numOfVertices  # Created an array

    def set_vertex(self,index,vertex):
        if 0 <= index <= self.numOfVertices:
            self.vertices[vertex] = index   # Map the kep value under the dictionary
            self.vertices_List[index] = vertex  # store the nodes in array with array indexes

    def set_edge(self,frm,to,cost=0):
        frm = self.vertices[frm]
        to = self.vertices[to]
        self.adjMatrix[frm][to] = cost
        self.adjMatrix[to][frm] = cost  # Don't include this if it's a Directional Graph

    def get_vertex(self):
        return self.vertices_List

    def get_edges(self):
        edges = []
        for i in range(self.numOfVertices):
            for j in range(self.numOfVertices):
                if (self.adjMatrix[i][j] != -1):
                    edges.append((self.vertices_List[i],self.vertices_List[j],self.adjMatrix[i][j]))    # 2 Brackets because append takes only one argument
        return edges

    def get_matrix(self):
        return self.adjMatrix

G =Graph(6)
G.set_vertex(0,'a')
G.set_vertex(1,'b')
G.set_vertex(2,'c')
G.set_vertex(3,'d')
G.set_vertex(4,'e')
G.set_vertex(5,'f')
G.set_edge('a','e',10)
G.set_edge('a','c',20)
G.set_edge('c','b',30)
G.set_edge('b','e',40)
G.set_edge('e','d',50)
G.set_edge('f','e',60)
print("Vertices of Graph")
print(G.get_vertex())
print("Edges of Graph")
print(G.get_edges())
print("Adjacency Matrix of Graph")
print(G.get_matrix())
