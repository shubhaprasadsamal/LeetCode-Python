# 108. Convert Sorted Array to Binary Search Tree
# Given an integer array nums where the elements are sorted in ascending order, convert it to a height-balanced binary search tree.
#
# A height-balanced binary tree is a binary tree in which the depth of the two subtrees of every node never differs by more than one.
#
#
#
# Example 1:
#
#
# Input: nums = [-10,-3,0,5,9]
# Output: [0,-3,9,-10,null,5]
# Explanation: [0,-10,5,null,-3,null,9] is also accepted:
#
# Example 2:
#
#
# Input: nums = [1,3]
# Output: [3,1]
# Explanation: [1,null,3] and [3,1] are both height-balanced BSTs.
#
#
# Constraints:
#
# 1 <= nums.length <= 104
# -104 <= nums[i] <= 104
# nums is sorted in a strictly increasing order.

# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def sortedArrayToBST(self, nums: List[int]) -> Optional[TreeNode]:

        def helper(l,r): # assign l to the start loaction of the array and r to the end location of the array
            if l > r:   # Base Case as left position value has to be always less than right position value
                return None

            mid = (l+r)//2 # Since the array is sorted, hence root would be the middle value
            root = TreeNode(nums[mid]) # Create Tree Node from Array mid value and assign to variable root
            root.left = helper(l,mid-1) # Left sub tree is going to be formed from left of the mid value
            root.right = helper(mid+1,r) # Right sub tree is going to be formed from Right of the mid value

            return root # return root

        return helper(0,len(nums)-1)

# 118. Pascal's Triangle
# Easy
#
# 6374
#
# 221
#
# Add to List
#
# Share
# Given an integer numRows, return the first numRows of Pascal's triangle.
#
# In Pascal's triangle, each number is the sum of the two numbers directly above it as shown:
#
#
#
#
# Example 1:
#
# Input: numRows = 5
# Output: [[1],[1,1],[1,2,1],[1,3,3,1],[1,4,6,4,1]]
# Example 2:
#
# Input: numRows = 1
# Output: [[1]]
#
#
# Constraints:
#
# 1 <= numRows <= 30
class Solution:
    def generate(self, numRows: int) -> List[List[int]]:
        # Define the first row of the triangle
        # Now we need numRows-1 rows on the triangle to be formed
        # For every single new row to be formed we have to access the a previos row(Or the last row)
        # Add element [0] to both left and right of the previos row
        # Form the new row element by adding the adjacent element of the previous row
        # As the new row length is going to 1 more than prev row, hence J loop need be added with 1

        #           0 1 0
        #          0 1 1 0
        #         0 1 2 1 0
        #        0 1 3 3 1 0
        #       0 1 4 6 4 1 0
        # Same problem can be done by Dynamic Programming [Need understanding]

        output = [[1]] # Defining/hardcode first row of the Triangle/fist element

        for i in range(numRows-1): # numRows-1 because we have already hard coed the first element
            # create an array by adding 0 before and after of the last value output array for addition in the next step
            map1 = [0]+output[-1]+[0]
            map2 = []

            for j in range(len(map1)-1):
                map2.append(map1[j]+map1[j+1]) # Get the element by adding the consecutive elemenets of the previous array

            output.append(map2)

        return output

# 121. Best Time to Buy and Sell Stock
# You are given an array prices where prices[i] is the price of a given stock on the ith day.
#
# You want to maximize your profit by choosing a single day to buy one stock and choosing a different day in the future to sell that stock.
#
# Return the maximum profit you can achieve from this transaction. If you cannot achieve any profit, return 0.
#
#
#
# Example 1:
#
# Input: prices = [7,1,5,3,6,4]
# Output: 5
# Explanation: Buy on day 2 (price = 1) and sell on day 5 (price = 6), profit = 6-1 = 5.
# Note that buying on day 2 and selling on day 1 is not allowed because you must buy before you sell.
# Example 2:
#
# Input: prices = [7,6,4,3,1]
# Output: 0
# Explanation: In this case, no transactions are done and the max profit = 0.

class Solution(object):
    def maxProfit(self, prices):
        """
        :type prices: List[int]
        :rtype: int
        """
        sale = 0
        profit = 0
        buy = prices[0]

        for i in range(1,len(prices)):

            buy = min(buy,prices[i])

            profit = max(profit,(prices[i]-buy))

        return profit

# 136. Single Number
# Given a non-empty array of integers nums, every element appears twice except for one. Find that single one.
#
# You must implement a solution with a linear runtime complexity and use only constant extra space.
#
#
#
# Example 1:
#
# Input: nums = [2,2,1]
# Output: 1
# Example 2:
#
# Input: nums = [4,1,2,1,2]
# Output: 4
# Example 3:
#
# Input: nums = [1]
# Output: 1

class Solution(object): # Best Appraoch
    def singleNumber(self, nums):
        """
        :type nums: List[int]
        :rtype: int
        """

        a = 0

        for i in nums:
            a = a^i

        return a

# OR

class Solution:
    def singleNumber(self, nums: List[int]) -> int:
        # S
        items = []
        for i in nums:
            if i not in items:
                items.append(i)
            else:
                items.remove(i)
        return items.pop()


# 163. Missing Ranges
# You are given an inclusive range [lower, upper] and a sorted unique integer array nums, where all elements are in the inclusive range.
#
# A number x is considered missing if x is in the range [lower, upper] and x is not in nums.
#
# Return the smallest sorted list of ranges that cover every missing number exactly. That is, no element of nums is in any of the ranges, and each missing number is in one of the ranges.
#
# Each range [a,b] in the list should be output as:
#
# "a->b" if a != b
# "a" if a == b
#
#
# Example 1:
#
# Input: nums = [0,1,3,50,75], lower = 0, upper = 99
# Output: ["2","4->49","51->74","76->99"]
# Explanation: The ranges are:
# [2,2] --> "2"
# [4,49] --> "4->49"
# [51,74] --> "51->74"
# [76,99] --> "76->99"
# Example 2:
#
# Input: nums = [-1], lower = -1, upper = -1
# Output: []
# Explanation: There are no missing ranges since there are no missing numbers.

class Solution(object):
    def findMissingRanges(self, nums, lower, upper):
        """
        :type nums: List[int]
        :type lower: int
        :type upper: int
        :rtype: List[str]
        """

        res = []
        nums.append(upper+1) # include the enxt number of upper in the nums array
        for i in range(len(nums)):
            if lower == nums[i]:
                pass
            else:
                if nums[i] == lower+1:
                    res.append(str(lower)) # as Lower+1 matches with nums[i], hence lower is missing
                else:
                    res.append(str(lower)+"->"+str(nums[i]-1))

            lower = nums[i]+1 # reset the lower becasue nums[i] will already there and we have to validate the next number
        return res


# 169. Majority Element
# Given an array nums of size n, return the majority element.
#
# The majority element is the element that appears more than ⌊n / 2⌋ times. You may assume that the majority element always exists in the array.
#
#
#
# Example 1:
#
# Input: nums = [3,2,3]
# Output: 3
# Example 2:
#
# Input: nums = [2,2,1,1,1,2,2]
# Output: 2

class Solution(object):
    def majorityElement(self, nums):
        """
        :type nums: List[int]
        :rtype: int
        """
        size = len(nums)/2

        dix = {}
        for i in nums:
            if i in dix:
                dix[i] += 1
            else:
                dix[i] = 1

            if dix[i] > size:
                return i


# 217. Contains Duplicate
# Given an integer array nums, return true if any value appears at least twice in the array, and return false if every element is distinct.
#
#
#
# Example 1:
#
# Input: nums = [1,2,3,1]
# Output: true
# Example 2:
#
# Input: nums = [1,2,3,4]
# Output: false
# Example 3:
#
# Input: nums = [1,1,1,3,3,4,3,2,4,2]
# Output: true

class Solution(object):
    def containsDuplicate(self, nums):
        """
        :type nums: List[int]
        :rtype: bool
        """

        dix = {}

        for i in nums:
            if i in dix:
                dix[i] += 1
                if dix[i] > 1:
                    return True
            else:
                dix[i] = 1

# 268. Missing Number
# Given an array nums containing n distinct numbers in the range [0, n], return the only number in the range that is missing from the array.
#
#
#
# Example 1:
#
# Input: nums = [3,0,1]
# Output: 2
# Explanation: n = 3 since there are 3 numbers, so all numbers are in the range [0,3]. 2 is the missing number in the range since it does not appear in nums.
# Example 2:
#
# Input: nums = [0,1]
# Output: 2
# Explanation: n = 2 since there are 2 numbers, so all numbers are in the range [0,2]. 2 is the missing number in the range since it does not appear in nums.
# Example 3:
#
# Input: nums = [9,6,4,2,3,5,7,0,1]
# Output: 8
# Explanation: n = 9 since there are 9 numbers, so all numbers are in the range [0,9]. 8 is the missing number in the range since it does not appear in nums.

class Solution(object):
    def missingNumber(self, nums):
        """
        :type nums: List[int]
        :rtype: int
        """


        missing = len(nums)

        for i,x in enumerate(nums):
            missing = missing^(i^x)

        return missing

# 283. Move Zeroes
# Given an integer array nums, move all 0's to the end of it while maintaining the relative order of the non-zero elements.
#
# Note that you must do this in-place without making a copy of the array.
#
#
#
# Example 1:
#
# Input: nums = [0,1,0,3,12]
# Output: [1,3,12,0,0]
# Example 2:
#
# Input: nums = [0]
# Output: [0]

class Solution:
    def moveZeroes(self, nums: List[int]) -> None:
        """
        Do not return anything, modify nums in-place instead.
        """

        # S
        i = 0
        j = len(nums)-1

        while i < j:
            if nums[i] == 0:
                x = nums.pop(i)
                nums.append(x)
                j-=1
            else:
                i+=1

# 350. Intersection of Two Arrays II
# Given two integer arrays nums1 and nums2, return an array of their intersection. Each element in the result must appear as many times as it shows in both arrays and you may return the result in any order.
#
#
#
# Example 1:
#
# Input: nums1 = [1,2,2,1], nums2 = [2,2]
# Output: [2,2]
# Example 2:
#
# Input: nums1 = [4,9,5], nums2 = [9,4,9,8,4]
# Output: [4,9]
# Explanation: [9,4] is also accepted.

nums1.sort()
nums2.sort()

i = 0
j = 0
result = []
while i < len(nums1) and j < len(nums2):
    if nums1[i] == nums2[j]:
        result.append(nums1[i])
        i+=1
        j+=1
    elif nums1[i] <= nums2[j]:
        i+=1
    else:
        j+=1

return result

# 94. Binary Tree Inorder Traversal
# Given the root of a binary tree, return the inorder traversal of its nodes' values.

# Example 1:
#
# Input: root = [1,null,2,3]
# Output: [1,3,2]
# Example 2:
#
# Input: root = []
# Output: []
# Example 3:
#
# Input: root = [1]
# Output: [1]

# Definition for a binary tree node.
# class TreeNode(object):
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution(object):
    def inorderTraversal(self, root):
        """
        :type root: TreeNode
        :rtype: List[int]
        """
        output = []
        def inorder(root):
            if not root:
                return output
            inorder(root.left)
            print("root: ",root)
            output.append(root.val)
            inorder(root.right)

        inorder(root)
        return output

