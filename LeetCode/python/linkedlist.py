

# 234. Palindrome Linked List
# Given a singly linked list, determine if it is a palindrome.
#
# Example 1:
#
# Input: 1->2
# Output: false
# Example 2:
#
# Input: 1->2->2->1
# Output: true
#
# Solution:
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next
class Solution:             # O(n) and O(n)
    def isPalindrome(self, head: ListNode) -> bool:
        res = []
        node = head
        while node:
            res.append(node.val)
            node = node.next

        return res == res[::-1]

