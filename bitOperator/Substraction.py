"""

How to subtract 5-4 = 1

5 = 101
4 = 100

In other word we can do 5+(-4)

Similarly, 101 - 100 can be converted as 101 + (-100)

Steps for substraction:

1. get the 2's complement of rightmost number
2. Append 1 on the left of the 2's complement
3. Add the number with the first number

Now, how do we get -100 i.e. 2's complement of 100

    1. 011
    2. 011 + 1 = 100
    3. prefix 1 with the result 2
    4. 101
     +1100
     --------
     10001 <======== is it correct the left most 1 ??

"""