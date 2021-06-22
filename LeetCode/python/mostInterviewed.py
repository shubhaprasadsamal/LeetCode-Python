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