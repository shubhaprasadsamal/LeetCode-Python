# LCA - Lowest Common Ancestor

class Node:
    def __init__(self,value):
        self.value = value
        self.left = None
        self.right = None

def treePath(root,path,key):
    if root is None:
        return False

    path.append(root.value)

    if root.value == key:
        return True
    if ((root.left is not None and treePath(root.left,path,key)) or (root.right is not None and treePath(root.right,path,key))):

        return True
    path.pop()

def findLCA(root,n1,n2):

    path1 = []
    path2 = []

    if (not treePath(root,path1,n1) and not treePath(root,path2,n2)):
        return -1
    i= 0

    while (i < len(path1) and i < len(path2)):
        if path1[i] != path2[i]:
            break
        i +=1

    return path1[i-1]


tree = Node(1)
tree.left = Node(2)
tree.right = Node(3)
tree.left.left = Node(4)
tree.left.right = Node(5)
tree.left.left.right = Node(6)
tree.right.left = Node(7)

# print('LCA(2,4)',findLCA(tree,2,4))
# print('LCA(4,5)',findLCA(tree,4,5))
# print('LCA(4,6)',findLCA(tree,4,6))
# print('LCA(3,4)',findLCA(tree,3,4))

# As the above method as time complexity of O(n), requires 3 tree traversal and extra space fpr path arrays.
# hence let's try it in another method

class Node:
    def __init__(self,value):
        self.value = value
        self.left = None
        self.right = None

def LCAnode(root,n1,n2):

    if root is None:
        return None

    if root.value == n1 or root.value == n2:
        return root

    LCAleft = LCAnode(root.left,n1,n2)
    LCAright = LCAnode(root.right,n1,n2)


    if LCAleft and LCAright:
        return root

    return LCAleft if LCAleft is not None else LCAright

tree = Node(1)
tree.left = Node(2)
tree.right = Node(3)
tree.left.left = Node(4)
tree.left.right = Node(5)
tree.left.left.right = Node(6)
tree.right.left = Node(7)

# print('LCA(2,4): ',LCAnode(tree,2,4).value)
# print('LCA(4,5): ',LCAnode(tree,4,5).value)
# print('LCA(4,6): ',LCAnode(tree,4,6).value)
# print('LCA(3,4): ',LCAnode(tree,3,4).value)

# Time complexity of the above solution is O(n) as the method does a simple tree traversal in bottom up fashion.
# Note that the above method assumes that keys are present in Binary Tree. If one key is present and other is absent,
# then it returns the present key as LCA (Ideally should have returned NULL).
# We can extend this method to handle all cases by passing two boolean variables v1 and v2.
# v1 is set as true when n1 is present in tree and v2 is set as true if n2 is present in tree.

class Node:
    def __init__(self,value):
        self.value = value
        self.left = None
        self.right = None

def findLCAutil(root,n1,n2,v):
    if root is None:
        return None

    if root.value == n1:
        v[0] = True
        return root
    if root.value == n2:
        v[1] = True
        return root

    LeftLCA = findLCAutil(root.left,n1,n2,v)
    RightLCA = findLCAutil(root.right,n1,n2,v)

    if LeftLCA and RightLCA:
        return root

    return LeftLCA if LeftLCA is not None else RightLCA

def findKey(root,k):

    if root is None:
        return False

    if root == k or findKey(root.left,k) or findKey(root.right,k):
        return True

    return False

def findLCA(root,n1,n2):

    v = [False,False]
    lca = findLCAutil(root,n1,n2,v)

    if (v[0] and v[1] or v[0] and findKey(lca,n2) or v[1] and findKey(lca,n1)):
        return lca

    return None

root = Node(1)
root.left = Node(2)
root.right = Node(3)
root.left.left = Node(4)
root.left.right = Node(5)
root.right.left = Node(6)
root.right.right = Node(7)

print('LCA:', findLCA(root, 4, 6).value)

