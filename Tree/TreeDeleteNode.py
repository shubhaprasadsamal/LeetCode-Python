# Given a binary tree, delete a node from it by making sure that tree shrinks from the bottom
# (i.e. the deleted node is replaced by bottom most and rightmost node). This different from BST deletion.
# Here we do not have any order among elements, so we replace with last element.
#
# Examples :
#
# Delete 10 in below tree
# 10
# / \
# 20 30
# Output :
# 30
# /
# 20
#
#
# Delete 20 in below tree
# 10
# / \
# 20 30
#     \
#     40
# Output :
# 10
# / \
# 40 30
#
# Algorithm
# 1. Starting at root, find the deepest and rightmost node in binary tree and node which we want to delete.
# 2. Replace the deepest rightmost node’s data with node to be deleted.
# 3. Then delete the deepest rightmost node.
#
# Note:
# We can also replace node’s data that is to be deleted with any node whose left and right child points to NULL
# but we only use deepest node in order to maintain the Balance of a binary tree.

class Node:                                         # Define the Tree
    def __init__(self,value):
        self.value = value
        self.left = None
        self.right = None

def inOrder(root):
    if not root:
        return
    inOrder(root.left)
    print(root.value,end = ' ')
    inOrder(root.right)

def deleteDeepestNode(root,node):
    print('inside deleteDeepestNode')
    queue = []
    queue.append(root)
    while len(queue):
        temp = queue.pop(0)
        print("temp first func: ",temp.value)
        print("Node to be replaced: ",node.value)
        if temp is node:
            temp = None
            return
        if temp.right:
            if temp.right is node:
                temp.right = None
            else:
                queue.append(temp.right)
        if temp.left:
            if temp.left is node:
                temp.left = None
            else:
                queue.append(temp.left)

def deleteNode(root,key):
    print('inside deleteNode')
    if root is None:
        return None
                    #   There is some other conditions in Geek
    queue = []
    queue.append(root)
    key_node = None

    while len(queue):
        temp = queue.pop(0)
        if temp.value == key:
            key_node = temp
            print("Key_Node: ",key_node.value)
        if temp.left:
            queue.append(temp.left)
        if temp.right:
            queue.append(temp.right)

    if key_node:                            # Replace the deleted node with deepest node
        print("temp in deleteNode: ",temp.value)
        x = temp.value
        deleteDeepestNode(root,temp)
        key_node.value = x
    return

tree = Node(1)
tree.left = Node(2)
tree.right = Node(3)
tree.left.left = Node(4)
tree.left.right = Node(5)
tree.right.left = Node(6)
tree.right.right = Node(7)

inOrder(tree)
print()
key = 2
deleteNode(tree,key)
print()

inOrder(tree)
