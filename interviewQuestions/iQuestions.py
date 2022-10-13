# 1. strs = "I am a boy"
# output = "boy a am I"

def reverse(strs):
    lst = strs.split()
    print("Lsts: ", lst)
    strs = " ".join(lst[::-1])
    return strs

strs = "I am a boy"
print(reverse(strs)) # boy a am I

# 2. phone = '3265847308'
# find the sum wich is going to be the addition of repetative numbers.
# sum = 3 + 8 = 11

def addition(strs):
    dix = {}
    sum  =0
    for i in strs:
        if i in dix:
            sum += int(i)
        else:
            dix[i] = 1
    return sum

strs = '3265847308'
print(addition(strs)) # 11

# 3. Difference between List, Tuple, Set and Dictionary:

# 4. input = ["uRow":{"uColumn":[12345,None,0,-1.23456,-2.865789,-3.1234,2.45555]}
#             "uRow":{"uColumn":[12845,None,1,-1.23856,-2.125789,-3.1934,2.41555]}]

# Ignore first two element in each list
# Hint: Use round(num,2) function
# Output: [[0,-1.23,-2.87,-3.12,2.45],
#          [1,-1.24,-2.12,-3.19,2.42]]

# 5. input = hello
# output = olleh
# Solve this problem with regular python list, iterative and recurssion method.





