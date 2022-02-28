class Solution:
    def combine(self, n: int, k: int) -> List[List[int]]:
        output = []
        def worker(n,k,i,res):
            if len(res)==k:
                output.append(res[:])
                print("output: ",output)
            else:
                for x in range(i,n+1):
                    print("length res: ",len(res))
                    print("i: ",i)
                    print("x: ",x)
                    #                     if x<n+1 and i<k+1:

                    #                         if len(res)!=0 and res[0]==x:
                    #                             print("res[0]: ",res[0])
                    #                             print("res before append: ",res)
                    #                             continue
                    #                             print("res after append: ",res)
                    #                         else:
                    print("res before append in else: ",res)
                    res.append(x)
                    print("res after append in else: ",res)
                    # else:
                    #     break
                    worker(n,k,i+1,res)
                    print("res before pop: ",res)
                    print("i before pop: ",i)
                    print("x before pop: ",x)
                    res.pop()
                    print("res after pop: ",res)
                    print("i after pop: ",i)
                    print("x after pop: ",x)
        worker(n,k,1,[])
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


