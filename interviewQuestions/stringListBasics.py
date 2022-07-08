# Convert number into strings:
##############################
# def convert(num):
#     converted_num_str = str(num)
#     converted_num_format = "{}".format(num)
#     converted_num_f = f'{num}'
#     print("converted_num_str type: ",type(converted_num_str))
#     print("converted_num_format type: ",type(converted_num_format))
#     print("converted_num_f type: ",type(converted_num_f))
#     return converted_num_str
#
# #for executing Ctrl+Shift+F10
# num = 123
# print(num)
# print(type(num))
# print(convert(num))

# Output:
# 123
# <class 'int'>
# converted_num_str type:  <class 'str'>
# converted_num_format type:  <class 'str'>
# converted_num_f type:  <class 'str'>
# 123

# Convert String into Number:
#############################

# Convert string into List:
###########################

# def convert(strs):
#     lst1 = strs.split(" ")
#     print("List1: ",lst1)
#     lst2 = strs.split()
#     print("List2: ",lst2)
#
#     lst = []
#     for i in strs:
#         lst.append(i)
#     print("List3: ",lst)
#
#
# strs = "abcd"
# convert(strs)
# strs = "I am Shitansu"
# convert(strs)

# Output:
# List1:  ['abcd']
# List2:  ['abcd']
# List3:  ['a', 'b', 'c', 'd']
# List1:  ['I', 'am', 'Shitansu']
# List2:  ['I', 'am', 'Shitansu']
# List3:  ['I', ' ', 'a', 'm', ' ', 'S', 'h', 'i', 't', 'a', 'n', 's', 'u']

# Convert List into String:
###########################
    # Type-1

# def convert(lst):
#     strs1 = " ".join(lst)
#     print("String1: ",strs1)
#
#
# lst1 = ['I', 'am', 'Shitansu']
# convert(lst1)

# Output:
# String1:  I am Shitansu


    # Type-2
def convert(lst):
    strs2 = ""
    for x in lst:
        strs2 += str(x)
    print("String2: ",strs2)
    print("String2 Type: ",type(strs2))

lst2 = [1, 2, 3]
convert(lst2)

# Output:
# String2:  123
# String2 Type:  <class 'str'>