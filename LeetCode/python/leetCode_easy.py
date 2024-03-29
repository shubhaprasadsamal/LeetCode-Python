# 1. Two Sum
# Easy
#
# 38811
#
# 1247
#
# Add to List
#
# Share
# Given an array of integers nums and an integer target, return indices of the two numbers such that they add up to target.
#
# You may assume that each input would have exactly one solution, and you may not use the same element twice.
#
# You can return the answer in any order.
#
#
#
# Example 1:
#
# Input: nums = [2,7,11,15], target = 9
# Output: [0,1]
# Explanation: Because nums[0] + nums[1] == 9, we return [0, 1].
# Example 2:
#
# Input: nums = [3,2,4], target = 6
# Output: [1,2]
# Example 3:
#
# Input: nums = [3,3], target = 6
# Output: [0,1]

class Solution(object):
    def twoSum(self, nums, target):
        """
        :type nums: List[int]
        :type target: int
        :rtype: List[int]
        """
        idx = {}
        for i in range(len(nums)):
            if target-nums[i] not in idx:
                idx[nums[i]] = i
            else:
                return [idx[target-nums[i]],i]
# 9. Palindrome Number
# Easy
#
# 7482
#
# 2323
#
# Add to List
#
# Share
# Given an integer x, return true if x is palindrome integer.
#
# An integer is a palindrome when it reads the same backward as forward.
#
# For example, 121 is a palindrome while 123 is not.
#
#
# Example 1:
#
# Input: x = 121
# Output: true
# Explanation: 121 reads as 121 from left to right and from right to left.
# Example 2:
#
# Input: x = -121
# Output: false
# Explanation: From left to right, it reads -121. From right to left, it becomes 121-. Therefore it is not a palindrome.
# Example 3:
#
# Input: x = 10
# Output: false
# Explanation: Reads 01 from right to left. Therefore it is not a palindrome.

class Solution:
    def isPalindrome(self, x: int) -> bool:

        lst = []

        if x < 0:
            return False

        while x > 0:
            rem = x % 10
            lst.append(rem)
            print(lst)
            x = x//10
        # print(lst[::-1])
        return lst == lst[::-1]

# 13. Roman to Integer
# Easy
#
# 7374
#
# 442
#
# Add to List
#
# Share
# Roman numerals are represented by seven different symbols: I, V, X, L, C, D and M.
#
# Symbol       Value
# I             1
# V             5
# X             10
# L             50
# C             100
# D             500
# M             1000
# For example, 2 is written as II in Roman numeral, just two ones added together. 12 is written as XII, which is simply X + II. The number 27 is written as XXVII, which is XX + V + II.
#
# Roman numerals are usually written largest to smallest from left to right. However, the numeral for four is not IIII. Instead, the number four is written as IV. Because the one is before the five we subtract it making four. The same principle applies to the number nine, which is written as IX. There are six instances where subtraction is used:
#
# I can be placed before V (5) and X (10) to make 4 and 9.
# X can be placed before L (50) and C (100) to make 40 and 90.
# C can be placed before D (500) and M (1000) to make 400 and 900.
# Given a roman numeral, convert it to an integer.
#
#
#
# Example 1:
#
# Input: s = "III"
# Output: 3
# Explanation: III = 3.
# Example 2:
#
# Input: s = "LVIII"
# Output: 58
# Explanation: L = 50, V= 5, III = 3.
# Example 3:
#
# Input: s = "MCMXCIV"
# Output: 1994
# Explanation: M = 1000, CM = 900, XC = 90 and IV = 4.

class Solution(object):
    def romanToInt(self, s):
        """
        :type s: str
        :rtype: int
        """
        mapper = {
            "I": 1,
            "V": 5,
            "X": 10,
            "L": 50,
            "C": 100,
            "D": 500,
            "M": 1000,
        }

        last_idx = len(s)-1
        i = 0
        total = mapper[s[last_idx]]
        # print(total)

        while i < last_idx:
            if mapper[s[last_idx]] <= mapper[s[last_idx-1]]:
                total += mapper[s[last_idx-1]]
            else:
                total -= mapper[s[last_idx-1]]
            last_idx -= 1

        return total

# 14. Longest Common Prefix
# Easy
#
# 10696
#
# 3438
#
# Add to List
#
# Share
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

class Solution:
    def longestCommonPrefix(self, strs: List[str]) -> str:

        res = ""
        first = strs[0]
        for i in range(1,len(strs)):
            if len(first) > len(strs[i]):
                first = strs[i]

        strs.remove(first)

        for i in range(len(first)):
            for j in range(1,len(strs)):
                if first[i] != strs[j][i]:
                    return res

            res += strs[j][i]

        return res

# 20. Valid Parentheses
# Easy
#
# 16066
#
# 805
#
# Add to List
#
# Share
# Given a string s containing just the characters '(', ')', '{', '}', '[' and ']', determine if the input string is valid.
#
# An input string is valid if:
#
# Open brackets must be closed by the same type of brackets.
# Open brackets must be closed in the correct order.
# Every close bracket has a corresponding open bracket of the same type.
#
#
# Example 1:
#
# Input: s = "()"
# Output: true
# Example 2:
#
# Input: s = "()[]{}"
# Output: true
# Example 3:
#
# Input: s = "(]"
# Output: false

class Solution:
    def isValid(self, s: str) -> bool:
        value = {"(": ")", "[": "]",  "{": "}"}
        open_para = set(["(","{","["])
        stack = []

        for i in s:

            if i in open_para:
                stack.append(i)

            elif stack and i == value[stack[-1]]:
                stack.pop()
            else:
                return False
        return stack == []

# 21. Merge Two Sorted Lists
# Easy
#
# 15319
#
# 1341
#
# Add to List
#
# Share
# You are given the heads of two sorted linked lists list1 and list2.
#
# Merge the two lists in a one sorted list. The list should be made by splicing together the nodes of the first two lists.
#
# Return the head of the merged linked list.
#
#
#
# Example 1:
#
#
# Input: list1 = [1,2,4], list2 = [1,3,4]
# Output: [1,1,2,3,4,4]
# Example 2:
#
# Input: list1 = [], list2 = []
# Output: []
# Example 3:
#
# Input: list1 = [], list2 = [0]
# Output: [0]

Iterative:

# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next
class Solution:
    def mergeTwoLists(self, list1: Optional[ListNode], list2: Optional[ListNode]) -> Optional[ListNode]:

        # Create a dummy Node
        dummy = ListNode()

        tail = dummy

        while list1 and list2:

            if list1.val <= list2.val:
                tail.next = list1
                list1 = list1.next
            else:
                tail.next = list2
                list2 = list2.next

            # Update the tail Pointer
            tail = tail.next

        if list1:
            tail.next = list1
        else:
            tail.next = list2

        return dummy.next

Recursion:

# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next
class Solution:
    def mergeTwoLists(self, list1: Optional[ListNode], list2: Optional[ListNode]) -> Optional[ListNode]:

        if list1 is None:
            return list2
        if list2 is None:
            return list1

        if list1.val <= list2.val:
            list1.next = self.mergeTwoLists(list1.next,list2)
            return list1
        else:
            list2.next = self.mergeTwoLists(list1,list2.next)
            return list2

# 26. Remove Duplicates from Sorted Array
# Easy
#
# 8426
#
# 12091
#
# Add to List
#
# Share
# Given an integer array nums sorted in non-decreasing order, remove the duplicates in-place such that each unique element appears only once. The relative order of the elements should be kept the same.
#
# Since it is impossible to change the length of the array in some languages, you must instead have the result be placed in the first part of the array nums. More formally, if there are k elements after removing the duplicates, then the first k elements of nums should hold the final result. It does not matter what you leave beyond the first k elements.
#
# Return k after placing the final result in the first k slots of nums.
#
# Do not allocate extra space for another array. You must do this by modifying the input array in-place with O(1) extra memory.
#
# Custom Judge:
#
# The judge will test your solution with the following code:
#
# int[] nums = [...]; // Input array
# int[] expectedNums = [...]; // The expected answer with correct length
#
# int k = removeDuplicates(nums); // Calls your implementation
#
# assert k == expectedNums.length;
# for (int i = 0; i < k; i++) {
# assert nums[i] == expectedNums[i];
# }
# If all assertions pass, then your solution will be accepted.
#
#
#
# Example 1:
#
# Input: nums = [1,1,2]
# Output: 2, nums = [1,2,_]
# Explanation: Your function should return k = 2, with the first two elements of nums being 1 and 2 respectively.
# It does not matter what you leave beyond the returned k (hence they are underscores).
# Example 2:
#
# Input: nums = [0,0,1,1,1,2,2,3,3,4]
# Output: 5, nums = [0,1,2,3,4,_,_,_,_,_]
# Explanation: Your function should return k = 5, with the first five elements of nums being 0, 1, 2, 3, and 4 respectively.
# It does not matter what you leave beyond the returned k (hence they are underscores).

class Solution:
    def removeDuplicates(self, nums: List[int]) -> int:
        left = 1 # A second pointer indicating the place where next unique value is going to come and sit in the list

        for right in range(1,len(nums)):

            if nums[right] != nums[right-1]:
                nums[left] = nums[right]
                left += 1

        return left

# 27. Remove Element
# Easy
#
# 4518
#
# 6251
#
# Add to List
#
# Share
# Given an integer array nums and an integer val, remove all occurrences of val in nums in-place. The relative order of the elements may be changed.
#
# Since it is impossible to change the length of the array in some languages, you must instead have the result be placed in the first part of the array nums. More formally, if there are k elements after removing the duplicates, then the first k elements of nums should hold the final result. It does not matter what you leave beyond the first k elements.
#
# Return k after placing the final result in the first k slots of nums.
#
# Do not allocate extra space for another array. You must do this by modifying the input array in-place with O(1) extra memory.
#
# Custom Judge:
#
# The judge will test your solution with the following code:
#
# int[] nums = [...]; // Input array
# int val = ...; // Value to remove
# int[] expectedNums = [...]; // The expected answer with correct length.
# // It is sorted with no values equaling val.
#
# int k = removeElement(nums, val); // Calls your implementation
#
# assert k == expectedNums.length;
# sort(nums, 0, k); // Sort the first k elements of nums
# for (int i = 0; i < actualLength; i++) {
# assert nums[i] == expectedNums[i];
# }
# If all assertions pass, then your solution will be accepted.
#
#
#
# Example 1:
#
# Input: nums = [3,2,2,3], val = 3
# Output: 2, nums = [2,2,_,_]
# Explanation: Your function should return k = 2, with the first two elements of nums being 2.
# It does not matter what you leave beyond the returned k (hence they are underscores).
# Example 2:
#
# Input: nums = [0,1,2,2,3,0,4,2], val = 2
# Output: 5, nums = [0,1,4,0,3,_,_,_]
# Explanation: Your function should return k = 5, with the first five elements of nums containing 0, 0, 1, 3, and 4.
# Note that the five elements can be returned in any order.
# It does not matter what you leave beyond the returned k (hence they are underscores).

class Solution:
    def removeElement(self, nums: List[int], val: int) -> int:

        size = len(nums)
        i = 0

        while i < size:
            if nums[i] == val:
                nums.pop(i)
                size -= 1
            else:
                i += 1

        return i

# 66. Plus One
# Easy
#
# 5490
#
# 4505
#
# Add to List
#
# Share
# You are given a large integer represented as an integer array digits, where each digits[i] is the ith digit of the integer. The digits are ordered from most significant to least significant in left-to-right order. The large integer does not contain any leading 0's.
#
# Increment the large integer by one and return the resulting array of digits.
#
#
#
# Example 1:
#
# Input: digits = [1,2,3]
# Output: [1,2,4]
# Explanation: The array represents the integer 123.
# Incrementing by one gives 123 + 1 = 124.
# Thus, the result should be [1,2,4].
# Example 2:
#
# Input: digits = [4,3,2,1]
# Output: [4,3,2,2]
# Explanation: The array represents the integer 4321.
# Incrementing by one gives 4321 + 1 = 4322.
# Thus, the result should be [4,3,2,2].
# Example 3:
#
# Input: digits = [9]
# Output: [1,0]
# Explanation: The array represents the integer 9.
# Incrementing by one gives 9 + 1 = 10.
# Thus, the result should be [1,0].

class Solution:
    def plusOne(self, digits: List[int]) -> List[int]:

        for i in reversed(range(len(digits))):

            if digits[i] != 9:
                digits[i] = digits[i]+1
                return digits
            else:
                digits[i] = 0

        return [1]+digits

# 69. Sqrt(x)
# Easy
#
# 4984
#
# 3601
#
# Add to List
#
# Share
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

class Solution:
    def mySqrt(self, x: int) -> int:

        if x ==0 or x == 1:
            return x

        left = 1
        right = x

        while left <= right:
            mid = (left +right)//2
            sqr = mid * mid

            if sqr == x:
                return mid
            elif sqr < x:
                left = mid + 1
                ans = mid # why we storing the ans here because there are two scenario when we can find a square root,
                # i.e. we can find the exact square root and another is we will not find the exact square root and
                # hence we have to satisfy with the nearest one. In the second case we will always find a number
                # whose square would be always smaller than the the number. we can't consider the number whose square
                # is more than our number
            else:
                right = mid -1

        return ans

# 70. Climbing Stairs
# Easy
#
# 14826
#
# 440
#
# Add to List
#
# Share
# You are climbing a staircase. It takes n steps to reach the top.
#
# Each time you can either climb 1 or 2 steps. In how many distinct ways can you climb to the top?
#
#
#
# Example 1:
#
# Input: n = 2
# Output: 2
# Explanation: There are two ways to climb to the top.
# 1. 1 step + 1 step
# 2. 2 steps
# Example 2:
#
# Input: n = 3
# Output: 3
# Explanation: There are three ways to climb to the top.
# 1. 1 step + 1 step + 1 step
# 2. 1 step + 2 steps
# 3. 2 steps + 1 step

# Space Optimisation technique!!!
# TC:- O(N) with NO EXTRA SPACE!!!

class Solution:
    def climbStairs(self, n: int) -> int:

        # S
        # This solution is like a fibonacci series i.e. for every nth staircase needs the sum of total ways in both n-1 and n-2 stares
        mapper = {1:1,2:2}

        if n == 1:
            return 1
        if n == 2:
            return 2

        a = 1
        b = 2

        for i in range(3,n+1):
            c = a + b
            a = b
            b = c

        return c

# 83. Remove Duplicates from Sorted List
# Easy
#
# 6029
#
# 212
#
# Add to List
#
# Share
# Given the head of a sorted linked list, delete all duplicates such that each element appears only once. Return the linked list sorted as well.
#
#
#
# Example 1:
#
#
# Input: head = [1,1,2]
# Output: [1,2]
# Example 2:
#
#
# Input: head = [1,1,2,3,3]
# Output: [1,2,3]

# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next
class Solution:
    def deleteDuplicates(self, head: Optional[ListNode]) -> Optional[ListNode]:

        curr = head
        while curr and curr.next:
            if curr.val == curr.next.val:
                curr.next = curr.next.next
            else:
                curr = curr.next

        return head

# 88. Merge Sorted Array
# Easy
#
# 8097
#
# 716
#
# Add to List
#
# Share
# You are given two integer arrays nums1 and nums2, sorted in non-decreasing order, and two integers m and n, representing the number of elements in nums1 and nums2 respectively.
#
# Merge nums1 and nums2 into a single array sorted in non-decreasing order.
#
# The final sorted array should not be returned by the function, but instead be stored inside the array nums1. To accommodate this, nums1 has a length of m + n, where the first m elements denote the elements that should be merged, and the last n elements are set to 0 and should be ignored. nums2 has a length of n.
#
#
#
# Example 1:
#
# Input: nums1 = [1,2,3,0,0,0], m = 3, nums2 = [2,5,6], n = 3
# Output: [1,2,2,3,5,6]
# Explanation: The arrays we are merging are [1,2,3] and [2,5,6].
# The result of the merge is [1,2,2,3,5,6] with the underlined elements coming from nums1.
# Example 2:
#
# Input: nums1 = [1], m = 1, nums2 = [], n = 0
# Output: [1]
# Explanation: The arrays we are merging are [1] and [].
# The result of the merge is [1].
# Example 3:
#
# Input: nums1 = [0], m = 0, nums2 = [1], n = 1
# Output: [1]
# Explanation: The arrays we are merging are [] and [1].
# The result of the merge is [1].
# Note that because m = 0, there are no elements in nums1. The 0 is only there to ensure the merge result can fit in nums1.

class Solution:
    def merge(self, nums1: List[int], m: int, nums2: List[int], n: int) -> None:
        """
        Do not return anything, modify nums1 in-place instead.
        """
        l = m+n-1
        l1 = m-1
        l2 = n-1

        while (l >= 0 and l1 >= 0 and l2 >= 0):
            if nums1[l1] <= nums2[l2]:
                # print("nums1[l1] & nums2[l2]: ",nums1[l1],nums2[l2])
                nums1[l] = nums2[l2]
                l2 -= 1
                # print("l2: ",l2)
                # print("nums1: ",nums1)
            else:
                # print("nums1[l1]: ",nums1[l1])
                nums1[l] = nums1[l1]
                l1 -= 1
                # print("nums1: ",nums1)

            l -= 1

        while  l2 > l1:
            nums1[l] = nums2[l2]
            l2 -= 1
            l -= 1

        return nums1

# 94. Binary Tree Inorder Traversal
# Easy
#
# 10010
#
# 474
#
# Add to List
#
# Share
# Given the root of a binary tree, return the inorder traversal of its nodes' values.
#
#
#
# Example 1:
#
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
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def inorderTraversal(self, root: Optional[TreeNode]) -> List[int]:

        output = []
        def inorder(root):
            if not root:
                return output

            inorder(root.left)
            output.append(root.val)
            inorder(root.right)


        inorder(root)
        return output

# 100. Same Tree
# Easy
#
# 7439
#
# 157
#
# Add to List
#
# Share
# Given the roots of two binary trees p and q, write a function to check if they are the same or not.
#
# Two binary trees are considered the same if they are structurally identical, and the nodes have the same value.
#
#
#
# Example 1:
#
#
# Input: p = [1,2,3], q = [1,2,3]
# Output: true
# Example 2:
#
#
# Input: p = [1,2], q = [1,null,2]
# Output: false
# Example 3:
#
#
# Input: p = [1,2,1], q = [1,1,2]
# Output: false

class Solution:
    def isSameTree(self, p: Optional[TreeNode], q: Optional[TreeNode]) -> bool:

        # p and q are both None
        if not p and not q:
            return True
        # one of p and q is None
        if not q or not p:
            return False
        if p.val != q.val:
            return False
        return self.isSameTree(p.right, q.right) and \
               self.isSameTree(p.left, q.left)

# 101. Symmetric Tree
# Easy
#
# 11432
#
# 260
#
# Add to List
#
# Share
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

class Solution:
    def isSymmetric(self, root: Optional[TreeNode]) -> bool:

        def isMirror(rLeft,rRight):

            if rLeft is None and rRight is None:
                return True
            elif rLeft is None or rRight is None:
                return False
            # elif rLeft and rRight:
            #     if rLeft.val == rRight.val and isMirror(rLeft.left,rRight.right) and isMirror(rLeft.right,rRight.left):
            elif rLeft.val == rRight.val and isMirror(rLeft.left,rRight.right) and isMirror(rLeft.right,rRight.left):
                # print(isMirror(rLeft.left,rRight.right))
                # print(isMirror(rLeft.right,rRight.left))
                return True

        return isMirror(root.left,root.right)

# 104. Maximum Depth of Binary Tree
# Easy
#
# 8827
#
# 143
#
# Add to List
#
# Share
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

# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def maxDepth(self, root: Optional[TreeNode]) -> int:

        height = 0
        if not root:
            return height
        queue = []
        queue.append(root)


        while queue:
            height += 1
            temp = []
            # node = queue.pop()
            # print(node.val)
            for node in queue:

                if node.left:
                    temp.append(node.left)
                if node.right:
                    temp.append(node.right)

            queue = temp

        return height

# 108. Convert Sorted Array to Binary Search Tree
# Easy
#
# 8463
#
# 426
#
# Add to List
#
# Share
# Given an integer array nums where the elements are sorted in ascending order, convert it to a height-balanced binary search tree.
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

# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def sortedArrayToBST(self, nums: List[int]) -> Optional[TreeNode]:

        def helper(l,r):
            if l > r:
                return None

            mid = (l+r)//2

            root = TreeNode(nums[mid])
            root.left = helper(l,mid-1)
            root.right = helper(mid+1,r)

            return root
        return helper(0,len(nums)-1)

# 112. Path Sum
# Easy
#
# 7356
#
# 888
#
# Add to List
#
# Share
# Given the root of a binary tree and an integer targetSum, return true if the tree has a root-to-leaf path such that adding up all the values along the path equals targetSum.
#
# A leaf is a node with no children.
#
#
#
# Example 1:
#
#
# Input: root = [5,4,8,11,null,13,4,7,2,null,null,null,1], targetSum = 22
# Output: true
# Explanation: The root-to-leaf path with the target sum is shown.
# Example 2:
#
#
# Input: root = [1,2,3], targetSum = 5
# Output: false
# Explanation: There two root-to-leaf paths in the tree:
# (1 --> 2): The sum is 3.
# (1 --> 3): The sum is 4.
# There is no root-to-leaf path with sum = 5.
# Example 3:
#
# Input: root = [], targetSum = 0
# Output: false
# Explanation: Since the tree is empty, there are no root-to-leaf paths.

# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def hasPathSum(self, root: Optional[TreeNode], targetSum: int) -> bool:
        if root is None:
            return False
        targetSum = targetSum-root.val

        if root.left is None and root.right is None:
            return targetSum == 0

        return (self.hasPathSum(root.left,targetSum) or self.hasPathSum(root.right,targetSum))

# 118. Pascal's Triangle
# Easy
#
# 8312
#
# 275
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

# [O(n^2)]
class Solution(object):
    def generate(self, numRows):
        """
        :type numRows: int
        :rtype: List[List[int]]
        """

        output = [[1]] # Defining/hardcode first row of the Triangle/fist element

        for i in range(numRows-1): # numRows-1 beacuse we have already hard coed the first element
            # create an array by adding 0 before and after of the last value output array for addition in the next step
            map1 = [0]+output[-1]+[0] #output[-1] is to pick up the last list from output
            map2 = []

            for j in range(len(map1)-1):
                map2.append(map1[j]+map1[j+1]) # Get the element by adding the consecutive elemenets of the previous array

            output.append(map2)

        return output

# Solution2 [Dynamic Programing] [O(n^2)]

class Solution:
    def generate(self, numRows: int) -> List[List[int]]:

        if numRows   == 0: return []
        elif numRows == 1: return [[1]]
        Tri = [[1]]
        for i in range(1,numRows):
            row = [1]
            for j in range(1,i):
                row.append(Tri[i-1][j-1] + Tri[i-1][j])
            row.append(1)
            Tri.append(row)
        return Tri

# 119. Pascal's Triangle II
# Easy
#
# 3256
#
# 283
#
# Add to List
#
# Share
# Given an integer rowIndex, return the rowIndexth (0-indexed) row of the Pascal's triangle.
#
# In Pascal's triangle, each number is the sum of the two numbers directly above it as shown:
#
#
#
#
# Example 1:
#
# Input: rowIndex = 3
# Output: [1,3,3,1]
# Example 2:
#
# Input: rowIndex = 0
# Output: [1]
# Example 3:
#
# Input: rowIndex = 1
# Output: [1,1]

class Solution:
    def getRow(self, rowIndex: int) -> List[int]:


        Tri = [[1]]
        numidx = rowIndex+1
        for i in range(1,numidx):
            row = [1]
            for j in range(1,i):
                row.append(Tri[i-1][j-1] + Tri[i-1][j])
            row.append(1)
            Tri.append(row)
        return Tri[rowIndex]

# 121. Best Time to Buy and Sell Stock
# Easy
#
# 21117
#
# 670
#
# Add to List
#
# Share
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

# Time complexity: O(n)O(n). Only a single pass is needed.
#
# Space complexity: O(1)O(1). Only two variables are used.


class Solution:
    def maxProfit(self, prices: List[int]) -> int:
        buy = prices[0]
        profit = 0
        for i in range(1,len(prices)):
            buy = min(buy,prices[i])

            if profit < prices[i]-buy:
                profit = prices[i]-buy

        return profit

# 136. Single Number
# Easy

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

# Approach 1: List operation

# Algorithm

# Iterate over all the elements in nums\text{nums}nums
# If some number in nums\text{nums}nums is new to array, append it
# If some number is already in the array, remove it

class Solution(object):
    def singleNumber(self, nums):
        """
        :type nums: List[int]
        :rtype: int
        """
        no_duplicate_list = []
        for i in nums:
            if i not in no_duplicate_list:
                no_duplicate_list.append(i)
            else:
                no_duplicate_list.remove(i)
        return no_duplicate_list.pop()

# Complexity Analysis


# Time complexity : O(n^2).
# We iterate through nums, taking O(n) time.
# We search the whole list to find whether there is duplicate number, taking O(n)O(n)O(n) time. Because search is in the for loop, so we have to multiply both time complexities which is O(n^2).

# Space complexity : O(n).
# We need a list of size n to contain elements in nums.

# Approach 2: Hash Table
# Algorithm

# We use hash table to avoid the O(n) time required for searching the elements.
# Iterate through all elements in nums and set up key/value pair.
# Return the element which appeared only once.

from collections import defaultdict
class Solution:
    def singleNumber(self, nums: List[int]) -> int:
        hash_table = defaultdict(int)
        for i in nums:
            hash_table[i] += 1

        for i in hash_table:
            if hash_table[i] == 1:
                return i

# Complexity Analysis

# Time complexity : O(n⋅1)=O(n).
#     Time complexity of for loop is O(n).
#     Time complexity of hash table(dictionary in python) operation pop is O(1).

# Space complexity : O(n).
#     The space required by hash_tablehash\_tablehash_table is equal to the number of elements in nums.


# Approach 3: Math
# Concept

# 2∗(a+b+c)−(a+a+b+b+c)=c2 * (a + b + c) - (a + a + b + b + c) = c2∗(a+b+c)−(a+a+b+b+c)=c

class Solution(object):
    def singleNumber(self, nums):
        """
        :type nums: List[int]
        :rtype: int
        """
        return 2 * sum(set(nums)) - sum(nums)

# Complexity Analysis

# Time complexity : O(n+n)=O(n).
#     sum will call next to iterate through nums. We can see it as sum(list(i, for i in nums)) which means the time complexity is O(n) because of the number of elements(n) in nums.

# Space complexity : O(n+n)=O(n).
#     set needs space for the elements in nums

# Approach 4: Bit Manipulation
# Concept

# If we take XOR of zero and some bit, it will return that bit
# a⊕0=a
# If we take XOR of two same bits, it will return 0
# a⊕a=0
# a⊕b⊕a=(a⊕a)⊕b=0⊕b=b
# So we can XOR all bits together to find the unique number.

class Solution(object):
    def singleNumber(self, nums):
        """
        :type nums: List[int]
        :rtype: int
        """
        a = 0
        for i in nums:
            a ^= i
        return a

# Complexity Analysis

# Time complexity : O(n).
#     We only iterate through nums, so the time complexity is the number of elements in nums.

# Space complexity : O(1).

# 163. Missing Ranges
# Easy
# 868
# 2.7K
# company
# Facebook
# company
# ByteDance
# company
# TikTok
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

# Time Complexity : O(n)
# Space Complexity: O(n)    # Validate with Someone

class Solution:
    def findMissingRanges(self, nums: List[int], lower: int, upper: int) -> List[str]:

        res = []
        nums.append(upper+1)
        for i in range(len(nums)):

            if lower == nums[i]:
                pass
            else:
                if nums[i] == lower+1:
                    res.append(str(lower))
                else:
                    res.append(str(lower)+"->"+str(nums[i]-1))


            lower = nums[i]+1

        return res

class Solution:
    def findMissingRanges(self, nums: List[int], lower: int, upper: int) -> List[str]:

        sol = []
        nums = [lower-1] + nums + [upper+1]

        for i in range(len(nums)-1):

            dif = nums[i+1]- nums[i]

            if dif ==2:
                sol.append(str(nums[i]+1))
            if dif >2:
                sol.append(str(nums[i]+1) + '->' + str(nums[i+1]-1) )

        return sol

# 169. Majority Element
# Easy
# 12.6K
# 406
# company
# Amazon
# company
# Google
# company
# Adobe
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

# Time Complexity : O(n)
# Space Complexity: O(n)

class Solution:
    def majorityElement(self, nums: List[int]) -> int:

        size = len(nums)/2
        # print(size)
        dict = {}
        for i in nums:
            if i not in dict.keys(): # We can also do : if i not in dict:
                dict[i] = 1
            else:
                dict[i] += 1

            if dict[i] > size:
                return i

# 171. Excel Sheet Column Number
# Easy
# 3.7K
# 305
# company
# Facebook
# company
# Microsoft
# company
# Google
# Given a string columnTitle that represents the column title as appears in an Excel sheet, return its corresponding column number.
#
# For example:
#
# A -> 1
# B -> 2
# C -> 3
# ...
# Z -> 26
# AA -> 27
# AB -> 28
# ...
#
#
# Example 1:
#
# Input: columnTitle = "A"
# Output: 1
# Example 2:
#
# Input: columnTitle = "AB"
# Output: 28

# Time complexity: O(n)
# Space complexity: O(1)

class Solution:
    def titleToNumber(self, columnTitle: str) -> int:

        # 'C' = 3 x 26**0 = 3 x 1 = 3
        # 'AB'= 1(for A) x 26**1 + 2(for B) x 26**0 = 26 x 2 = 28
        # Ordinate: this is will assign a number to a letter

        size = len(columnTitle)
        power = size
        res = 0

        for i in range(size):
            value = ord(columnTitle[i]) - ord("A") +1 # find the number that has to be assigned to letter
            power -= 1
            res += value * 26 ** power

        return res

# 217. Contains Duplicate
# Easy
# 7.2K
# 1K
# company
# Amazon
# company
# Apple
# company
# Bloomberg
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

# Time complexity: O(n)
# Space complexity: O(n)

class Solution:
    def containsDuplicate(self, nums: List[int]) -> bool:

        dict = {}

        for i in nums:
            if i in dict.keys():
                dict[i] += 1
            else:
                dict[i] = 1

            if dict[i] > 1:
                return True

# Solution: 2

# Time complexity: O(1)
# Space complexity: O(n)

class Solution:
    def containsDuplicate(self, nums: List[int]) -> bool:
        if len(nums) != len(set(nums)):
            return True


# 219. Contains Duplicate II
# Easy
# 4.1K
# 2.4K
# company
# Amazon
# company
# Facebook
# company
# Google
# Given an integer array nums and an integer k, return true if there are two distinct indices i and j in the array such that nums[i] == nums[j] and abs(i - j) <= k.
#
#
#
# Example 1:
#
# Input: nums = [1,2,3,1], k = 3
# Output: true
# Example 2:
#
# Input: nums = [1,0,1,1], k = 1
# Output: true
# Example 3:
#
# Input: nums = [1,2,3,1,2,3], k = 2
# Output: false

class Solution:
    def containsNearbyDuplicate(self, nums: List[int], k: int) -> bool:
# Time complexity: O(n)
# Space complexity: O(n)
#
# Idea that I took: if once True [abs(i - j) <= k] then return True else keep storing False and keep checking if any True comes up
dict = {}
res = False
for i in range(len(nums)):
    if nums[i] in dict.keys():
        if abs(i - dict[nums[i]]) > k:
            res = False
        else:
            return True
    dict[nums[i]] = i
return res

# Solution: 2

class Solution:
    def containsNearbyDuplicate(self, nums: List[int], k: int) -> bool:
        dic = {}
        for i, v in enumerate(nums):
            if v in dic and i - dic[v] <= k:
                return True
            dic[v] = i
        return False

# 268. Missing Number
# Easy
# 7.9K
# 3K
# company
# Amazon
# company
# Microsoft
# company
# Google
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

# Using same List
class Solution:
    def missingNumber(self, nums: List[int]) -> int:

        # Time complexity: O(n^2)
        # Space complexity: O(1)

        for i in range(len(nums)+1):
            if i not in nums:
                return i

# Using Hash Map
class Solution:
    def missingNumber(self, nums: List[int]) -> int:

        # Time complexity: O(n)
        # Space complexity: O(n)
        dict = {}
        for i in range(len(nums)):
            dict[nums[i]] = True

        for i in range(len(nums)+1):
            if i not in dict:
                return i

# Using bit operator
class Solution:
    def missingNumber(self, nums: List[int]) -> int:

        # Time complexity: O(n)
        # Space complexity: O(1)

        missing = len(nums)
        for i in range(len(nums)):
            missing = missing ^(i^nums[i])

        return missing










