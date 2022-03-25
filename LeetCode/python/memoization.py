"""
In computing, memoization is an optimization technique used primarily to speed up computer programs by
storing the results of expensive function calls and returning the cached result when the same inputs occur again.

Sometimes recursion may be very expensive like Fibonacci series, in that case we can use memoization.

Idea is store the value from the recent function calls, so that future function calls do not have to repeat the work.

Two ways we can implement memoization:
1. Implement Explicitly: Create a dictionary, check if the previous value is in dictionary, else compute, store in dictionary and return
2. Use builtin Python Tool:
    Import: from functools import lru_cache (LRU = Least Recently Used Cache)
    then use that decorator just before the function: @lru_cache(maxsize = 1000)


"""