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

"""