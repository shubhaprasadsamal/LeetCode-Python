class Graph:

    def __init__(self,V):
        self.V = V
        self.adj = [[] for i in range(V)]


    def addEdge(self,src,dest):
        self.adj[src].append(dest)
        self.adj[dest].append(src)
        # print('self.adj: ',self.adj)

    def DFSUtil(self,temp,v,visited):
        # print('inside DFSUtil')
        visited[v] = True
        temp.append(v)
        # print('temp.append: ',temp)

        for i in self.adj[v]:
            # print('inside self.adj')
            if visited[i] == False:
                # print('DFSUtil inside for and if')
                temp = self.DFSUtil(temp,i,visited)
        # print('temp: ',temp)
        return temp


    def connectedComponents(self):
        visited = [False]*self.V
        cc = []

        for i in range(self.V):
            if visited[i] == False:
                # print('inside cc for and if and i: ',i)
                temp = []
                cc.append(self.DFSUtil(temp,i,visited))
                # print('CC: ',cc)
        return cc



if __name__=="__main__":

    # Create a graph given in the above diagram
    # 5 vertices numbered from 0 to 4
    g = Graph(5)
    g.addEdge(1, 0)
    g.addEdge(2, 3)
    g.addEdge(3, 4)
    cc = g.connectedComponents()
    print("Following are connected components")
    print(cc)