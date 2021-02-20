#####################################
# Implementation with Queue & Stack #
#####################################


class Node:                                         # Define the Tree
    def __init__(self,value):
        self.value = value
        self.left = None
        self.right = None

def reverseLevelOrder(root):

    if root is None:
        return

    queue = []
    stack = []
    queue.append(root)

    while (len(queue) > 0):
        node = queue.pop(0)
        stack.append(node)
        if node.left:
            queue.append(node.left)
        if node.right:
            queue.append(node.right)

    while (len(stack) > 0):
        print(stack.pop().value)

tree = Node(1)
tree.left = Node(2)
tree.right = Node(3)
tree.left.left = Node(4)
tree.left.right = Node(5)
tree.right.left = Node(6)
tree.right.right = Node(7)

reverseLevelOrder(tree)

