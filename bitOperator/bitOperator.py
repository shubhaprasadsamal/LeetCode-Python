"""
No.	Binary Number
### #############
1	    1
2	    10
3	    11
4	    100
5	    101
6	    110
7	    111
8	    1000
9	    1001
10	1010
11	1011
12	1100
13	1101
14	1110
15	1111
16	10000
17	10001
18	10010
19	10011
20	10100
21	10101
22	10110
23	10111
24	11000
25	11001

Bit Operator:
#############

Operator	Example	    Meaning
&	        a & b	    Bitwise AND
|	        a | b	    Bitwise OR
^	        a ^ b	    Bitwise XOR (exclusive OR)
~	        ~a	        Bitwise NOT
<<	    a << n	    Bitwise left shift
>>	    a >> n	    Bitwise right shift

Operator	    Example	    Equivalent to
&=	        a &= b	    a = a & b
|=	        a |= b	    a = a | b
^=	        a ^= b	    a = a ^ b
<<=	        a <<= n	    a = a << n
>>=	        a >>= n	    a = a >> n

a	    b	aXORb(a^b)
#     #   #####
0	    0	  0
0	    1	  1
1	    0	  1
1	    1	  0

a	    b	aANDb(a&b)
#     #   #####
0	    0	  0
0	    1	  0
1	    0	  0
1	    1	  1

a	    b	aORb(a|b)
#     #   #####
0	    0	  0
0	    1	  1
1	    0	  1
1	    1	  1

a	  ~a (Inverse Operator)
#   #####
0	    1
0	    1
1	    0
1	    0

a	  a >> n (Bitwise right shift)
12  12 >> 2
#   #####
12 = 1100
12 >> 2 = 0011 (3)

5  5 >> 1
#   #####
5 = 101
5 >> 1 = 010 (2)

How can we use this one in Program/Algorithm:

when we say 5 >> 1, it's nothing but 5//2 in python and gives the same result
hence in the loop where ever we write 5//2, we can use this bit wise operator like 5 >> 1

a	  a << n (Bitwise left shift)
12  12 << 2
#   #####
12 = 1100
12 >> 2 = 110000 (48)


How can we use this one in Program/Algorithm:

when we say 3 << 1, it's nothing but 3 * 2 in python and gives the same result
3 = 11
6 = 110
12 = 1100
hence in the loop where ever we write 3 * 2, we can use this bit wise operator like 3 << 1


ODD or EVEN Number:
###################

Look at the below numbers and their corresponding binary:
Even:

2 = 10
4 = 100
6 = 110

Odd:

3 = 11
5 = 101
7 = 111

Hence, we noticed that all the even numbers ends with 0 and all the odd number ends with 1.

In order to find even or End we can use masking
Here the masking example that we are going to use is an & operation between number and 1 to find even/odd

7 = 111

  111
& 001
------
  001 <= if the right most number is 1 then 7 is a odd number

6 = 110

  110
& 001
------
  000 <= if the right most number is 0 then 6 is a even number

if a&1 == 0:
Number is even
else:
number is odd


Swap Two Numbers:
#################

a = 5
b = 7

result: a = 7; b = 5

temp = a
a = b
b = temp

In bitwise way:

a = 5 = 101
b = 7 = 111

a = a ^ b (XOR) [101 ^ 111 = 010 (2)]
b = a ^ b (XOR) [010 ^ 111 = 101 (5)]
b = a ^ b (XOR) [010 ^ 101 = 111 (7)]



"""