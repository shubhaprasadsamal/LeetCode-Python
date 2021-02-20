class Node:
    def __init__(self,value):
        self.value = value
        self.left = None
        self.right = None

def leafsNoSiblings(root):
    if root is None:
        return
    if root.left is not None and root.right is not None:
        leafsNoSiblings(root.left)
        leafsNoSiblings(root.right)
    elif root.left is not None:
        print(root.left.value)      # i.e. root.right is None and hence root.left doesn't have any siblings
        leafsNoSiblings(root.left)
    elif root.right is not None:
        print(root.right.value)     # i.e. root.right is None and hence root.left doesn't have any siblings
        leafsNoSiblings(root.right)

tree = Node(1)
tree.left = Node(2)
# tree.right = Node(3)
# tree.left.left = Node(4)
tree.left.right = Node(5)
# tree.right.left = Node(6)
# tree.right.right = Node(7)

leafsNoSiblings(tree)