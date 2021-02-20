'''Detect Cycle in a directed graph using DFS'''

from collections import defaultdict

class Graph:
    def __init__(self,V):
        self.graph = defaultdict(list)
        self.V = V
    def addEdge(self,src,dest):
        self.graph[src].append(dest)

    def cycleUtil(self,node,visited,recStack):

        visited[node] = True
        recStack[node] = True

        for x in self.graph[node]:
            if visited[x] == False:
                if self.cycleUtil(x,visited,recStack) == True:
                    return True
            elif recStack[x] == True:
                return True
        recStack[node] = False
        return False

    def isCyclic(self):

        visited = [False]*self.V
        recStack = [False]*self.V  # created a recurssion stack

        for i in range(self.V):
            if visited[i] == False:
                if self.cycleUtil(i,visited,recStack) == True:
                    return True
        return False

g = Graph(4)
g.addEdge(0, 1)
g.addEdge(0, 2)
g.addEdge(1, 2)
g.addEdge(2, 0)
g.addEdge(2, 3)
g.addEdge(3, 3)
if g.isCyclic() == 1:
    print("Graph has a cycle")
else:
    print("Graph has no cycle")



'''Detect Cycle in a directed graph using BFS'''

