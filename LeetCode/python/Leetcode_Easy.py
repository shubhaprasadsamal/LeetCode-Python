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
        left = 1

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
                ans = mid
            else:
                right = mid -1
                # ans = mid

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