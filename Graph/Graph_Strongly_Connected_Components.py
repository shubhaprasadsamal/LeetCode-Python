'''
A directed graph is strongly connected if there is a path between all pairs of vertices.
A strongly connected component (SCC) of a directed graph is a maximal strongly connected subgraph.
For example, there are 3 SCCs in the following graph.
'''

'''
1) Create an empty stack ‘S’ and do DFS traversal of a graph. 
In DFS traversal, after calling recursive DFS for adjacent vertices of a vertex, push the vertex to stack. 
In the above graph, if we start DFS from vertex 0, we get vertices in stack as 1, 2, 4, 3, 0.
2) Perform the Transpose Graph by reversing the direction of the edges in the graph.
3) One by one pop a vertex from S while S is not empty. Let the popped vertex be ‘v’. 
Take v as source and do DFS (call DFSUtil(v)). The DFS starting from v prints strongly connected component of v. 
In the above example, we process vertices in order 0, 3, 4, 2, 1 (One by one popped from stack).
'''
from collections import defaultdict
class Graph:
    def __init__(self,V):
        # print('Init')
        self.V = V
        self.graph = defaultdict(list)

    def addEdge(self,src,dest):
        # print('adEdge')
        self.graph[src].append(dest)

    def transpose(self):             #2) Perform the Transpose Graph by reversing the direction of the edges in the graph.
        # print('transpose')
        g = Graph(self.V)
        for i in range(self.V):
            for j in self.graph[i]:
                g.addEdge(j,i)
        return g

    def DFSUtil(self,v,visited):
        # print('DFSUtil')
        visited[v] = True
        print(v)
        for i in self.graph[v]:
            if visited[i] == False:
                self.DFSUtil(i,visited)

    def OrderFill(self,v,visited,stack):    # DFS with inserting the element into stack
        # print('OrderFill')
        visited[v] = True
        for i in self.graph[v]:
            if visited[i] == False:
                self.OrderFill(i,visited,stack)
        stack.append(v)

    def printSCCs(self):
        # print('printSCCs')
        visited = [False]*self.V
        stack = []                  # Create an Empty Stack
        for i in range(self.V):
            # print('Inside For')
            if visited[i] == False:
                # print('Inside printSCCs visited')
                self.OrderFill(i,visited,stack)

        gr = self.transpose()

        visited = [False]*self.V

        while stack:
            j =stack.pop()       # Pop the element from the stack
            if visited[j] == False:
                # print('visited[j]: ',visited[j])
                gr.DFSUtil(j,visited)     # DFS with transpose graph
                print("")

# Create a graph given in the above diagram
g = Graph(5)
g.addEdge(1, 0)
g.addEdge(0, 2)
g.addEdge(2, 1)
g.addEdge(0, 3)
g.addEdge(3, 4)


print ("Following are strongly connected components " +
       "in given graph")
g.printSCCs()



