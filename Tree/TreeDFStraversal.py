# Tree Traversal: Process of visiting (Checking/updating) each node in a tree data structure
# exactly once.
# Unlike LinkedList/Array of linear traversal, Trees can be traversed in multiple ways:
# Depth-First-Search
#     1. In-Ordered
#     2. Pre-Ordered
#     3. Post-Ordered
# Breadth-First-Search
# For depth first, we can add all children to the stack, then pop and do a depth first on that node,
# using the same stack. (Another Way to do that)

# inorder = sorted(postorder) = sorted(preorder)

# Pre-Ordered (recursive Way):
class Node:
    def __init__(self,value):
        self.value = value
        self.left = None
        self.right = None
class BinaryTree:
    def __init__(self,root):
        self.root = Node(root)

    def pre_ordered(self,start,traversal: str):                     # traversal is the string type, will collect the string data
        if start:
            traversal += (str(start.value)+"-")                     # '-'
            traversal = self.pre_ordered(start.left,traversal)      # Recursive use of method
            traversal = self.pre_ordered(start.right,traversal)     # Recursive use of method
        return traversal

    def in_ordered(self,start,traversal: str):
        if start:
            traversal = self.in_ordered(start.left,traversal)       # Go to farthest Left first and get the left most node
            traversal += (str(start.value)+"-")                     # go to the root and get the root node
            traversal = self.in_ordered(start.right,traversal)      # Go to farthest Right first and get the Right most node
        return traversal

    def post_ordered(self,start,traversal: str):
        if start:
            traversal = self.post_ordered(start.left,traversal)
            traversal = self.post_ordered(start.right,traversal)
            traversal += (str(start.value)+"-")
        return traversal

    def print_tree(self,traversal_type: str):
        if traversal_type == 'pre_ordered':
            return self.pre_ordered(self.root,"")
        elif traversal_type == 'in_ordered':
            return self.in_ordered(self.root,"")
        elif traversal_type == 'post_ordered':
            return self.post_ordered(self.root,"")
        else:
            print("Traversal type"+ str(traversal_type) + "is not supported now.")

tree = BinaryTree(1)
tree.root.left = Node(2)
tree.root.right = Node(3)
tree.root.left.left = Node(4)
tree.root.left.right = Node(5)
tree.root.right.left = Node(6)
tree.root.right.right = Node(7)
# tree.root.left.left.left = Node(8)
#               1
#           /       \
#          2          3
#        /   \      /   \
#       4      5   6      7
#     /   \   / \ / \    / \
#    8
print(tree.print_tree("pre_ordered"))
print(tree.print_tree("in_ordered"))
print(tree.print_tree("post_ordered"))

