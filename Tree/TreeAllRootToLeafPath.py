# For the below example tree, all root-to-leaf paths are:
# 10 –> 8 –> 3
# 10 –> 8 –> 5
# 10 –> 2 –> 2
#
#             10
#           /    \
#         8        2
#       /   \     /
#     3       5  2

# Use a path array path[] to store current root to leaf path. Traverse from root to all leaves in top-down fashion.
# While traversing, store data of all nodes in current path in array path[]. When we reach a leaf node, print the path array.

#*********************************#
#Pre-Order Traversal Implementation
#*********************************#

class Node:
    def __init__(self,value):
        self.value = value
        self.left = None
        self.right = None

def rootToLeafPath(root,stack):

    if root is None:
        return
    stack.append(root.value)
    if (root.left == None and root.right == None):
        # print(stack)
        # print()
        print([str(i) for i in stack])
        # print()
        # print(' '.join([str(i) for i in stack]))
    rootToLeafPath(root.left,stack)
    rootToLeafPath(root.right,stack)
    stack.pop()

#********************************#
#In-Order Traversal Implementation
#********************************#

def rootToLeafPath1(root,stack):

    if root is None:
        return
    stack.append(root.value)

    rootToLeafPath(root.left,stack)
    if (root.left == None and root.right == None):
    # print(stack)
    # print()
        print([str(i) for i in stack])
    # print()
    # print(' '.join([str(i) for i in stack]))
    rootToLeafPath(root.right,stack)
    stack.pop()

tree = Node(1)
tree.left = Node(2)
tree.right = Node(3)
tree.left.left = Node(4)
tree.left.right = Node(5)
tree.left.left.right = Node(6)
tree.right.left = Node(7)

print(rootToLeafPath(tree,[]))