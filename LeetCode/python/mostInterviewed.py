# 17. Letter Combinations of a Phone Number
#
# Given a string containing digits from 2-9 inclusive, return all possible letter combinations that the number could represent. Return the answer in any order.
#
# A mapping of digit to letters (just like on the telephone buttons) is given below. Note that 1 does not map to any letters.
#
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
#
# Solution: [Backtracking]

class Solution:
    def letterCombinations(self, digits: str) -> List[str]:
        map = {
            "2":["a","b","c"],
            "3":["d","e","f"],
            "4":["g","h","i"],
            "5":["j","k","l"],
            "6":["m","n","o"],
            "7":["p","q","r","s"],
            "8":["t","u","v"],
            "9":["w","x","y","z"]
        }

        output = []

        def worker(digits,i,res):
            if len(digits) == 0:
                return
            if i == len(digits):
                output.append("".join(res))
                # return
            else:
                for x in map[digits[i]]:
                    res.append(x)
                    worker(digits,i+1,res)
                    res.pop()

        worker(digits,0,[])
        return output

# 46. Permutations [BackTracking]
# Given an array nums of distinct integers, return all the possible permutations. You can return the answer in any order.
#
# Example 1:
#
# Input: nums = [1,2,3]
# Output: [[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]]
# Example 2:
#
# Input: nums = [0,1]
# Output: [[0,1],[1,0]]
# Example 3:
#
# Input: nums = [1]
# Output: [[1]]
#
# # Solution: [Backtracking]

class Solution:
    def permute(self, nums: List[int]) -> List[List[int]]:
        result = []
        def worknode(nums,i,prefix):

            if i == len(nums):
                result.append(prefix[:]) # Still have questions on [:]
                print("result: ",result)
                # return
            else:
                for j in range(i , len(nums)):
                    # print("j: ",j)
                    # print("i: ",i)
                    # print("first nums[i] before: ",nums[i])
                    # print("first nums[j] before: ",nums[j])
                    nums[i], nums[j] = nums[j], nums[i]
                    # print("first nums[i] after: ",nums[i])
                    # print("first nums[j] after: ",nums[j])
                    # print("prefix before: ",prefix)
                    prefix.append(nums[i])
                    # print("prefix After: ",prefix)
                    worknode(nums,i+1,prefix)
                    # print("After recusrion finishes j: ",j)
                    # print("After recusrion finishes i: ",i)
                    # print("prefix after recursion: ",prefix)
                    prefix.pop()
                    # print("prefix after pop: ",prefix)
                    # print("Second nums[i] before: ",nums[i])
                    # print("Second nums[j] before: ",nums[j])
                    nums[i], nums[j] = nums[j], nums[i]
                    # print("Second nums[i] after: ",nums[i])
                    # print("Second nums[j] after: ",nums[j])

        worknode(nums,0,[])
        return result

# 77. Combinations
#
# Given two integers n and k, return all possible combinations of k numbers out of the range [1, n].
#
# You may return the answer in any order.
#
# Example 1:
#
# Input: n = 4, k = 2
# Output:
# [
#     [2,4],
#     [3,4],
#     [2,3],
#     [1,2],
#     [1,3],
#     [1,4],
# ]
# Example 2:
#
# Input: n = 1, k = 1
# Output: [[1]]
#
# Solution:

class Solution:
    def combine(self, n: int, k: int) -> List[List[int]]:
        output = []
        def backtracking(i,res):
            if len(res)==k:
                output.append(res[:])
            else:
                for x in range(i, n+1):
                    res.append(x)
                    backtracking(x+1,res)
                    res.pop()

        backtracking(1,[])
        return output

# 79. Word Search
# Given an m x n grid of characters board and a string word, return true if word exists in the grid.
# The word can be constructed from letters of sequentially adjacent cells, where adjacent cells are horizontally or vertically neighboring. The same letter cell may not be used more than once.
#
# Input: board = [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], word = "ABCCED"
# Output: true
#
# Solution:

class Solution:
    def exist(self, board: List[List[str]], word: str) -> bool:

        ROWS = len(board)
        COLUMNS = len(board[0])
        visited = set()

        # Better to have backtracking function inside main function so that
        # all the base parameter can pass on to the function

        def backtracking(r,c,i):
            # if end of the string then True
            if i == len(word):
                # print("inside first True IF")
                return True     # If this executed then that loop will not come to add step anymore

            # if it become outof range and other false condition
            if r<0 or r == ROWS or c<0 or c == COLUMNS or board[r][c] != word[i] or (r,c) in visited:
                # print("inside second False IF")
                return False    # If this executed then that loop will not come to add step anymore
            visited.add((r,c))
            res =   (backtracking(r+1,c,i+1) or
                     backtracking(r,c+1,i+1) or
                     backtracking(r-1,c,i+1) or
                     backtracking(r,c-1,i+1))
            visited.remove((r,c))
            return res

        for r in range(ROWS):
            for c in range(COLUMNS):
                if backtracking(r,c,0): return True

        return False

# 22. Generate Parentheses
# Given n pairs of parentheses, write a function to generate all combinations of well-formed parentheses.
# Example 1:
# Input: n = 3
# Output: ["((()))","(()())","(())()","()(())","()()()"]
#
# Example 2:
# Input: n = 1
# Output: ["()"]

# Solution:

class Solution:
    def generateParenthesis(self, n: int) -> List[str]:

        output = []

        #left: Counter to count the open braces
        #right: Counter to count the close braces

        def backtracking(left,right,s):
            if len(s) == 2*n:
                output.append(s)
            else:
                # iteration to be continued until left counter is less than n
                # right counter can't be greater than left counter
                if left < n:
                    s += "("
                    backtracking(left+1,right,s)
                    s=s[:-1] # String pop from the end
                if left > right:
                    s+= ")"
                    backtracking(left,right+1,s)
                    s=s[:-1]

        backtracking(0,0,"")
        return output

# 78. Subsets
# Given an integer array nums of unique elements, return all possible subsets (the power set).
# The solution set must not contain duplicate subsets. Return the solution in any order.

class Solution:
    def subsets(self, nums: List[int]) -> List[List[int]]:

        output = []
        res = []
        def backtracking(i):
            if i >= len(nums[:]):
                output.append(res[:])

            for x in range(i,len(nums)):

                res.append(nums[x])
                backtracking(i+1)
                res.pop()
                backtracking(i+1)

        backtracking(0)
        return output


# 2. Add Two Numbers
# You are given two non-empty linked lists representing two non-negative integers. The digits are stored in reverse order, and each of their nodes contains a single digit. Add the two numbers and return the sum as a linked list.
# You may assume the two numbers do not contain any leading zero, except the number 0 itself.
#
# Input: l1 = [2,4,3], l2 = [5,6,4]
# Output: [7,0,8]
# Explanation: 342 + 465 = 807.
# Example 2:
#
# Input: l1 = [0], l2 = [0]
# Output: [0]
# Example 3:
#
# Input: l1 = [9,9,9,9,9,9,9], l2 = [9,9,9,9]
# Output: [8,9,9,9,0,0,0,1]


Solution: [not Recurssion but O(1)]

# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next
class Solution:
    def addTwoNumbers(self, l1: ListNode, l2: ListNode) -> ListNode:

        # Create dummy linked list
        output = ListNode(0)
        # Assign the head of the dummy list to curr
        curr = output
        carry = 0

        while l1 or l2 or carry:
            if l1:
                carry+=l1.val
                l1=l1.next
            if l2:
                carry+=l2.val
                l2=l2.next

            # add the summed element to the output linked list
            # Since curr is pointing to ListNode(0)
            # Hence will add the new element to curr.next
            curr.next = ListNode(carry%10)
            # reassign the curr to the curr.next for the next element to be added
            curr = curr.next
            carry = carry//10
        # return output.next bacause out is pointing to 0, but we need the afterwords element

        return output.next

# 206. Reverse Linked List [Iteration]
# Given the head of a singly linked list, reverse the list, and return the reversed list.
# Input: head = [1,2,3,4,5]
# Output: [5,4,3,2,1]
#
# Input: head = [1,2]
# Output: [2,1]
#
# Solutions:

# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next
class Solution:
    def reverseList(self, head: ListNode) -> ListNode:

        # We are not changing the linked list i.e. ListNode
        # We are not changing the value of the linked List i.e. val
        # We will just change the pointer of the linked List
        prev = None

        while head:

            # Store head value to temp beacuse we are breaking the link between head and head.next
            temp = head
            # Move the next element as head
            head = head.next
            # point temp's next to prev always i.e. will always add the element in backward
            temp.next = prev
            # move the prev to temp
            prev = temp
        return prev

# Solution 2  [Recursion]

# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next
class Solution:
    def reverseList(self, head: ListNode) -> ListNode:

        if not head:    # Base case
            return None
        newHead = head
        if head.next:
            newHead = self.reverseList(head.next)
            head.next.next = head

        head.next = None
        return newHead

# 21. Merge Two Sorted Lists
# Merge two sorted linked lists and return it as a sorted list.
# The list should be made by splicing together the nodes of the first two lists.
#
# Input: l1 = [1,2,4], l2 = [1,3,4]
# Output: [1,1,2,3,4,4]
#
# Solution [Iteration]

# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next
class Solution:
    def mergeTwoLists(self, l1: ListNode, l2: ListNode) -> ListNode:
        output = ListNode(0)
        curr = output

        while l1 and l2:
            if l1.val <= l2.val:
                curr.next = l1
                l1 = l1.next
            else:
                curr.next = l2
                l2 = l2.next
            curr = curr.next
        curr.next = l1 if l1 is not None else l2

        return output.next

# Solution: [Recursion]

# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next
class Solution:
    def mergeTwoLists(self, l1: ListNode, l2: ListNode) -> ListNode:
        if l1 is None:
            return l2
        elif l2 is None:
            return l1
        elif l1.val < l2.val:
            l1.next = self.mergeTwoLists(l1.next,l2)
            return l1
        else:
            l2.next = self.mergeTwoLists(l1,l2.next)
            return l2

# Solution [Iterative]:

class Solution:
    def myPow(self, x: float, n: int) -> float:

        if n == 0:
            return 1
        if n < 0:
            x, n = 1/x, -n

        prod, remain = x, 1

        while n > 1:
            if n % 2:
                remain *= prod
            prod = prod * prod
            n = n // 2
        return prod*remain

# 344. Reverse String
# Write a function that reverses a string. The input string is given as an array of characters s.
# Example 1:
#
# Input: s = ["h","e","l","l","o"]
# Output: ["o","l","l","e","h"]
#
# Solution[Iteration]

class Solution:
    def reverseString(self, s: List[str]) -> None:
        """
        Do not return anything, modify s in-place instead.
        """
        # return s[::-1]
        i = 0
        n = len(s)-1

        while i <= n//2:
            s[i],s[n-i] = s[n-i],s[i]
            i+=1

# Solution[Recursion]

class Solution:
    def reverseString(self, s: List[str]) -> None:
        """
        Do not return anything, modify s in-place instead.
        """
        n = len(s)-1
        def recursion(i):
            if i <= n//2:
                s[i],s[n-i] = s[n-i],s[i]
                recursion(i+1)
        return recursion(0)

