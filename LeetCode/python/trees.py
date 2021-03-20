#
# 938. Range Sum of BST
# Given the root node of a binary search tree, return the sum of values of all nodes with a value in the range [low, high].
# Input: root = [10,5,15,3,7,null,18], low = 7, high = 15
# Output: 32
# Input: root = [10,5,15,3,7,13,18,1,null,6], low = 6, high = 10
# Output: 23
#
# Solution1: [Recurssive]
class Solution:
    def rangeSumBST(self, root: TreeNode, low: int, high: int) -> int:
        self.res = 0
        def addTotal(root):
            if not root:
                return 0
            if low <= root.val <= high:
                self.res += root.val
            if root.val > low:
                addTotal(root.left)
            if root.val < high:
                addTotal(root.right)

        addTotal(root)
        return self.res

# Solution2: [Recurssive]
class Solution:
    def rangeSumBST(self, root: TreeNode, low: int, high: int) -> int:
        if not root:
            return 0

        if root.val < low:
            return self.rangeSumBST(root.right,low,high)
        if root.val > high:
            return self.rangeSumBST(root.left,low,high)
        else:
            return self.rangeSumBST(root.right,low,high) + root.val + self.rangeSumBST(root.left,low,high)

# Solution3: [Iterative]
class Solution:
    def rangeSumBST(self, root: TreeNode, low: int, high: int) -> int:

        if not root:
            return 0

        res = 0
        stack = [root]

        while stack:
            node = stack.pop()
            if node:

                if low <= node.val <= high:
                    res += node.val
                if node.val < high:
                    stack.append(node.right)
                if node.val > low:
                    stack.append(node.left)
        return res
#
# 270. Closest Binary Search Tree Value
# Given a non-empty binary search tree and a target value, find the value in the BST that is closest to the target.
#
# Note:
#
# Given target value is a floating point.
# You are guaranteed to have only one unique value in the BST that is closest to the target.
# Example:
#
# Input: root = [4,2,5,1,3], target = 3.714286
#
# 4
# / \
#     2   5
# / \
#     1   3
#
# Output: 4

# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def closestValue(self, root: TreeNode, target: float) -> int:
        node = root
        candidate = node.val
        while node:
            candidate = min((candidate,node.val), key = lambda x: abs(target-x)) # find the min between candidate and node based on the formula in lambda function

            if target > node.val:
                node = node.right
            elif target < node.val:
                node = node.left
            else:
                return node.val

        return candidate


#
# 543. Diameter of Binary Tree
# Given a binary tree, you need to compute the length of the diameter of the tree.
# The diameter of a binary tree is the length of the longest path between any two nodes in a tree. This path may or may not pass through the root.
# Example:
# Given a binary tree
# 1
# / \
#     2   3
# / \
#     4   5
# Return 3, which is the length of the path [4,2,1,3] or [5,2,1,3].
#
# Note: The length of path between two nodes is represented by the number of edges between them.
#
# Solution:
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def diameterOfBinaryTree(self, root: TreeNode) -> int:
        if not root:
            return 0
        Lheight = self.height(root.left)
        Rheight = self.height(root.right)

        Ldiameter = self.diameterOfBinaryTree(root.left)
        Rdiameter = self.diameterOfBinaryTree(root.right)

        return max(Lheight+Rheight,max(Ldiameter,Rdiameter))

    def height(self,root): # find the complete height of a tree
        if not root:
            return 0
        else:
            lheight = self.height(root.left)
            rheight = self.height(root.right)
            return max(lheight,rheight)+1 # +1 because of the root node of that tree/subtree

#
#
# 278. First Bad Version
# You are a product manager and currently leading a team to develop a new product. Unfortunately, the latest version of your product fails the quality check. Since each version is developed based on the previous version, all the versions after a bad version are also bad.
# Suppose you have n versions [1, 2, ..., n] and you want to find out the first bad one, which causes all the following ones to be bad.
# You are given an API bool isBadVersion(version) which returns whether version is bad. Implement a function to find the first bad version. You should minimize the number of calls to the API.
#
# Example 1:
#
# Input: n = 5, bad = 4
# Output: 4
# Explanation:
# call isBadVersion(3) -> false
# call isBadVersion(5) -> true
# call isBadVersion(4) -> true
# Then 4 is the first bad version.
#
# Solution: [Binary Search Tree]
class Solution:
    def firstBadVersion(self, n):
        """
        :type n: int
        :rtype: int
        """
        start = 1
        end = n
        while start < end:
            mid = (start+end)//2
            if isBadVersion(mid) == True:
                end = mid
            else:
                start = mid+1
        return start
#
#
#
# 257. Binary Tree Paths
#
# Given a binary tree, return all root-to-leaf paths.
#
# Note: A leaf is a node with no children.
#
# Example:
#
# Input:
#
# 1
# / \
#     2     3
# \
# 5
#
# Output: ["1->2->5", "1->3"]
#
# Explanation: All root-to-leaf paths are: 1->2->5, 1->3
#
# Solution:

class Solution:
    def binaryTreePaths(self, root: TreeNode) -> List[str]:

        def construct_path(root,path):
            if root:
                path = path+str(root.val)

                if  not root.left and not root.right:
                    paths.append(path)
                else:
                    path = path + "->"
                    construct_path(root.left,path)
                    construct_path(root.right,path)

        paths = []
        construct_path(root,"")
        return paths

