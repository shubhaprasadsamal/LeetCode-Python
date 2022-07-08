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

3. Difference between List, Tuple, Set and Dictionary:





