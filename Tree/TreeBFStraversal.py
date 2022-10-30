# In Breadth-First-Search Tree Traversal we will use a queue to traverse through.
# For breadth first, add all children to the queue, then pull the head and do a breadth first search on it,
# using the same queue.

#************************
#Queue Implementation
#************************

class Node:                                         # Define the Tree
    def __init__(self,value):
        self.value = value
        self.left = None
        self.right = None

def breadthFirstSearch(root):

    if root is None:
        return
    queue = []                                      # Define a queue and insert
    queue.append(root)
    res = ""

    while (len(queue) > 0):
        node = queue.pop(0)                         # Take out the first node in the queue and check for the child element and then insert it into queue
        res = res +  str(node.value) +" > "
        print('Traverse Node: ',res)
        if node.left:
            queue.append(node.left)
        if node.right:
            queue.append(node.right)

tree = Node(1)
tree.left = Node(2)
tree.right = Node(3)
tree.left.left = Node(4)
tree.left.right = Node(5)
tree.right.left = Node(6)
tree.right.right = Node(7)

print(tree.value)
print(tree.left.value)
print(tree.right.value)
print(tree.left.left.value)
print(tree.left.right.value)
print(tree.right.left.value)
print(tree.right.right.value)

breadthFirstSearch(tree)





