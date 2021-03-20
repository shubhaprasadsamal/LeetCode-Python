# 953. Verifying an Alien Dictionary
#
# In an alien language, surprisingly they also use english lowercase letters, but possibly in a different order. The order of the alphabet is some permutation of lowercase letters.
#
# Given a sequence of words written in the alien language, and the order of the alphabet, return true if and only if the given words are sorted lexicographicaly in this alien language.
#
# Example 1:
#
# Input: words = ["hello","leetcode"], order = "hlabcdefgijkmnopqrstuvwxyz"
# Output: true
# Explanation: As 'h' comes before 'l' in this language, then the sequence is sorted.
# Example 2:
#
# Input: words = ["word","world","row"], order = "worldabcefghijkmnpqstuvxyz"
# Output: false
# Explanation: As 'd' comes after 'l' in this language, then words[0] > words[1], hence the sequence is unsorted.
# Example 3:
#
# Input: words = ["apple","app"], order = "abcdefghijklmnopqrstuvwxyz"
# Output: false
# Explanation: The first three characters "app" match, and the second string is shorter (in size.) According to lexicographical rules "apple" > "app", because 'l' > 'Ø', where 'Ø' is defined as the blank character which is less than any other character (More info).
#
#
# Solution:
class Solution:
    def isAlienSorted(self, words: List[str], order: str) -> bool:

        diction = {}    # Create an empty Dictionary for creating HASH Table
        for x,y in enumerate(order):
            diction[y] = x

        for i in range(len(words)-1):
            word1 = words[i]
            word2 = words[i+1]

            for x in range(min(len(word1),len(word2))):
                if word1[x] != word2[x]:
                    if diction[word1[x]] > diction[word2[x]]:
                        return False
                    break			# if diction[word1[x]] < diction[word2[x]] and to skip the else condition
                else:
                    if len(word1) > len(word2):
                        return False
        return True

# 680. Valid Palindrome II
# Given a non-empty string s, you may delete at most one character. Judge whether you can make it a palindrome.
#
# Example 1:
# Input: "aba"
# Output: True
# Example 2:
# Input: "abca"
# Output: True
# Explanation: You could delete the character 'c'.
#
# Solution:
#
# Time Complexity O(n2)
# Here, we loop through the string and find the sub strings to see if they satisfy pallindrum

class Solution:
    def validPalindrome(self, s: str) -> bool:
        for i in range(len(s)):  # both len(s) and len(s-1) is working?
            T = s[:i]+s[i+1:]
            if T == T[::-1]:
                return True

        return s == s[::-1]

# Less Time Complexity:
# Here, we check two adjacent letter and then keep increamenting the left side and decreamenting the right side to see if it's form an palidrum

class Solution:
    def validPalindrome(self, s: str) -> bool:
        l = 0
        r = len(s)-1

        while l < r:
            if s[l] == s[r]:
                l += 1
                r -= 1
            else:
                if s[l:r] == s[l:r][::-1] or s[l+1:r+1] == s[l+1:r+1][::-1]:
                    return True
            return True

#
# 14. Longest Common Prefix
#
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
#
# Hint:
# consider the length of the first word as minlength and iterate
#
#
# Solution:
class Solution:
    def longestCommonPrefix(self, strs: List[str]) -> str:
        if len(strs) == 0:
            return ""

        minlength = len(strs[0]) # Get the length of the first String and then compare to #find the min length
        for x in range(len(strs)):
            minlength = min(len(strs[x]),minlength) # Keep updating the minimum length

        j = 0
        output = ""
        while j < minlength:
            fisrtchar = strs[0][j]
            for i in range(1,len(strs)):
                if fisrtchar != strs[i][j]:
                    return output

            output += fisrtchar
            j+=1
        return output

#
# 415. Add Strings
# Given two non-negative integers num1 and num2 represented as string, return the sum of num1 and num2.
#
# Note:
#
# The length of both num1 and num2 is < 5100.
# Both num1 and num2 contains only digits 0-9.
# Both num1 and num2 does not contain any leading zero.
# You must not use any built-in BigInteger library or convert the inputs to integer directly.
#
#
# Solution:
# ord() will return a integer value representing the unicode code of a specified character

class Solution:
    def addStrings(self, num1: str, num2: str) -> str:
        len1 = len(num1)-1
        len2 = len(num2)-1
        carry = 0
        res = ""
        while len1>=0 or len2 >= 0 or carry>0:
            if len1 >= 0:
                carry+=(ord(num1[len1])-ord('0'))
                len1-=1
            if len2 >= 0:
                carry+=(ord(num2[len2])-ord('0'))
                len2-=1
            res = res+str(carry%10)
            carry = carry/10

        return res[::-1]
#
#
# 67. Add Binary
# Given two binary strings a and b, return their sum as a binary string.
#
# Example 1:
#
# Input: a = "11", b = "1"
# Output: "100"
# Example 2:
#
# Input: a = "1010", b = "1011"
# Output: "10101"
#
# Constraints:
#
# 1 <= a.length, b.length <= 104
# a and b consist only of '0' or '1' characters.
# Each string does not contain leading zeros except for the zero itself.
#
#
#
# Solution1:
class Solution:
    def addBinary(self, a: str, b: str) -> str:
        len1 = len(a)-1
        len2 = len(b)-1
        carry = 0
        res = ""
        while len1>=0 or len2>=0 or carry>0:
            if len1>=0:
                carry+=(ord(a[len1])-ord('0'))
                print(carry)
                len1-=1
            if len2>=0:
                carry+=(ord(b[len2])-ord('0'))
                len2-=1
            res += str(carry%2)
            carry = carry//2
        return res[::-1]


# Solution2:
class Solution:
    def addBinary(self, a: str, b: str) -> str:
        len1 = len(a)-1
        len2 = len(b)-1
        carry = 0
        res = []
        while len1>=0 or len2>=0 or carry>0:
            if len1>=0:
                carry+=(ord(a[len1])-ord('0'))
                # print(carry)
                len1-=1
            if len2>=0:
                carry+=(ord(b[len2])-ord('0'))
                len2-=1
            res.insert(0,carry%2) # Always add the char/int to the 0th position to form a sum result
            carry = carry//2
        return "".join(str(x) for x in res) # convert a List to String

#
# 125. Valid Palindrome
# Given a string, determine if it is a palindrome, considering only alphanumeric characters and ignoring cases.
# Note: For the purpose of this problem, we define empty string as valid palindrome.
#
# Example 1:
# Input: "A man, a plan, a canal: Panama"
# Output: true
# Example 2:
# Input: "race a car"
# Output: false
#
#
# Solution1:
class Solution:
    def isPalindrome(self, s: str) -> bool:
        start = 0
        end = len(s)-1
        res = ""

        while start <= end:
            if s[start].isalnum():
                res += s[start]
            start+=1

        resLower = res.lower()

        return resLower == resLower[::-1]


# Solution2:
class Solution:
    def isPalindrome(self, s: str) -> bool:
        filteredString = filter(lambda x: x.isalnum(),s)
        lowerString = map(lambda x: x.lower(),filteredString)

        lowerStringList = list(lowerString)

        return lowerStringList == lowerStringList[::-1]

#
# 88. Merge Sorted Array
# Given two sorted integer arrays nums1 and nums2, merge nums2 into nums1 as one sorted array.
# Note:
# The number of elements initialized in nums1 and nums2 are m and n respectively.
# You may assume that nums1 has enough space (size that is equal to m + n) to hold additional elements from nums2.
# Example:
# Input:
# nums1 = [1,2,3,0,0,0], m = 3
# nums2 = [2,5,6],       n = 3
# Output: [1,2,2,3,5,6]
#
# Hint: Create a new array with size m+n and compare between num1 and num2 and place it in new array
#
# Solutions:
class Solution:
    def merge(self, nums1: List[int], m: int, nums2: List[int], n: int) -> None:
        """
        Do not return anything, modify nums1 in-place instead.
        """
        p1 = m - 1
        p2 = n - 1
        # set pointer for nums1
        p = m + n - 1

        # while there are still elements to compare
        while p1 >= 0 and p2 >= 0:
            if nums1[p1] < nums2[p2]:
                nums1[p] = nums2[p2]
                p2 -= 1
            else:
                nums1[p] =  nums1[p1]
                p1 -= 1
            p -= 1

        # add missing elements from nums2
        while p2 > p1:  # Edge case when nums2 still have remaining element to be merged than nums1 EX: nums1=[7,8,9,0,0,0] m=3,nums2=[2,3,4] n=3
            nums1[p] = nums2[p2]
            p2 -= 1
            p -= 1
#
# 339. Nested List Weight Sum
# Given a nested list of integers, return the sum of all integers in the list weighted by their depth.
#
# Each element is either an integer, or a list -- whose elements may also be integers or other lists.
#
# Example 1:
#
# Input: [[1,1],2,[1,1]]
# Output: 10
# Explanation: Four 1's at depth 2, one 2 at depth 1.
# Example 2:
#
# Input: [1,[4,[6]]]
# Output: 27
# Explanation: One 1 at depth 1, one 4 at depth 2, and one 6 at depth 3; 1 + 4*2 + 6*3 = 27.
#
# Solution 1 (DFS Method):
class Solution:
    def depthSum(self, nestedList: List[NestedInteger]) -> int:
        #DFS way using Stack
        if not nestedList: return 0
        total = 0
        stack = [(l,1) for l in nestedList]

        while stack:
            item,index = stack.pop()
            value = item.getInteger() # Return the value of field as an integer

            if value is not None:
                total += value*index
            else:
                for x in item.getList():	# returns a list of values associated with form field name
                    stack.append((x,index+1))
        return total


# Solution 2 (Recursive Method):
class Solution:
    def depthSum(self, nestedList: List[NestedInteger]) -> int:
        return self.recurSum(nestedList,1)

    def recurSum(self,nestedList,index):
        total = 0
        for x in nestedList:
            if x.isInteger():
                total += x.getInteger()*index
            else:
                total += self.recurSum(x.getList(),index+1)

        return total

#
# 896. Monotonic Array
# An array is monotonic if it is either monotone increasing or monotone decreasing.
# An array A is monotone increasing if for all i <= j, A[i] <= A[j].  An array A is monotone decreasing if for all i <= j, A[i] >= A[j].
# Return true if and only if the given array A is monotonic.
#
# Example 1:
#
# Input: [1,2,2,3]
# Output: true
# Example 2:
#
# Input: [6,5,4,4]
# Output: true
# Example 3:
#
# Input: [1,3,2]
# Output: false
# Example 4:
#
# Input: [1,2,4,5]
# Output: true
# Example 5:
#
# Input: [1,1,1]
# Output: true
#
# Solution:
class Solution:
    def isMonotonic(self, A: List[int]) -> bool:
        increasing = True
        decreasing = True
        for i in range(len(A)-1):
            if A[i]> A[i+1]:
                increasing = False
            if A[i] < A[i+1]:
                decreasing = False

        return increasing or decreasing

# Result of exp1	Result of exp2	Result of exp1 or exp2
# True	True	True
# True	False	True
# False	True	True
# False	False	False

# 203. Remove Linked List Elements
# Remove all elements from a linked list of integers that have value val.
#
# Example:
#
# Input:  1->2->6->3->4->5->6, val = 6
# Output: 1->2->3->4->5
#
# Solution:
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next
class Solution:
    def removeElements(self, head: ListNode, val: int) -> ListNode:
        dummy = ListNode(None) #Create a virtual node to track the previous node of head
        dummy.next = head

        prev = dummy
        cur = head

        while cur:
            if cur.val == val:
                prev.next = cur.next
            else:
                prev = cur
            cur = cur.next

        return dummy.next # dummy has no value but dummy.next points to our whole linkedlist
#
#
# 1047. Remove All Adjacent Duplicates In String
# Given a string S of lowercase letters, a duplicate removal consists of choosing two adjacent and equal letters, and removing them.
# We repeatedly make duplicate removals on S until we no longer can.
# Return the final string after all such duplicate removals have been made.  It is guaranteed the answer is unique.
#
# Example 1:
#
# Input: "abbaca"
# Output: "ca"
# Explanation:
# For example, in "abbaca" we could remove "bb" since the letters are adjacent and equal, and this is the only possible move.  The result of this move is that the string is "aaca", of which only "aa" is possible, so the final string is "ca".
#
# Solution: (Using Stack)
class Solution:
    def removeDuplicates(self, S: str) -> str:
        stack = []
        for i in S:

            if stack and i == stack[-1]: # stack should not be empty, else stack[-1] will not work
                stack.pop()
            else:
                stack.append(i)

        return "".join(stack)

#
# 1539. Kth Missing Positive Number
# Given an array arr of positive integers sorted in a strictly increasing order, and an integer k.
#
# Find the kth positive integer that is missing from this array.
#
#
#
# Example 1:
#
# Input: arr = [2,3,4,7,11], k = 5
# Output: 9
# Explanation: The missing positive integers are [1,5,6,8,9,10,12,13,...]. The 5th missing positive integer is 9.
# Example 2:
#
# Input: arr = [1,2,3,4], k = 2
# Output: 6
# Explanation: The missing positive integers are [5,6,7,...]. The 2nd missing positive integer is 6.
#
# Hint:
# Let's say if there is no missing value and the array is a sorted then the array would have been: [1,2,3,4,5,6]
# let us create virtual list (virtual, because we will not compute it full, but only elements we need):
# B = [2 - 1, 3 - 2, 4 - 3, 7 - 4, 11 - 5, 12 - 6] = [1, 1, 1, 3, 6, 6].
# What this list represents is how many missing numbers we have for each inex: for first number we have missing number [1],
# for next two iterations also,
# when we add 7, we have 3 missing numbers: [1, 5, 6], when we add 11, we have 6 missing numbers: [1, 5, 6, 8, 9, 10].
# How we evalaute values of list B?
# Very easy, it is just A[i] - i - 1.
# What we need to find now in array B: first element, which is greater or equal than k. In our example, we have [1, 1, 1, 3, 6, 6]. We will find it with binary search:
#     this element have index end = 4. Finally, we need to go back to original data, we have
# arr = [2, 3, 4, 7, 11, 12]
# B = [1, 1, 1, 3, 6, 6]
# So, what we now know that our answer is between numbers 7 and 11 and it is equal to arr[end] - (B[end] - k + 1), where the second part is how many steps we need to make backward. Using B[end] = arr[end] - end - 1, we have end + k, we need to return.
#
# Solution:
class Solution:
    def findKthPositive(self, arr: List[int], k: int) -> int:

        beg, end = 0, len(arr)
        while beg < end:
            mid = (beg + end) // 2
            if arr[mid] - mid - 1 < k:
                beg = mid + 1
            else:
                end = mid
        return end + k

#
# 246. Strobogrammatic Number
# A strobogrammatic number is a number that looks the same when rotated 180 degrees (looked at upside down).
# Write a function to determine if a number is strobogrammatic. The number is represented as a string.
# Example 1:
#
# Input: num = "69"
# Output: true
# Example 2:
#
# Input: num = "88"
# Output: true
# Example 3:
#
# Input: num = "962"
# Output: false
# Example 4:
#
# Input: num = "1"
# Output: true
#
# Somutiion 1:
class Solution:  # Time Complexity O(N) and Space complexity O(1)
    def isStrobogrammatic(self, num: str) -> bool:
        rotatedDigit = {'0':'0',
                        '1':'1',
                        '8':'8',
                        '6':'9',
                        '9':'6'}

        left = 0
        right = len(num)-1

        while left < right:
            if num[left] not in rotatedDigit or rotatedDigit[num[left]] != num[right]:
                return False
            else:
                left += 1
                right -= 1

        return True

# Solution 2:
class Solution:
    def isStrobogrammatic(self, num: str) -> bool:

        rotated_digits = {'0': '0', '1': '1', '8': '8', '6': '9', '9': '6'}

        rotated_string_builder = []

        for c in reversed(num): # if we wont use reversed() then it will just swap the numbers which will not serve our purpose. We have to travers through from the tail end to start
            if c not in rotated_digits:
                return False
        rotated_string_builder.append(rotated_digits[c])

        rotated_string = "".join(rotated_string_builder)
        return rotated_string == num

#
# 1213. Intersection of Three Sorted Arrays
# Given three integer arrays arr1, arr2 and arr3 sorted in strictly increasing order, return a sorted array of only the integers that appeared in all three arrays.
# Example 1:
#
# Input: arr1 = [1,2,3,4,5], arr2 = [1,2,5,7,9], arr3 = [1,3,4,5,8]
# Output: [1,5]
# Explanation: Only 1 and 5 appeared in the three arrays.
#
# Solution:
class Solution:
    def arraysIntersection(self, arr1: List[int], arr2: List[int], arr3: List[int]) -> List[int]:
        res = []
        p1,p2,p3 = 0,0,0

        while p1<len(arr1) and p2<len(arr2) and p3<len(arr3):
            if arr1[p1] == arr2[p2] and arr2[p2] == arr3[p3]:
                res.append(arr1[p1])
                p1+=1
                p2+=1
                p3+=1
            else:
                if arr1[p1] < arr2[p2]:
                    p1+=1
                elif arr2[p2] < arr3[p3]:
                    p2+=1
                else:
                    p3+=1
        return res

#
# 766. Toeplitz Matrix
# Given an m x n matrix, return true if the matrix is Toeplitz. Otherwise, return false.
# A matrix is Toeplitz if every diagonal from top-left to bottom-right has the same elements.
#
# Input: matrix = [[1,2,3,4],[5,1,2,3],[9,5,1,2]]
# Output: true
# Explanation:
# In the above grid, the diagonals are:
# "[9]", "[5, 5]", "[1, 1, 1]", "[2, 2, 2]", "[3, 3]", "[4]".
# In each diagonal all elements are the same, so the answer is True.
#
# Solution:
class Solution:
    def isToeplitzMatrix(self, matrix: List[List[int]]) -> bool:
        for i in range(len(matrix)):
            for j in range(len(matrix[0])):
                if i>0 and j>0 and matrix[i][j]!=matrix[i-1][j-1]:
                    return False
        return True

# 844. Backspace String Compare
# Given two strings S and T, return if they are equal when both are typed into empty text editors. # means a backspace character.
# Note that after backspacing an empty text, the text will continue empty.
#
# Example 1:
# Input: S = "ab#c", T = "ad#c"
# Output: true
# Explanation: Both S and T become "ac".
# Example 2:
# Input: S = "ab##", T = "c#d#"
# Output: true
# Explanation: Both S and T become "".
# Example 3:
# Input: S = "a##c", T = "#a#c"
# Output: true
# Explanation: Both S and T become "c".
# Example 4:
# Input: S = "a#c", T = "b"
# Output: false
# Explanation: S becomes "c" while T becomes "b".
#
# Solution1:
class Solution:
    def backspaceCompare(self, S: str, T: str) -> bool:
        stack1 = []
        stack2 = []
        res1 = ''
        res2 = ''

        for i in S:
            # print(i)
            if i != '#':
                stack1.append(i)
            else:
                stack1.pop()
        # print(stack1)
        res1 = ''.join(stack1)

        for j in T:
            if j != '#':
                stack2.append(j)
            else:
                stack2.pop()
        res2 = ''.join(stack2)

        return res1 == res2

# Solution2:
class Solution:
    def backspaceCompare(self, S: str, T: str) -> bool:
        def build(S):
            stack1 = []
            res1 = ''

            for i in S:
                # print(i)
                if i != '#':
                    stack1.append(i)
                else:
                    stack1.pop()
            # print(stack1)
            res1 = ''.join(stack1)



        return build(S) == build(T)

#
# 724. Find Pivot Index
#
# Given an array of integers nums, write a method that returns the "pivot" index of this array.
# We define the pivot index as the index where the sum of all the numbers to the left of the index is equal to the sum of all the numbers to the right of the index.
# If no such index exists, we should return -1. If there are multiple pivot indexes, you should return the left-most pivot index.
#
# Example 1:
# Input: nums = [1,7,3,6,5,6]
# Output: 3
# Explanation:
# The sum of the numbers to the left of index 3 (nums[3] = 6) is equal to the sum of numbers to the right of index 3.
# Also, 3 is the first index where this occurs.
#
# Example 2:
# Input: nums = [1,2,3]
# Output: -1
# Explanation:
# There is no index that satisfies the conditions in the problem statement.
#
# Solution:
class Solution:
    def pivotIndex(self, nums: List[int]) -> int:
        S = sum(nums)
        left_sum = 0

        for i,x in enumerate(nums):
            if left_sum == (S-left_sum-x):
                return i
            left_sum += x
        return -1

# 283. Move Zeroes
# Given an array nums, write a function to move all 0's to the end of it while maintaining the relative order of the non-zero elements.
#
# Example:
# Input: [0,1,0,3,12]
# Output: [1,3,12,0,0]
#
# Solution:
class Solution:
    def moveZeroes(self, nums: List[int]) -> None:
        """
        Do not return anything, modify nums in-place instead.
        """
        start = 0
        end = len(nums)-1
        while start < end:
            if nums[start] == 0:
                x = nums.pop(start)
                nums += [x]
                end -= 1
            else:
                start += 1

# 824. Goat Latin
# A sentence S is given, composed of words separated by spaces. Each word consists of lowercase and uppercase letters only.
# We would like to convert the sentence to "Goat Latin" (a made-up language similar to Pig Latin.)
# The rules of Goat Latin are as follows:
# If a word begins with a vowel (a, e, i, o, or u), append "ma" to the end of the word.
# For example, the word 'apple' becomes 'applema'.
#
# If a word begins with a consonant (i.e. not a vowel), remove the first letter and append it to the end, then add "ma".
# For example, the word "goat" becomes "oatgma".
#
# Add one letter 'a' to the end of each word per its word index in the sentence, starting with 1.
#     For example, the first word gets "a" added to the end, the second word gets "aa" added to the end and so on.
# Return the final sentence representing the conversion from S to Goat Latin.
#
#
# Example 1:
#
# Input: "I speak Goat Latin"
# Output: "Imaa peaksmaaa oatGmaaaa atinLmaaaaa"
# Example 2:
#
# Input: "The quick brown fox jumped over the lazy dog"
# Output: "heTmaa uickqmaaa rownbmaaaa oxfmaaaaa umpedjmaaaaaa overmaaaaaaa hetmaaaaaaaa azylmaaaaaaaaa ogdmaaaaaaaaaa"
#
# Solution:
class Solution:
    def toGoatLatin(self, S: str) -> str:
        v = 'aeiouAEIOU'
        word = S.split() # This convertes the strings into list of elements with the words

        for x in range(len(word)):
            if word[x][0] in v:
                word[x] += 'ma'
            else:
                word[x] = word[x][1:]+word[x][0]+'ma'
            word[x] += 'a'* (x+1)
        return " ".join(word)


# 266. Palindrome Permutation:
# Given a string, determine if a permutation of the string could form a palindrome.
#
# Example 1:
# Input: "code"
# Output: false
#
# Example 2:
# Input: "aab"
# Output: true
#
# Example 3:
# Input: "carerac"
# Output: true
#
# Solution:
class Solution:
    def canPermutePalindrome(self, s: str) -> bool:
        # s = s.replace(" ","") # to remove any space in the string
        # s = s.lower()   # make all the letter as lower

        d = dict()
        for i in s:
            if i in d:
                d[i] = d[i]+1
            else:
                d[i] = 1

        odd_count = 0

        for i,j in d.items():
            if j % 2 != 0 and odd_count == 0:
                odd_count += 1
            elif j % 2 != 0 and odd_count != 0:
                return False

        return True


# 349. Intersection of Two Arrays
# Given two arrays, write a function to compute their intersection.
#
# Example 1:
#
# Input: nums1 = [1,2,2,1], nums2 = [2,2]
# Output: [2]
# Example 2:
#
# Input: nums1 = [4,9,5], nums2 = [9,4,9,8,4]
# Output: [9,4]
# Note:
#
# Each element in the result must be unique.
# The result can be in any order...

# Solutions:
class Solution:
    def intersection(self, nums1: List[int], nums2: List[int]) -> List[int]:

        set1 = set(nums1)
        set2 = set(nums2)

        return list(set1&set2)


# 1. Two Sum
# Given an array of integers nums and an integer target, return indices of the two numbers such that they add up to target.
#
# You may assume that each input would have exactly one solution, and you may not use the same element twice.
#
# You can return the answer in any order.
#
# Example 1:
#
# Input: nums = [2,7,11,15], target = 9
# Output: [0,1]
# Output: Because nums[0] + nums[1] == 9, we return [0, 1].
# Example 2:
#
# Input: nums = [3,2,4], target = 6
# Output: [1,2]
#
# Solution:
class Solution:
    def twoSum(self, nums: List[int], target: int) -> List[int]:

        map = dict()
        for x in range(len(nums)):
            diff = target - nums[x]
            if diff in map:
                return [map[diff],x]
            else:
                map[nums[x]] = x
        return

#
# 345. Reverse Vowels of a String
# Write a function that takes a string as input and reverse only the vowels of a string.
#
# Example 1:
#
# Input: "hello"
# Output: "holle"
# Example 2:
#
# Input: "leetcode"
# Output: "leotcede"
#
# Solution:
class Solution:
    def reverseVowels(self, s: str) -> str:
        if not s:
            return ''

        vowels = {'a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U'}

        lst = list(s)

        i = 0
        j = len(s) -1

        while i < j:
            if lst[i] in vowels and lst[j] in vowels:

                lst[i], lst[j] = lst[j], lst[i]
                i += 1
                j -= 1

            else:
                if lst[i] not in vowels:
                    i += 1
                if lst[j] not in vowels:
                    j -= 1

        return ''.join(lst)

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


# 228. Summary Ranges
# You are given a sorted unique integer array nums.
# Return the smallest sorted list of ranges that cover all the numbers in the array exactly. That is, each element of nums is covered by exactly one of the ranges, and there is no integer x such that x is in one of the ranges but not in nums.
# Each range [a,b] in the list should be output as:
#
# "a->b" if a != b
# "a" if a == b
#
# Example 1:
#
# Input: nums = [0,1,2,4,5,7]
# Output: ["0->2","4->5","7"]
# Explanation: The ranges are:
# [0,2] --> "0->2"
# [4,5] --> "4->5"
# [7,7] --> "7"
#
# Solution:
class Solution:
    def summaryRanges(self, nums: List[int]) -> List[str]:

        res = []
        if not nums:
            return res

        start,curr,end = nums[0],nums[0],None

        for n in nums[1:]:
            curr += 1
            if n == curr:
                end = n
            else:
                if not end:
                    res.append(str(start))
                else:
                    res.append(str(start)+"->"+str(end))

                start = n
                curr = n
                end = None

        if not end:			# This is for the last element when the iteration reach at the last element
            res.append(str(start))
        else:
            res.append(str(start)+"->"+str(end))

        return res


# 219. Contains Duplicate II
# Given an array of integers and an integer k, find out whether there are two distinct indices i and j in the array such that nums[i] = nums[j]
# and the absolute difference between i and j is at most k.
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
#
# Solution:
class Solution:
    def containsNearbyDuplicate(self, nums: List[int], k: int) -> bool:
        mapping = {}
        for i in range(len(nums)):
            if nums[i] in mapping and abs(mapping[nums[i]]-i)<=k:
                return True
            else:
                mapping[nums[i]] = i


# 20. Valid Parentheses
# Given a string s containing just the characters '(', ')', '{', '}', '[' and ']', determine if the input string is valid.
# An input string is valid if:
#
# Open brackets must be closed by the same type of brackets.
# Open brackets must be closed in the correct order.
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
# Example 4:
#
# Input: s = "([)]"
# Output: false
# Example 5:
#
# Input: s = "{[]}"
# Output: true
#
# Solution:
class Solution:
    def isValid(self, s: str) -> bool:
        openPara = []
        for i in range(len(s)):
            if self.isOpenPara(s[i]):
                openPara.append(s[i])
            else:
                if len(openPara) == 0:
                    return False
                op = openPara.pop()
                cl = s[i]
                if not self.isSameType(op,cl):
                    return False

        return len(openPara) == 0 #to check if number of open para are greater than close para


    def isOpenPara(self,p):
        if p == '[' or p == '{' or p == '(':
            return True
        else:
            return False

    def isSameType(self,op,cl):
        if op == '{' and cl == '}':
            return True
        elif op == '[' and cl == ']':
            return True
        elif op == '(' and cl == ')':
            return True
        else:
            return False

# Solution2:
class Solution:
    def isValid(self, s: str) -> bool:
        open = '({['
        dict = {')': '(', ']': '[', '}': '{'}
        stack = []
        for i in range(len(s)):
            if s[i] in open:
                stack.append(s[i])
            else:
                if stack:
                    if stack[-1] == dict[s[i]]:
                        stack.pop()
                    else:
                        return False
                else:
                    return False
        if stack != []:
            return False
        return True

# 66. Plus One
# Given a non-empty array of decimal digits representing a non-negative integer, increment one to the integer.
#
# The digits are stored such that the most significant digit is at the head of the list, and each element in the array contains a single digit.
#
# You may assume the integer does not contain any leading zero, except the number 0 itself.
# Example 1:
#
# Input: digits = [1,2,3]
# Output: [1,2,4]
# Explanation: The array represents the integer 123.
# Example 2:
#
# Input: digits = [4,3,2,1]
# Output: [4,3,2,2]
# Explanation: The array represents the integer 4321.
# Example 3:
#
# Input: digits = [0]
# Output: [1]
#
# Solution:
class Solution:
    def plusOne(self, digits: List[int]) -> List[int]:

        n = len(digits)
        for i in range(n):
            idx = n-1-i # iterate from the back of the digit

            if digits[idx] == 9:
                digits[idx] = 0
            else:
                digits[idx]+=1
                return digits
        return [1]+digits       # if all the digits are 9s


#
# 387. First Unique Character in a String
# Given a string, find the first non-repeating character in it and return its index. If it doesn't exist, return -1.
#
# Examples:
#
# s = "leetcode"
# return 0.
#
# s = "loveleetcode"
# return 2.
#
# Solution:
class Solution:
    def firstUniqChar(self, s: str) -> int:
        ptr = []
        for i in range(len(s)):
            if s[i] in ptr:
                continue
            else:
                if s[i] not in s[i+1:]:
                    return i
                else:
                    ptr.append(s[i])

        return -1


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
#
# Solution:
class Solution:
    def maxProfit(self, prices: List[int]) -> int:
        buy = prices[0]
        max_profit = 0

        for i in range(1,len(prices)):
            profit = prices[i] - buy

            if profit > max_profit:
                max_profit = profit

            if buy > prices[i]:
                buy = prices[i]

        return max_profit


# 7. Reverse Integer
# Given a signed 32-bit integer x, return x with its digits reversed. If reversing x causes the value to go outside the signed 32-bit integer
# range [-231, 231 - 1], then return 0.
#
# Assume the environment does not allow you to store 64-bit integers (signed or unsigned).
#
#
#
# Example 1:
#
# Input: x = 123
# Output: 321
# Example 2:
#
# Input: x = -123
# Output: -321
# Example 3:
#
# Input: x = 120
# Output: 21
# Example 4:
#
# Input: x = 0
# Output: 0
#
# Solution:
class Solution:
    def reverse(self, x: int) -> int:
        out = 0
        isNegetive = False

        if x < 0:               # convert all the negetive number to positive numebr
            isNegetive = True
            x = -1*x

        while x != 0:
            out = out*10 + x%10
            x = x//10

        if out > 2**31 -1 or -1*out < -2**31:
            return 0
        else:
            if isNegetive:
                return -1*out
            else:
                return out


# 206. Reverse Linked List
# Reverse a singly linked list.
#
# Example:
#
# Input: 1->2->3->4->5->NULL
# Output: 5->4->3->2->1->NULL
# Follow up:
#
# A linked list can be reversed either iteratively or recursively. Could you implement both?
#
# Solution:
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next
class Solution:
    def reverseList(self, head: ListNode) -> ListNode:
        prev = None

        while head:
            temp = head
            head = head.next
            temp.next = prev
            prev = temp
        return prev


# 605. Can Place Flowers
# You have a long flowerbed in which some of the plots are planted, and some are not. However, flowers
# cannot be planted in adjacent plots.
#
# Given an integer array flowerbed containing 0's and 1's, where 0 means empty and 1 means not empty,
# and an integer n, return if n new flowers can be planted in the flowerbed without violating the no-adjacent-flowers rule.
#
# Example 1:
#
# Input: flowerbed = [1,0,0,0,1], n = 1
# Output: true
# Example 2:
#
# Input: flowerbed = [1,0,0,0,1], n = 2
# Output: false
#
# Solution:
class Solution:
    def canPlaceFlowers(self, flowerbed: List[int], n: int) -> bool:
        count = 0
        flowerbed = [0]+flowerbed+[0]
        m = len(flowerbed)

        for i in range(1, m-1):
            if flowerbed[i]==flowerbed[i+1]==flowerbed[i-1]==0:
                count+=1
                flowerbed[i] = 1

        return n<=count

# 572. Subtree of Another Tree      [Amazon]
# Given two non-empty binary trees s and t, check whether tree t has exactly the same structure and node values with a subtree of s. A subtree of s is a tree consists of a node in s and all of this node's descendants. The tree s could also be considered as a subtree of itself.
#
# Example 1:
# Given tree s:
#
# 3
# / \
#     4   5
# / \
#     1   2
# Given tree t:
# 4
# / \
#     1   2
# Return true, because t has the same structure and node values with a subtree of s.
#
#
# Example 2:
# Given tree s:
#
# 3
# / \
#     4   5
# / \
#     1   2
# /
# 0
# Given tree t:
# 4
# / \
#     1   2
# Return false.

# Solution:

class Solution:
    def isSubtree(self, s: TreeNode, t: TreeNode) -> bool:
        if s is None and t is None:
            return True
        if t is None:       # Could be a child
            return True
        if s is None and t is not None:
            return False
        return self.isSame(s,t) or self.isSubtree(s.left,t) or self.isSubtree(s.right,t)     #'OR' because if any condition is true then it's a child tree

    def isSame(self,s,t):
        if s is None and t is None:
            return True
        if s is None or t is None:
            return False
        return s.val == t.val and self.isSame(s.left,t.left) and self.isSame(s.right,t.right)

# 937. Reorder Data in Log Files
# You are given an array of logs. Each log is a space-delimited string of words, where the first word is the identifier.
#
# There are two types of logs:
#
# Letter-logs: All words (except the identifier) consist of lowercase English letters.
#                                                                             Digit-logs: All words (except the identifier) consist of digits.
#     Reorder these logs so that:
#
# The letter-logs come before all digit-logs.
#     The letter-logs are sorted lexicographically by their contents. If their contents are the same, then sort them lexicographically by their identifiers.
#     The digit-logs maintain their relative ordering.
#     Return the final order of the logs.
#
#
#
#     Example 1:
#
# Input: logs = ["dig1 8 1 5 1","let1 art can","dig2 3 6","let2 own kit dig","let3 art zero"]
# Output: ["let1 art can","let3 art zero","let2 own kit dig","dig1 8 1 5 1","dig2 3 6"]
# Explanation:
# The letter-log contents are all different, so their ordering is "art can", "art zero", "own kit dig".
#     The digit-logs have a relative order of "dig1 8 1 5 1", "dig2 3 6".
#     Example 2:
#
# Input: logs = ["a1 9 2 3 1","g1 act car","zo4 4 7","ab1 off key dog","a8 act zoo"]
# Output: ["g1 act car","a8 act zoo","ab1 off key dog","a1 9 2 3 1","zo4 4 7"]
#
#
# Constraints:
#
# 1 <= logs.length <= 100
# 3 <= logs[i].length <= 100
# All the tokens of logs[i] are separated by a single space.
#                                                         logs[i] is guaranteed to have an identifier and at least one word after the identifier

# Solutions:

class Solution:
    def reorderLogFiles(self, logs: List[str]) -> List[str]:
        letter_log = []
        digit_log  = []
        #Split the logs into letter logs and digit logs
        for log in logs:
            if log.split(" ")[1].isalpha():
                letter_log.append(log)
            else:
                digit_log.append(log)

        #Sort the letter logs lexicographically based on the content and then the identifiers

        letter_log.sort(key=lambda x: (x.split(' ')[1:],x.split(' ')[0]))
        return letter_log + digit_log


# 21. Merge Two Sorted Lists
# Merge two sorted linked lists and return it as a sorted list. The list should be made by splicing together the nodes of the first two lists.
#
#
#
# Example 1:
#
#
# Input: l1 = [1,2,4], l2 = [1,3,4]
# Output: [1,1,2,3,4,4]
# Example 2:
#
# Input: l1 = [], l2 = []
# Output: []
# Example 3:
#
# Input: l1 = [], l2 = [0]
# Output: [0]

# Solution:
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next
class Solution:
    def mergeTwoLists(self, l1: ListNode, l2: ListNode) -> ListNode:
        prehead = ListNode(-1)

        prev = prehead
        while l1 and l2:
            if l1.val <= l2.val:
                prev.next = l1
                l1 = l1.next
            else:
                prev.next = l2
                l2 = l2.next
            prev = prev.next

        # At least one of l1 and l2 can still have nodes at this point, so connect
        # the non-null list to the end of the merged list.
        prev.next = l1 if l1 is not None else l2

        return prehead.next

# 819. Most Common Word
# Given a paragraph and a list of banned words, return the most frequent word that is not in the list of banned words.  It is guaranteed there is at least one word that isn't banned, and that the answer is unique.
#
# Words in the list of banned words are given in lowercase, and free of punctuation.  Words in the paragraph are not case sensitive.  The answer is in lowercase.
#
#
#
# Example:
#
# Input:
# paragraph = "Bob hit a ball, the hit BALL flew far after it was hit."
# banned = ["hit"]
# Output: "ball"
# Explanation:
# "hit" occurs 3 times, but it is a banned word.
# "ball" occurs twice (and no other word does), so it is the most frequent non-banned word in the paragraph.
# Note that words in the paragraph are not case sensitive,
# that punctuation is ignored (even if adjacent to words, such as "ball,"),
# and that "hit" isn't the answer even though it occurs more because it is banned.
#
# Solution:

class Solution:
    def mostCommonWord(self, paragraph: str, banned: List[str]) -> str:
        paragraph = "".join(char.lower() if char.isalnum() else ' ' for char in paragraph)
        words = paragraph.split()
        mapper = {}
        banned = {word.lower() for word in banned}
        count = 0
        res = ""
        for word in words:
            if word not in banned:
                if word not in mapper:
                    mapper[word] = 1
                else:
                    mapper[word] += 1
                if mapper[word] > count:
                    count = mapper[word]
                    res = word
        return res

# 1710. Maximum Units on a Truck
# You are assigned to put some amount of boxes onto one truck. You are given a 2D array boxTypes, where boxTypes[i] = [numberOfBoxesi, numberOfUnitsPerBoxi]:
#
# numberOfBoxesi is the number of boxes of type i.
# numberOfUnitsPerBoxi is the number of units in each box of the type i.
# You are also given an integer truckSize, which is the maximum number of boxes that can be put on the truck. You can choose any boxes to put on the truck as long as the number of boxes does not exceed truckSize.
#
# Return the maximum total number of units that can be put on the truck.
#
#
#
# Example 1:
#
# Input: boxTypes = [[1,3],[2,2],[3,1]], truckSize = 4
# Output: 8
# Explanation: There are:
# - 1 box of the first type that contains 3 units.
# - 2 boxes of the second type that contain 2 units each.
# - 3 boxes of the third type that contain 1 unit each.
# You can take all the boxes of the first and second types, and one box of the third type.
# The total number of units will be = (1 * 3) + (2 * 2) + (1 * 1) = 8.
# Example 2:
#
# Input: boxTypes = [[5,10],[2,5],[4,7],[3,9]], truckSize = 10
# Output: 91
#
# Solution:

class Solution:
    def maximumUnits(self, boxTypes: List[List[int]], truckSize: int) -> int:
        boxTypes.sort(key=lambda x:x[1],reverse=1)
        s=0
        for i,j in boxTypes:
            i=min(i,truckSize)  # in order not to exceed Trusk size
            s+=i*j
            truckSize-=i
            if truckSize==0:
                break
        return s




