# 412. Fizz Buzz
# Given an integer n, return a string array answer (1-indexed) where:
#
# answer[i] == "FizzBuzz" if i is divisible by 3 and 5.
# answer[i] == "Fizz" if i is divisible by 3.
# answer[i] == "Buzz" if i is divisible by 5.
# answer[i] == i (as a string) if none of the above conditions are true.
#
#
# Example 1:
#
# Input: n = 3
# Output: ["1","2","Fizz"]
# Example 2:
#
# Input: n = 5
# Output: ["1","2","Fizz","4","Buzz"]
# Example 3:
#
# Input: n = 15
# Output: ["1","2","Fizz","4","Buzz","Fizz","7","8","Fizz","Buzz","11","Fizz","13","14","FizzBuzz"]

class Solution:
    def fizzBuzz(self, n: int) -> List[str]:
        output = []
        for i in range(1,n+1):
            if i%3 == 0 and i%5 == 0:
                output.append("FizzBuzz")
            elif i%3 == 0:
                output.append("Fizz")
            elif i%5 == 0:
                output.append("Buzz")
            else:
                output.append(str(i))
        return output

# 14. Longest Common Prefix
# Write a function to find the longest common prefix string amongst an array of strings.
#
# If there is no common prefix, return an empty string "".
#
#
#
# Example 1:
#
# Input: strs = ["flower","flow","flight"]
# Output: "fl"
# Example 2:
#
# Input: strs = ["dog","racecar","car"]
# Output: ""
# Explanation: There is no common prefix among the input strings.


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

cclass Solution(object):
def missingNumber(self, nums):
    """
    :type nums: List[int]
    :rtype: int
    """

    # Note: We are going to subtract between the sum of all the index number and sum of all the numbers in nums and we will get the missing number. Everything is self explanatory except why missing = len(nums) ? Because when we iterate over nums we are acuatlly iterating upto n-1th index not nth index. nth index has to be added up and hence we are assigning the nth idex by finding len(nums) to the variable at the first place

    #         missing = len(nums)

    #         for i in range(len(nums)):
    #             missing += (i-nums[i])

    #         return missing

    # Note: XOR operation results 0 between two/more same digits and it don't depends on the order of the operation. Hence if we do [0,1,2,3]^[3,0,1] then we will get the result as 2. missing = len(nums) is also for the same reason.

    missing = len(nums)

    for i in range(len(nums)):
        missing = missing^(i^nums[i])

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

class Solution(object):
    def moveZeroes(self, nums):
        """
        :type nums: List[int]
        :rtype: None Do not return anything, modify nums in-place instead.
        """
        # Quick Sort
        # Idea here is to move all the non zero elements to the left
        l = 0 # set the left as 1st element of the list and iterate the right through out the list
        for r in range(len(nums)): # iterate the right through out the list
            if nums[r] != 0:    # validate if the right element is not 0 then swap the element with left and in creament the left
                nums[l],nums[r] = nums[r],nums[l]
                l += 1
        return nums

#   Second Method

        for i in range(len(nums)):
            if nums[i] == 0:
                temp = nums[i]
                nums.remove(nums[i]) # remove will remove the element by scanning the list starting from begining
                nums.append(temp)

        return nums

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

# 101. Symmetric Tree
# Given the root of a binary tree, check whether it is a mirror of itself (i.e., symmetric around its center).
#
#
#
# Example 1:
#
#
# Input: root = [1,2,2,3,4,4,3]
# Output: true
# Example 2:
#
#
# Input: root = [1,2,2,null,3,null,3]
# Output: false

# Definition for a binary tree node.
# class TreeNode(object):
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution(object):
    def isSymmetric(self, root):
        """
        :type root: TreeNode
        :rtype: bool
        """

        def isMirror(rLeft,rRight): # Take two arguments for left and right sode of root and compare
            if rLeft is None and rRight is None:
                return True
            elif rLeft is None or rRight is None:
                return False
            elif rLeft and rRight:
                if (rLeft.val == rRight.val) and isMirror(rLeft.left,rRight.right) and isMirror(rLeft.right,rRight.left): # Compare both the side values and position
                    return True

        return isMirror(root.left,root.right)

# 104. Maximum Depth of Binary Tree
# Given the root of a binary tree, return its maximum depth.
#
# A binary tree's maximum depth is the number of nodes along the longest path from the root node down to the farthest leaf node.
#
#
#
# Example 1:
#
#
# Input: root = [3,9,20,null,null,15,7]
# Output: 3
# Example 2:
#
# Input: root = [1,null,2]
# Output: 2

# Breadth First Search:
class Solution(object):
    def maxDepth(self, root):
        """
        :type root: TreeNode
        :rtype: int
        """
        queue = []
        height = 0

        if not root:
            return height
        queue.append(root)

        while queue:

            temp = []
            height += 1

            for node in queue:
                if node.left:
                    temp.append(node.left)
                if node.right:
                    temp.append(node.right)

            queue = temp

        return height

# Recurssion:
class Solution(object):
    def maxDepth(self, root):
        """
        :type root: TreeNode
        :rtype: int
        """
        if not root:
            return 0

        return 1+max(self.maxDepth(root.left),self.maxDepth(root.right))

# 202. Happy Number
# Write an algorithm to determine if a number n is happy.
#
# A happy number is a number defined by the following process:
#
# Starting with any positive integer, replace the number by the sum of the squares of its digits.
# Repeat the process until the number equals 1 (where it will stay), or it loops endlessly in a cycle which does not include 1.
# Those numbers for which this process ends in 1 are happy.
# Return true if n is a happy number, and false if not.
#
#
#
# Example 1:
#
# Input: n = 19
# Output: true
# Explanation:
# 12 + 92 = 82
# 82 + 22 = 68
# 62 + 82 = 100
# 12 + 02 + 02 = 1
# Example 2:
#
# Input: n = 2
# Output: false

class Solution(object):
    def isHappy(self, n):
        """
        :type n: int
        :rtype: bool
        """

        def square(n):
            total = 0
            while n > 0:
                r = n%10
                r = r ** 2
                total += r
                n = n//10
            return total

        mapper = set()
        while n not in mapper:
            mapper.add(n)
            n = square(n)
            if n == 1:
                return True

# 69. Sqrt(x)
# Given a non-negative integer x, compute and return the square root of x.
#
# Since the return type is an integer, the decimal digits are truncated, and only the integer part of the result is returned.
#
# Note: You are not allowed to use any built-in exponent function or operator, such as pow(x, 0.5) or x ** 0.5.
#
#
#
# Example 1:
#
# Input: x = 4
# Output: 2
# Example 2:
#
# Input: x = 8
# Output: 2
# Explanation: The square root of 8 is 2.82842..., and since the decimal part is truncated, 2 is returned.

class Solution(object):
    def mySqrt(self, x):
        """
        :type x: int
        :rtype: int
        """
        # By Binary Search

        if x == 0 or x == 1:
            return x

        start = 1
        end = x

        while start <= end:

            mid = (start + end)//2
            mid_sqr = mid * mid

            if mid_sqr == x:
                return mid
            if mid_sqr < x:
                start = mid+1
                ans = mid
            else:
                end = mid -1
        return ans

# 326. Power of Three
# Given an integer n, return true if it is a power of three. Otherwise, return false.
#
# An integer n is a power of three, if there exists an integer x such that n == 3x.
#
#
#
# Example 1:
#
# Input: n = 27
# Output: true
# Example 2:
#
# Input: n = 0
# Output: false
# Example 3:
#
# Input: n = 9
# Output: true

class Solution(object):
    def isPowerOfThree(self, n):
        """
        :type n: int
        :rtype: bool
        """
        # 27: 27/3 = 9(0) 9/3 = 3(0) 3/3 = 1
        # 10: 10/3 = 3(1)
        if n < 3 and n != 1:
            return False

        while n >= 3:
            if n%3 != 0:
                return False
            n = n/3

        return n == 1

# 191. Number of 1 Bits
# Write a function that takes an unsigned integer and returns the number of '1' bits it has (also known as the Hamming weight).
# Example 1:
#
# Input: n = 00000000000000000000000000001011
# Output: 3
# Explanation: The input binary string 00000000000000000000000000001011 has a total of three '1' bits.
# Example 2:
#
# Input: n = 00000000000000000000000010000000
# Output: 1
# Explanation: The input binary string 00000000000000000000000010000000 has a total of one '1' bit.

class Solution(object):
    def hammingWeight(self, n):
        """
        :type n: int
        :rtype: int
        """
        res = 0
        while n:
            if n&1 != 0: # n%2 != 0 | Lets' say 1011 & 0001 = 0001 hence not 0

                res += 1

            #update n
            n = n>>1 #n/2 to get the new n | 1011 >> 1 = 0101 (Then new n)

        return res

# 3. Longest Substring Without Repeating Characters
# Given a string s, find the length of the longest substring without repeating characters.
#
#
#
# Example 1:
#
# Input: s = "abcabcbb"
# Output: 3
# Explanation: The answer is "abc", with the length of 3.
# Example 2:
#
# Input: s = "bbbbb"
# Output: 1
# Explanation: The answer is "b", with the length of 1.
# Example 3:
#
# Input: s = "pwwkew"
# Output: 3
# Explanation: The answer is "wke", with the length of 3.
# Notice that the answer must be a substring, "pwke" is a subsequence and not a substring.

class Solution(object):
    def lengthOfLongestSubstring(self, s):
        """
        :type s: str
        :rtype: int
        """
        # Sliding window Method
        if len(s) == 0:
            return 0

        size = 0
        dix = {}
        start = 0   # start with 0th index

        for i in range(len(s)):
            if s[i] in dix and start <= dix[s[i]]: # start <= dix[s[i]]: Since dix[s[i]] gives the first index of the repeate value hence idea here is to satisfy else condition and get the updated size
                start = dix[s[i]] + 1 # increment the starting position by 1
            else:
                size = max(size,i-start+1) # i-start+1: the length of string between the index and the starting point
            dix[s[i]] = i # this will update the duplicate value's updated position

        return size

# Medium:
#########

# 22. Generate Parentheses
# Add to List
#
# Share
# Given n pairs of parentheses, write a function to generate all combinations of well-formed parentheses.
#
#
#
# Example 1:
#
# Input: n = 3
# Output: ["((()))","(()())","(())()","()(())","()()()"]
# Example 2:
#
# Input: n = 1
# Output: ["()"]

#BackTracking [When backtracking while we need the answer as all possible solution]
class Solution:
    def generateParenthesis(self, n: int) -> List[str]:

        # Backtracking beacause we have to find all possible solution
        # Idea is here that there would be n open parathesis and n close parathensis

        stack = []
        res = []

        def backtracking(openN,closeN):

            if openN == closeN == n: #when we have all the open parathensis and corresponding close parathensis then return
                res.append("".join(stack))
                return

            if openN > closeN: # when # of open parathesis is greater than # of close parathensis then add close parathensis
                stack.append(")")
                backtracking(openN,closeN+1)
                stack.pop()

            if openN < n: # when # of close parathesis is greater than # of open parathensis then add open parathensis
                stack.append("(")
                backtracking(openN+1,closeN)
                stack.pop()

        backtracking(0,0)
        return res

# 17. Letter Combinations of a Phone Number
# Given a string containing digits from 2-9 inclusive, return all possible letter combinations that the number could represent. Return the answer in any order.
#
# A mapping of digits to letters (just like on the telephone buttons) is given below. Note that 1 does not map to any letters.
# Example 1:
#
# Input: digits = "23"
# Output: ["ad","ae","af","bd","be","bf","cd","ce","cf"]
# Example 2:
#
# Input: digits = ""
# Output: []
# Example 3:
#
# Input: digits = "2"
# Output: ["a","b","c"]

class Solution(object):
    def letterCombinations(self, digits):
        """
        :type digits: str
        :rtype: List[str]
        """
        # Input: digits = "23"
        # Output: ["ad","ae","af","bd","be","bf","cd","ce","cf"]
        # BackTracking as we need all possible solution
        res = []
        digitsToChar = {"2":"abc","3":"def","4":"ghi","5":"jkl","6":"mno","7":"pqrs","8":"tuv","9":"wxyz"}

        def backtracking(i,curString):
            #   i = current digit inside the digits
            #   curString = form the string

            #   Base Case:
            #   If both the length are same
            if len(digits) == len(curString):
                res.append(curString)
                return # Need to understand why return ?


            for j in digitsToChar[digits[i]]:
                backtracking(i+1, curString + j)

        if digits:
            backtracking(0,"")

        return  res

# 49. Group Anagrams
# Given an array of strings strs, group the anagrams together. You can return the answer in any order.
#
# An Anagram is a word or phrase formed by rearranging the letters of a different word or phrase, typically using all the original letters exactly once.
# Example 1:
#
# Input: strs = ["eat","tea","tan","ate","nat","bat"]
# Output: [["bat"],["nat","tan"],["ate","eat","tea"]]
# Example 2:
#
# Input: strs = [""]
# Output: [[""]]
# Example 3:
#
# Input: strs = ["a"]
# Output: [["a"]]

class Solution(object):
    def groupAnagrams(self, strs):
        """
        :type strs: List[str]
        :rtype: List[List[str]]
        """

        # Brute force
        # Sorting method

        resDic = {}

        for i in strs:
            word = "".join(sorted(i)) # Sort the every single string

            if word in resDic:         # Check if sorted string is already there in dic as key
                resDic[word].append(i)  # append the original string into the list value of dic
            else:
                resDic[word] = [i]      #   if not present then insert the key and value as list
        print(resDic)       # {u'ant': [u'tan', u'nat'], u'abt': [u'bat'], u'aet': [u'eat', u'tea', u'ate']}
        return list(resDic.values()) # get only the dic values into a list

# 139. Word Break
# Given a string s and a dictionary of strings wordDict, return true if s can be segmented into a space-separated sequence of one or more dictionary words.
#
# Note that the same word in the dictionary may be reused multiple times in the segmentation.
#
#
#
# Example 1:
#
# Input: s = "leetcode", wordDict = ["leet","code"]
# Output: true
# Explanation: Return true because "leetcode" can be segmented as "leet code".
# Example 2:
#
# Input: s = "applepenapple", wordDict = ["apple","pen"]
# Output: true
# Explanation: Return true because "applepenapple" can be segmented as "apple pen apple".
# Note that you are allowed to reuse a dictionary word.
# Example 3:
#
# Input: s = "catsandog", wordDict = ["cats","dog","sand","and","cat"]
# Output: false

class Solution:
    def wordBreak(self, s: str, wordDict: List[str]) -> bool:
        # Dynamic Programming
        #Create a list of False of one length more and mark the last as True
        dp = [False]*(len(s)+1) #   [False, False, False, False, False, False, False, False, False]
        dp[len(s)] = True       #   [False, False, False, False, False, False, False, False, True]

        # Iterate the element of the string from end:
        for i in range(len(s)-1,-1, -1):
            # print("i: ",i)
            # match the word from wordDict with the sub words in s
            for w in wordDict:
                if (i+len(w)) <= len(s) and s[i:i+len(w)] == w:
                    # print("i+len(w): ",i+len(w))
                    # print("dp[i]: ",dp[i])
                    # print("dp[i+len(w)]: ",dp[i+len(w)])
                    # Assign last True value to dp[i]
                    dp[i] = dp[i+len(w)]
                if dp[i] == True:
                    break
        return dp[0]