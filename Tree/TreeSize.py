# Size of a tree is the number of elements present in the tree. Size of the below tree is 5.
#
# Size() function recursively calculates the size of a tree. It works as follows:
#
# Size of a tree = Size of left subtree + 1 + Size of right subtree.


class Node:
    def __init__(self,value):
        self.value = value
        self.left = None
        self.right = None

def treeSize(root):
    if root is None:
        return 0
    else:
        size = treeSize(root.left) + 1 + treeSize(root.left)
        return size

tree = Node(1)
tree.left = Node(2)
tree.right = Node(3)
tree.left.left = Node(4)
tree.left.right = Node(5)
tree.right.left = Node(6)
tree.right.right = Node(7)

print(treeSize(tree))