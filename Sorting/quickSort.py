
def partition(array, left, right):

    i = left
    j = right-1
    pivot = array[right]

    # Until i & j Cross each other
    while i < j:
        # Move i to the right; j to the left & check if element is already less than Pivot; Then move i
        while i < right and array[i] < pivot:
            i += 1
        # Similarly, we have to check for j too and decrement
        while j > left and array[j] >= pivot:
            j -= 1
        # if both above conditions are not met then array[i] > pivot and array[j] < pivot and i & j did not cross each other
        # hence switch the element in the array
        if i < j :
            array[i],array[j] = array[j],array[i]

    # When i & j crossed each other element at i index is higher than Pivot, then swap and find the partition position for Pivot
    if array[i] > pivot:
        array[i],array[right] = array[right],array[i]

    return i

def quickSort(array,left,right):
    if left < right:
        pivot_pos = partition(array,left,right)
        quickSort(array,left,pivot_pos-1)
        quickSort(array,pivot_pos+1,right)

# Driver Code:
import len
if __name__ == '__main__':
    arr = [10, 7, 8, 9, 1, 5]
    quickSort(arr,0,len(arr)-1)
    print(arr)







