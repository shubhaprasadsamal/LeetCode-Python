# The idea is to do iterative level order traversal of the given tree using queue. If we find a node whose left child is empty,
# we make new key as left child of the node. Else if we find a node whose right child is empty, we make new key as right child.
# We keep traversing the tree until we find a node whose either left or right is empty.

class Node:
    def __init__(self,value):
        self.value = value
        self.left = None
        self.right = None


def inOrderTraversal(root, traversal: str):

    if root:
        traversal = inOrderTraversal(root.left,traversal)
        traversal += (str(root.value)+ '-')
        print(root.value, end=' ')
        traversal = inOrderTraversal(root.right,traversal)
    return traversal

def isertNode(root,key):
    if root is None:
        return

    queue = []
    queue.append(root)
    while (len(queue) >0):
        temp = queue[0]
        queue.pop(0)

        if not temp.left:
            temp.left = Node(key)
            break
        else:
            queue.append(temp.left)

        if not temp.right:
            temp.right = Node(key)
            break
        else:
            queue.append(temp.right)


tree = Node(1)
tree.left = Node(2)
tree.right = Node(3)
tree.left.left = Node(4)
tree.left.right = Node(5)
# tree.right.left = Node(6)
tree.right.right = Node(7)

inOrderTraversal(tree,"")

isertNode(tree,6)
print()

inOrderTraversal(tree,"")