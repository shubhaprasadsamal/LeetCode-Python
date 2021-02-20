# Graph:

"""
A Python program to demonstrate the adjacency
list representation of the graph
"""

# 0---------1 *
# |       /  |    *
# |     /    |        *2
# |   /      |    *
# 4---------3 *
#
# Array List = [[1,4],[0,2,3,4],[1,3],[1,2,4],[0,1,3]]
#               **0** ****1**** **2** ***3*** ***4***  -> Index of this array is nothing but the each vertex of the graph
class AdjNode:
    def __init__(self,data):
        self.vertex = data
        self.next = None

class Graph:
    def __init__(self, V):
        self.numberOfVertices = V
        self.graph_array = [None]*numberOfVertices # Create an array with the size of number of nodes

    def add_edge(self,src,dest):
        node = AdjNode(dest)
        node.next = self.graph_array[src] # Pointing to index of an array
        self.graph_array[src] = node    # assign the source value to the array

        node = AdjNode(src)
        node.next = self.graph_array[dest] # Pointing to index of an array
        self.graph_array[dest] = node    # assign the destination value to the array

    def print_graph(self):
        for i in range (self.numberOfVertices):
            print("Adjacency list of vertex {}\n head".format(i), end="")
            temp = self.graph_array[i]
            while temp:
                print(" -> {}".format(temp.vertex), end="")
                temp = temp.next
            print(" \n")


if __name__=="__main__":

    numberOfVertices = 5
    graph = Graph(numberOfVertices)

    graph.add_edge(0, 1)
    graph.add_edge(0, 4)
    graph.add_edge(1, 2)
    graph.add_edge(1, 3)
    graph.add_edge(1, 4)
    graph.add_edge(2, 3)
    graph.add_edge(3, 4)

    graph.print_graph()