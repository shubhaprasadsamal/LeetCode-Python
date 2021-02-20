# Height of empty tree is 0 and height of below tree is 3.
#
# maxDepth()
# 1. If tree is empty then return 0
# 2. Else
# (a) Get the max depth of left subtree recursively  i.e.,
# call maxDepth( tree->left-subtree)
# (a) Get the max depth of right subtree recursively  i.e.,
# call maxDepth( tree->right-subtree)
# (c) Get the max of max depths of left and right
# subtrees and add 1 to it for the current node.
# max_depth = max(max dept of left subtree,
#                                  max depth of right subtree) + 1
# (d) Return max_depth

class Node:
    def __init__(self,value):
        self.value = value
        self.left = None
        self.right = None

def maxDepth(node):
    if node is None:
        return 0
    else:
        lDepth = maxDepth(node.left)
        rDepth = maxDepth(node.right)

    if lDepth > rDepth:
        return lDepth+1
    else:
        return rDepth+1

tree = Node(1)
tree.left = Node(2)
tree.right = Node(3)
tree.left.left = Node(4)
tree.left.right = Node(5)
tree.right.left = Node(6)
tree.right.right = Node(7)

print(maxDepth(tree))