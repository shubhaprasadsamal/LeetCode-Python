"""Breadth First Traversal (or Search) for a graph is similar to Breadth First Traversal of a tree (See method 2 of this post).
The only catch here is, unlike trees, graphs may contain cycles, so we may come to the same node again. To avoid processing a node more than once,
we use a boolean visited array. For simplicity, it is assumed that all vertices are reachable from the starting vertex.
For example, in the following graph, we start traversal from vertex 2. When we come to vertex 0, we look for all adjacent vertices of it.
2 is also an adjacent vertex of 0. If we don’t mark visited vertices, then 2 will be processed again and it will become a non-terminating process.
A Breadth First Traversal of the following graph is 2, 0, 3, 1."""

from collections import defaultdict

class Graph:
    def __init__(self):
        self.graph = defaultdict(list)

    def addEdge(self,src,dest):     # function to add an edge to graph
        self.graph[src].append(dest)    # stores the data like [(0, [1, 3]), (1, [2, 4]), (2, [1,4])]. It's an example

    def BFS(self,start_node):

        visited = [False]*(len(self.graph))   # Flag to check if the node is visited or not and Store data like [False,False,False,False,False,False]
        queue = []      # Create a queue for BFS

        queue.append(start_node)    # insert the start node into the queue
        visited[start_node] = True  # Mark the start node as visited
        while queue:
            s = queue.pop(0)    # Deque first element
            print(s,end="  ")    # print the element
            for i in self.graph[s]:     # Loop through the dictionary to get the values of the key
                # print('i: ',i)
                if visited[i] == False: # check if the node is not visited
                    queue.append(i)     # add the adjacent nodes (i.e. dictionary values for the respective key)
                    visited[i] = True      # mark the nodes as visited in the flag

g = Graph()
g.addEdge(0, 1)
g.addEdge(0, 2)
g.addEdge(1, 2)
g.addEdge(2, 0)
g.addEdge(2, 3)
g.addEdge(3, 3)

print ("Following is Breadth First Traversal"
       " (starting from vertex 2)")
g.BFS(2)