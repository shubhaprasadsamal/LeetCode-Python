# 1480. Running Sum of 1d Array
#
# Given an array nums. We define a running sum of an array as runningSum[i] = sum(nums[0]…nums[i]).
# Return the running sum of nums.
# Example 1:
#
# Input: nums = [1,2,3,4]
# Output: [1,3,6,10]
# Explanation: Running sum is obtained as follows: [1, 1+2, 1+2+3, 1+2+3+4].

class Solution(object):
    def runningSum(self, nums):
        """
        :type nums: List[int]
        :rtype: List[int]
        """
        for i in range(len(nums)-1):
            print("i: ",i)
            nums[i+1] = nums[i] + nums[i+1]
        return nums


# 1431. Kids With the Greatest Number of Candies
# Given the array candies and the integer extraCandies, where candies[i] represents the number of candies that the ith kid has.
# For each kid check if there is a way to distribute extraCandies among the kids such that he or she can have the greatest number of candies among them. Notice that multiple kids can have the greatest number of candies.
# Example 1:
#
# Input: candies = [2,3,5,1,3], extraCandies = 3
# Output: [true,true,true,false,true]

class Solution(object):
    def kidsWithCandies(self, candies, extraCandies):

        large = max(candies)
        for i in range(len(candies)):
            if large-candies[i] <= extraCandies:
                candies[i] = True
            else:
                candies[i] = False
        return candies