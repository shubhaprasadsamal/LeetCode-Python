   #      1
   #     / \
   #    2   3
   #  /  \ /  \
   # 4   5 6   7

# Output = 1,2,3,7,6,5,4

#***********************************#
# Implementation by using two Stacks#
#***********************************#

class Node:
    def __init__(self,value):
        self.value = value
        self.left = None
        self.right = None

def spiralTraversal(root):
    if root is None:
        return

    s1 = []
    s2 = []

    s1.append(root)

    while not len(s1) == 0 or not len(s2) == 0:

        while not len(s1) == 0:
            temp = s1[-1]
            s1.pop()
            print(temp.value)

            if temp.right:
                s2.append(temp.right)
            if temp.left:
                s2.append(temp.left)

        while not len(s2) == 0:
            temp = s2[-1]
            s2.pop()
            print(temp.value)
            if temp.left:
                s1.append(temp.left)
            if temp.right:
                s1.append(temp.right)

# Output:
tree = Node(1)
tree.left = Node(2)
tree.right = Node(3)
tree.left.left = Node(4)
tree.left.right = Node(5)
tree.right.left = Node(6)
tree.right.right = Node(7)

spiralTraversal(tree)