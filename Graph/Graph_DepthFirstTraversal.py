
'''Implementation - 1'''
#
# from collections import defaultdict
#
# class Graph:
#     def __init__(self):
#         self.graph = defaultdict(list)
#
#     def addEdge(self,src,dest):
#         self.graph[src].append(dest)        # Adjacency List
#
#     def DFS_method1(self,start_node):
#
#         visited = [False]*(len(self.graph))
#         stack = []
#
#         stack.append(start_node)
#         visited[start_node] = True
#         print('start_node: ', start_node)
#         print('visited[start_node]: ',visited[start_node])
#
#         while stack:
#             s = stack.pop()
#             print(s,end="  ")
#             for i in self.graph[s]:
#                 # print('i: ',i)
#                 if visited[i] == False:
#                     stack.append(i)
#                     visited[i] = True
#
# g = Graph()
#
# g.addEdge(0, 1)
# g.addEdge(0, 2)
# g.addEdge(1, 2)
# g.addEdge(2, 0)
# g.addEdge(2, 3)
# g.addEdge(3, 3)
#
#
# print("Following is DFS from (starting from vertex 2)")
# g.DFS_method1(2)

'''Implementation - 2 (vertices as letter)'''

graph = {'A': set(['B', 'C']),          # need find a way to bring this structure from a  graph
         'B': set(['A', 'D', 'E']),
         'C': set(['A', 'F']),
         'D': set(['B']),
         'E': set(['B', 'F']),
         'F': set(['C', 'E'])}

def DFS(graph,start):

    visited = set() # Set
    stack = [start]

    while stack:
        s = stack.pop()
        # print('S: ',s, end= " ")
        # print(end = " ")
        # print('visited: ',visited)
        if s not in visited:
            visited.add(s)
            stack.extend(graph[s] - visited)
            # print('Stack: ',stack)
    print(visited)

DFS(graph, 'A')


def dfs_recurssive(graph, start, visited=None):
    if visited is None:
        visited = set()
    visited.add(start)
    for next in graph[start] - visited:
        dfs(graph, next, visited)
    return visited

dfs_recurssive(graph, 'C') # {'E', 'D', 'F', 'A', 'C', 'B'}