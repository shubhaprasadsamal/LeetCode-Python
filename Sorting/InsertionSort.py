# O(n^2)

def insertionSort(list):
    for i in range(1,len(list)):
        key = list[i]

        j = i-1

        while j >= 0 and key < list[j]:
            list[j+1] = list[j]
            j-=1
        list[j+1] = key


# Driver
arr = [12, 11, 13, 5, 6]
insertionSort(arr)

for i in range(len(arr)):
    print("% d" % arr[i])



