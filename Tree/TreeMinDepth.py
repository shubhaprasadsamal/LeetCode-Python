# The minimum depth is the number of nodes along the shortest path from the root node down to the nearest leaf node.
# minimum height of below Binary Tree is 2.
# Note that the path must end on a leaf node
#
#             1
#         /       \
#     2               3
#   /   \
# 4       5
#
# The idea is to traverse the given Binary Tree. For every node, check if it is a leaf node.
# If yes, then return 1. If not leaf node then if the left subtree is NULL, then recur for the right subtree.
# And if the right subtree is NULL, then recur for the left subtree.
# If both left and right subtrees are not NULL, then take the minimum of two heights.

class Node:
    def __init__(self,value):
        self.value = value
        self.left = None
        self.right = None

def minimunDepth(root):
    if root is None:
        return 0

    if root.left is None and root.right is None:    #Base Case : Leaf node.This acoounts for height = 1
        return 1
    if root.left is None:
        minimunDepth(root.right) +1
    if root.right is None:
        minimunDepth(root.left) +1
    return min(minimunDepth(root.right),minimunDepth(root.left)) + 1


tree = Node(1)
tree.left = Node(2)
tree.right = Node(3)
tree.left.left = Node(4)
tree.left.right = Node(5)
tree.right.left = Node(6)
tree.right.right = Node(7)

print(minimunDepth(tree))