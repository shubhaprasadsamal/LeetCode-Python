# Dynamic Programming
# Dynamic Programming is mainly an optimization over plain recursion.
# Wherever we see a recursive solution that has repeated calls for same inputs
# we can optimize it using Dynamic Programming.
# The idea is to simply store the results of sub problems, so that we do not have to re-compute them when needed later.
# This simple optimization reduces time complexities from exponential to polynomial.
#
# For example, if we write simple recursive solution for Fibonacci Numbers,
# we get exponential time complexity and
# if we optimize it by storing solutions of sub problems, time complexity reduces to linear
#
# Ex:

# Regular way:

def fibonacci(n):
    a = 0
    b = 1
    res = []
    for i in range(n):
        res.append(a)
        a, b = b, a + b
    return res
# Driver
# if __name__ == '__main__':
#     res = fibonacci(10)
#     print(res)

# Recursion:
def fibonacci_recursive(n):
    if n <= 1:
        return n
    else:
        return fibonacci_recursive(n - 1) + fibonacci_recursive(n - 2)

#   This recursive approach is inefficient because it recalculates the Fibonacci numbers for smaller values repeatedly.
#   Resulting in exponential time complexity.

# Dynamic Programming Approach (Memoization)::

#   This approach uses memoization to store the results of intermediate Fibonacci numbers in the memo dictionary.
#   Preventing redundant computations. It has a time complexity of O(n).
def fibonacci_dynamic(n, memo={}):
    if n <= 1:
        return n

    # Check if the result for n is already computed and stored in the memo table
    if n not in memo:
        # If not, calculate and store the result in the memo table
        memo[n] = fibonacci_dynamic(n - 1, memo) + fibonacci_dynamic(n - 2, memo)

    return memo[n]


# Dynamic Programming Approach (Tabulation):

#   The tabulation approach builds a table (fib) from the bottom up
#   Storing solutions to sub problems in an array.
#   It also has a time complexity of O(n)
def fibonacci_tabulation(n):
    fib = [0] * (n + 1)
    fib[1] = 1

    for i in range(2, n + 1):
        fib[i] = fib[i - 1] + fib[i - 2]

    return fib

res = fibonacci_tabulation(5)
print(res)