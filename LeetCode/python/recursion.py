# Recursion could be an elegant and intuitive solution, when applied properly. Nevertheless,
# sometimes, one might have to convert a recursive algorithm to iterative one for various reasons.
#     Risk of Stackoverflow
#     Efficiency
#     Complexity
#
# The good news is that we can always convert a recursion to iteration. In order to do so,
# in general, we use a data structure of stack or queue,
# which replaces the role of the system call stack during the process of recursion.

# In Recursion functions gets called in the manner of call STACK i.e. last in first out.

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

        if not head:
            return None
        newHead = head
        print("newHead: ",newHead)
        print("head.next: ",head.next)
        if head.next:
            print("newHead before assign: ",newHead)
            newHead = self.reverseList(head.next)
            print("newHead after assign: ",newHead)
            print("head after assignment: ",head)
            print("head.next after assignment: ",head.next)
            print("head.next.next after assignment: ",head.next.next)
            head.next.next = head

        head.next = None
        return newHead

# input: [1,2,3]
# newHead:  ListNode{val: 1, next: ListNode{val: 2, next: ListNode{val: 3, next: None}}}
# head.next:  ListNode{val: 2, next: ListNode{val: 3, next: None}}
# newHead before assign:  ListNode{val: 1, next: ListNode{val: 2, next: ListNode{val: 3, next: None}}}
# newHead:  ListNode{val: 2, next: ListNode{val: 3, next: None}}
# head.next:  ListNode{val: 3, next: None}
# newHead before assign:  ListNode{val: 2, next: ListNode{val: 3, next: None}}
# newHead:  ListNode{val: 3, next: None}
# head.next:  None
# newHead after assign:  ListNode{val: 3, next: None}
# head after assignment:  ListNode{val: 2, next: ListNode{val: 3, next: None}}
# head.next after assignment:  ListNode{val: 3, next: None}
# head.next.next after assignment:  None
# newHead after assign:  ListNode{val: 3, next: ListNode{val: 2, next: None}}
# head after assignment:  ListNode{val: 1, next: ListNode{val: 2, next: None}}
# head.next after assignment:  ListNode{val: 2, next: None}
# head.next.next after assignment:  None

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

# 50. Pow(x, n)
# Implement pow(x, n), which calculates x raised to the power n (i.e., xn).
#
# Example 1:
# Input: x = 2.00000, n = 10
# Output: 1024.00000
# Example 2:
# Input: x = 2.10000, n = 3
# Output: 9.26100
#
# Solution [Recursion]:

class Solution:
    def myPow(self, x: float, n: int) -> float:

        if n == 0:
            return 1.0
        elif n < 0:
            return self.myPow(1/x,-n)
        elif n%2 == 0:
            temp =  self.myPow(x,n/2) # pow(2,10) = pow(2,5) * pow(2,5) to have < O(n) time complexity
            return temp*temp
        else:
            return x*self.myPow(x,n-1) # pow(2,9) = 2*pow(2,8) | if n is Odd.

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


