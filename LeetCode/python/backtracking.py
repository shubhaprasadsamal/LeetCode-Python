# Backtracking - DFS
# Branch&Bound - BFS
# https://www.youtube.com/watch?v=DKCbsiDBN6c
# When we try to find out the all possible solution, we think of Backtracking but when we think of optimal solution
# we think of Dynamic programing.
#
# Back Tracking pseudo code Template:
#
# def backtrack(candidate):
#     if find_solution(candidate):
#         output(candidate)
#         return
#
#     # iterate all possible candidates.
#     for next_candidate in list_of_candidates:
#         if is_valid(next_candidate):
#             # try this partial candidate solution
#             place(next_candidate)
#             # given the candidate, explore further.
#             backtrack(next_candidate)
#             # backtrack
#             remove(next_candidate)


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

# 46. Permutations
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

# Output:
#
# j:  0
# i:  0
# first nums[i] before:  1
# first nums[j] before:  1
# first nums[i] after:  1
# first nums[j] after:  1
# prefix before:  []
# prefix After:  [1]
# j:  1
# i:  1
# first nums[i] before:  2
# first nums[j] before:  2
# first nums[i] after:  2
# first nums[j] after:  2
# prefix before:  [1]
# prefix After:  [1, 2]
# j:  2
# i:  2
# first nums[i] before:  3
# first nums[j] before:  3
# first nums[i] after:  3
# first nums[j] after:  3
# prefix before:  [1, 2]
# prefix After:  [1, 2, 3]
# result:  [[1, 2, 3]]			<====================
# After recusrion finishes j:  2
# After recusrion finishes i:  2
# prefix after recursion:  [1, 2, 3]
# prefix after pop:  [1, 2]		<====================
# Second nums[i] before:  3
# Second nums[j] before:  3
# Second nums[i] after:  3
# Second nums[j] after:  3
# After recusrion finishes j:  1		<====================
# After recusrion finishes i:  1		<====================
# prefix after recursion:  [1, 2]
# prefix after pop:  [1]			<====================
# Second nums[i] before:  2
# Second nums[j] before:  2
# Second nums[i] after:  2
# Second nums[j] after:  2
# j:  2
# i:  1
# first nums[i] before:  2
# first nums[j] before:  3
# first nums[i] after:  3
# first nums[j] after:  2
# prefix before:  [1]
# prefix After:  [1, 3]
# j:  2
# i:  2
# first nums[i] before:  2
# first nums[j] before:  2
# first nums[i] after:  2
# first nums[j] after:  2
# prefix before:  [1, 3]
# prefix After:  [1, 3, 2]
# result:  [[1, 2, 3], [1, 3, 2]]
# After recusrion finishes j:  2
# After recusrion finishes i:  2
# prefix after recursion:  [1, 3, 2]
# prefix after pop:  [1, 3]
# Second nums[i] before:  2
# Second nums[j] before:  2
# Second nums[i] after:  2
# Second nums[j] after:  2
# After recusrion finishes j:  2
# After recusrion finishes i:  1
# prefix after recursion:  [1, 3]
# prefix after pop:  [1]
# Second nums[i] before:  3
# Second nums[j] before:  2
# Second nums[i] after:  2
# Second nums[j] after:  3
# After recusrion finishes j:  0
# After recusrion finishes i:  0
# prefix after recursion:  [1]
# prefix after pop:  []
# Second nums[i] before:  1
# Second nums[j] before:  1
# Second nums[i] after:  1
# Second nums[j] after:  1
# j:  1
# i:  0
# first nums[i] before:  1
# first nums[j] before:  2
# first nums[i] after:  2
# first nums[j] after:  1
# prefix before:  []
# prefix After:  [2]
# j:  1
# i:  1
# first nums[i] before:  1
# first nums[j] before:  1
# first nums[i] after:  1
# first nums[j] after:  1
# prefix before:  [2]
# prefix After:  [2, 1]
# j:  2
# i:  2
# first nums[i] before:  3
# first nums[j] before:  3
# first nums[i] after:  3
# first nums[j] after:  3
# prefix before:  [2, 1]
# prefix After:  [2, 1, 3]
# result:  [[1, 2, 3], [1, 3, 2], [2, 1, 3]]
# After recusrion finishes j:  2
# After recusrion finishes i:  2
# prefix after recursion:  [2, 1, 3]
# prefix after pop:  [2, 1]
# Second nums[i] before:  3
# Second nums[j] before:  3
# Second nums[i] after:  3
# Second nums[j] after:  3
# After recusrion finishes j:  1
# After recusrion finishes i:  1
# prefix after recursion:  [2, 1]
# prefix after pop:  [2]
# Second nums[i] before:  1
# Second nums[j] before:  1
# Second nums[i] after:  1
# Second nums[j] after:  1
# j:  2
# i:  1
# first nums[i] before:  1
# first nums[j] before:  3
# first nums[i] after:  3
# first nums[j] after:  1
# prefix before:  [2]
# prefix After:  [2, 3]
# j:  2
# i:  2
# first nums[i] before:  1
# first nums[j] before:  1
# first nums[i] after:  1
# first nums[j] after:  1
# prefix before:  [2, 3]
# prefix After:  [2, 3, 1]
# result:  [[1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1]]
# After recusrion finishes j:  2
# After recusrion finishes i:  2
# prefix after recursion:  [2, 3, 1]
# prefix after pop:  [2, 3]
# Second nums[i] before:  1
# Second nums[j] before:  1
# Second nums[i] after:  1
# Second nums[j] after:  1
# After recusrion finishes j:  2
# After recusrion finishes i:  1
# prefix after recursion:  [2, 3]
# prefix after pop:  [2]
# Second nums[i] before:  3
# Second nums[j] before:  1
# Second nums[i] after:  1
# Second nums[j] after:  3
# After recusrion finishes j:  1
# After recusrion finishes i:  0
# prefix after recursion:  [2]
# prefix after pop:  []
# Second nums[i] before:  2
# Second nums[j] before:  1
# Second nums[i] after:  1
# Second nums[j] after:  2
# j:  2
# i:  0
# first nums[i] before:  1
# first nums[j] before:  3
# first nums[i] after:  3
# first nums[j] after:  1
# prefix before:  []
# prefix After:  [3]
# j:  1
# i:  1
# first nums[i] before:  2
# first nums[j] before:  2
# first nums[i] after:  2
# first nums[j] after:  2
# prefix before:  [3]
# prefix After:  [3, 2]
# j:  2
# i:  2
# first nums[i] before:  1
# first nums[j] before:  1
# first nums[i] after:  1
# first nums[j] after:  1
# prefix before:  [3, 2]
# prefix After:  [3, 2, 1]
# result:  [[1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1], [3, 2, 1]]
# After recusrion finishes j:  2
# After recusrion finishes i:  2
# prefix after recursion:  [3, 2, 1]
# prefix after pop:  [3, 2]
# Second nums[i] before:  1
# Second nums[j] before:  1
# Second nums[i] after:  1
# Second nums[j] after:  1
# After recusrion finishes j:  1
# After recusrion finishes i:  1
# prefix after recursion:  [3, 2]
# prefix after pop:  [3]
# Second nums[i] before:  2
# Second nums[j] before:  2
# Second nums[i] after:  2
# Second nums[j] after:  2
# j:  2
# i:  1
# first nums[i] before:  2
# first nums[j] before:  1
# first nums[i] after:  1
# first nums[j] after:  2
# prefix before:  [3]
# prefix After:  [3, 1]
# j:  2
# i:  2
# first nums[i] before:  2
# first nums[j] before:  2
# first nums[i] after:  2
# first nums[j] after:  2
# prefix before:  [3, 1]
# prefix After:  [3, 1, 2]
# result:  [[1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1], [3, 2, 1], [3, 1, 2]]
# After recusrion finishes j:  2
# After recusrion finishes i:  2
# prefix after recursion:  [3, 1, 2]
# prefix after pop:  [3, 1]
# Second nums[i] before:  2
# Second nums[j] before:  2
# Second nums[i] after:  2
# Second nums[j] after:  2
# After recusrion finishes j:  2
# After recusrion finishes i:  1
# prefix after recursion:  [3, 1]
# prefix after pop:  [3]
# Second nums[i] before:  1
# Second nums[j] before:  2
# Second nums[i] after:  2
# Second nums[j] after:  1
# After recusrion finishes j:  2
# After recusrion finishes i:  0
# prefix after recursion:  [3]
# prefix after pop:  []
# Second nums[i] before:  3
# Second nums[j] before:  1
# Second nums[i] after:  1
# Second nums[j] after:  3


# 47. Permutations II
# Given a collection of numbers, nums, that might contain duplicates, return all possible unique permutations in any order.
#
# Example 1:
#
# Input: nums = [1,1,2]
# Output:
# [[1,1,2],
#  [1,2,1],
#  [2,1,1]]
# Example 2:
#
# Input: nums = [1,2,3]
# Output: [[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]]
#
# Solution:

class Solution:
    def permuteUnique(self, nums: List[int]) -> List[List[int]]:

        output = []

        def worker(nums,i,res):
            if i == len(nums):
                output.append(res[:])
            else:
                dic = {}
                for x in range(i,len(nums)):
                    if nums[x] in dic:
                        break
                    else:
                        dic[nums[x]] = "leetcode"
                        nums[i],nums[x] = nums[x],nums[i]
                        res.append(nums[i])
                        worker(nums,i+1,res)
                        res.pop()
                        nums[i],nums[x] = nums[x],nums[i]

        worker(nums,0,[])
        return output

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
        def worker(i,res):
            if len(res)==k:
                output.append(res[:])
                print("output: ",output)
            else:

                for x in range(i,n+1):
                    print("length res: ",len(res))
                    print("i: ",i)
                    print("x: ",x)
                    print("res before append in else: ",res)
                    res.append(x)
                    print("res after append in else: ",res)

                    worker(x+1,res)
                    print("res before pop: ",res)
                    print("i before pop: ",i)
                    print("x before pop: ",x)
                    res.pop()
                    print("res after pop: ",res)
                    print("i after pop: ",i)
                    print("x after pop: ",x)
        worker(1,[])
        return output

# Output:
#
# length res:  0
# i:  1
# x:  1
# res before append in else:  []
# res after append in else:  [1]
# length res:  1
# i:  2
# x:  2
# res before append in else:  [1]
# res after append in else:  [1, 2]
# output:  [[1, 2]]
# res before pop:  [1, 2]
# i before pop:  2
# x before pop:  2
# res after pop:  [1]
# i after pop:  2
# x after pop:  2
# length res:  1
# i:  2
# x:  3
# res before append in else:  [1]
# res after append in else:  [1, 3]
# output:  [[1, 2], [1, 3]]
# res before pop:  [1, 3]
# i before pop:  2
# x before pop:  3
# res after pop:  [1]
# i after pop:  2
# x after pop:  3
# length res:  1
# i:  2
# x:  4
# res before append in else:  [1]
# res after append in else:  [1, 4]
# output:  [[1, 2], [1, 3], [1, 4]]
# res before pop:  [1, 4]
# i before pop:  2
# x before pop:  4
# res after pop:  [1]
# i after pop:  2
# x after pop:  4
# res before pop:  [1]
# i before pop:  1
# x before pop:  1
# res after pop:  []
# i after pop:  1
# x after pop:  1
# length res:  0
# i:  1
# x:  2
# res before append in else:  []
# res after append in else:  [2]
# length res:  1
# i:  3
# x:  3
# res before append in else:  [2]
# res after append in else:  [2, 3]
# output:  [[1, 2], [1, 3], [1, 4], [2, 3]]
# res before pop:  [2, 3]
# i before pop:  3
# x before pop:  3
# res after pop:  [2]
# i after pop:  3
# x after pop:  3
# length res:  1
# i:  3
# x:  4
# res before append in else:  [2]
# res after append in else:  [2, 4]
# output:  [[1, 2], [1, 3], [1, 4], [2, 3], [2, 4]]
# res before pop:  [2, 4]
# i before pop:  3
# x before pop:  4
# res after pop:  [2]
# i after pop:  3
# x after pop:  4
# res before pop:  [2]
# i before pop:  1
# x before pop:  2
# res after pop:  []
# i after pop:  1
# x after pop:  2
# length res:  0
# i:  1
# x:  3
# res before append in else:  []
# res after append in else:  [3]
# length res:  1
# i:  4
# x:  4
# res before append in else:  [3]
# res after append in else:  [3, 4]
# output:  [[1, 2], [1, 3], [1, 4], [2, 3], [2, 4], [3, 4]]
# res before pop:  [3, 4]
# i before pop:  4
# x before pop:  4
# res after pop:  [3]
# i after pop:  4
# x after pop:  4
# res before pop:  [3]
# i before pop:  1
# x before pop:  3
# res after pop:  []
# i after pop:  1
# x after pop:  3
# length res:  0
# i:  1
# x:  4
# res before append in else:  []
# res after append in else:  [4]
# res before pop:  [4]
# i before pop:  1
# x before pop:  4
# res after pop:  []
# i after pop:  1
# x after pop:  4

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

            # print("r: ",r)
            # print("c: ",c)
            # print("i: ",i)
            # print("board[r][c]: ",board[r][c])
            # print("word[i]: ",word[i])


            # if end of the string then True
            if i == len(word):
                # print("inside first True IF")
                return True     # If this executed then that loop will not come to add step anymore

            # if it become outof range and other false condition
            if r<0 or r == ROWS or c<0 or c == COLUMNS or board[r][c] != word[i] or (r,c) in visited:
                # print("inside second False IF")
                return False    # If this executed then that loop will not come to add step anymore

            # print("Before visited: ",visited)
            visited.add((r,c))
            # print("After visited: ",visited)
            res =   (backtracking(r+1,c,i+1) or
                     backtracking(r,c+1,i+1) or
                     backtracking(r-1,c,i+1) or
                     backtracking(r,c-1,i+1))
            # print("res: ",res)

            # print("Before visited remove: ",visited)
            visited.remove((r,c))
            # print("after visited remove: ",visited)
            return res

        for r in range(ROWS):
            for c in range(COLUMNS):
                # print("inside for r: ",r)
                # print("inside for c: ",c)
                if backtracking(r,c,0): return True

        return False

# 212. Word Search II [Need to learn about Data structure Trie for its optimal solution]
# https://www.youtube.com/watch?v=asbcE9mZz_U
#
# Given an m x n board of characters and a list of strings words, return all words on the board.
# Each word must be constructed from letters of sequentially adjacent cells, where adjacent cells are horizontally or vertically neighboring. The same letter cell may not be used more than once in a word.


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
                print("output: ",output)

            for x in range(i,len(nums)):
                print("i: ",i)
                print("x: ",x)

                res.append(nums[x])
                print("res: ",res)

                backtracking(i+1)
                res.pop()
                print("res after pop: ",res)
                print("i after pop: ",i)
                print("nums[x] after pop: ",nums[x])
                backtracking(i+1)

        backtracking(0)
        return output



