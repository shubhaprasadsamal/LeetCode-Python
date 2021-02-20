# Geeks:
#
# tree
# ----
# j    <-- root
# / \
# f  k
# /   \ \
# a    h z    <-- leaves
#
# Why Trees?
# 1. One reason to use trees might be because you want to store information that naturally forms a hierarchy. For example, the file system on a computer:
#
# file system
# -----------
# /    <-- root
# / \
#     ...       home
# / \
#     ugrad        course
# /       /      | \
#     ...      cs101  cs112  cs113
# 2. Trees (with some ordering e.g., BST) provide moderate access/search (quicker than Linked List and slower than arrays).
# 3. Trees provide moderate insertion/deletion (quicker than Arrays and slower than Unordered Linked Lists).
# 4. Like Linked Lists and unlike Arrays, Trees don’t have an upper limit on number of nodes as nodes are linked using pointers.
#
# Main applications of trees include:
# 1. Manipulate hierarchical data.
# 2. Make information easy to search (see tree traversal).
# 3. Manipulate sorted lists of data.
# 4. As a workflow for compositing digital images for visual effects.
# 5. Router algorithms
# 6. Form of a multi-stage decision-making (see business chess).
#
# Binary Tree: A tree whose elements have at most 2 children is called a binary tree.
# Since each element in a binary tree can have only 2 children, we typically name them the left and right child.

# LucidProgramming - YouTue

class Node:
    def __init__(self,value):
        self.value = value
        self.left = None
        self.right = None

# class BinaryTree:                     # Commenting as per Geek
#     def __init__(self,root):
#         self.root = Node(root)

#               1
#           /       \
#          2          3
#        /   \      /   \
#       4      5   6      7
#     /   \   / \ / \    / \
#    8

# tree = BinaryTree(1)                  # Commenting as per Geek

root = Node(1)
root.left = Node(2)
root.right = Node(3)
root.left.left = Node(4)
root.left.right = Node(5)
root.right.left = Node(6)
root.right.right = Node(7)
root.left.left.left = Node(8)


# tree.root.left = Node(2)              # Commenting as per Geek
# tree.root.right = Node(3)
# tree.root.left.left = Node(4)
# tree.root.left.right = Node(5)
# tree.root.right.left = Node(6)
# tree.root.right.right = Node(7)
# tree.root.left.left.left = Node(8)

print(root.value)
print(root.left.value)
print(root.right.value)
print(root.left.left.left.value)

# print(tree.root.value)                # Commenting as per Geek
# print(tree.root.left.value)
# print(tree.root.right.value)
# print(tree.root.left.left.left.value)