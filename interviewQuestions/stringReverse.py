# Reverse a word string

def reverse(s):

    # SOl#1
    str = ""
    for i in reversed(range(len(s))):
        str += s[i]
    return str

    # SOl#2
    # return s[::-1]

    # SOl#3
    # str = ""
    # for i in s:
    #     str = i +str
    # return str

s = "Geeksforgeeks"
print(s)
print(reverse(s))


#

