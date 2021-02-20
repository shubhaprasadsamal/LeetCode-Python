'''For every visited vertex ‘v’, if there is an adjacent ‘u’ such that u is already visited and u is not parent of v, then there is a cycle in graph

It's a DFS Style'''

from collections import defaultdict

class Graph:
    def __init__(self,V):
        self.V = V
        self.graph = defaultdict(list)

    def addEdge(self,src,dest):
        self.graph[src].append(dest)

    def isCyclicUtility(self,node,visited,parent):
        visited[node] = True
        for x in self.graph[node]:
            if visited[x] == False:
                if self.isCyclicUtility(x,visited,node):
                    return True
            elif parent != x:
                return True
            return False

    def isCyclic(self):
        visited = [False]*self.V

        for i in range(self.V):
            if visited[i] == False:
                if self.isCyclicUtility(i,visited,-1):
                    return True
        return False

g = Graph(5)
g.addEdge(1, 0)
g.addEdge(0, 2)
g.addEdge(2, 0)
g.addEdge(0, 3)
g.addEdge(3, 4)

if g.isCyclic():
    print("Graph contains cycle")
else :
    print("Graph does not contain cycle ")
g1 = Graph(3)
g1.addEdge(0,1)
g1.addEdge(1,2)


if g1.isCyclic():
    print("Graph contains cycle")
else :
    print("Graph does not contain cycle ")

'''Detect Cycle in a directed graph using BFS'''