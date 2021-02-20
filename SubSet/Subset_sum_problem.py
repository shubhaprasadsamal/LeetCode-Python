def subSet(A,B):
    n = len(A)
    print('n: ',n)
    L = ([[None for i in range(B+1)]
          for i in range(n+1)])
    print('L: ',L)
    for i in range(n+1):
        L[i][0] = True

    for j in range(B+1):
        L[0][j] = False

    for i in range(1,n+1):
        print('i: ',i)
        for j in range(1,B+1):
            print('j: ',j)
            print('A[i-1]: ',A[i-1])
            if j-A[i-1] < 0:
                print('i-1: ',i-1)
                print('L[i-1][j]: ',L[i-1][j])
                L[i][j] = L[i-1][j]
            else:
                print('[B-A[i]]: ',(B-A[i]))
                print('L[i-1][B-A[i]: ',L[i-1][B-A[i]])
                L[i][j] = L[i-1][j] or L[i-1][B-A[i]]

    if L[n][B]:
        m = n
        b = B
        s = set()

        while b>0:
            if L[m-1][b]:
                m = m-1
            else:
                m = m-1
                s.add()
                b = b-A[n]


        print('S: ', s)
    return L[n][B]

A = [1,2,3]
B = 3
x = subSet(A,B)
print(x)