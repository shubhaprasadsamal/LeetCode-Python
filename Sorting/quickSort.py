
# Quick Sort:
    # Real time Example
    # There are 10 students in a class, Teacher wants all the student to stand in a sorted order. Two possible things can be done here.
    # Teacher can look into each students height and instruct them to come either left or right to stand in a sorted order
    # Students can sort themselves by standing in such a way that shorter hights should come left and higher heights should come to the right
    # for each of the student (Quicker Way)

    # So, when we think about Quick sort, first thing shoould come to our mind is PIVOT element



#       We have to pick a pivot value from an array.
#       Any Element smaller than pivot should go to its left and large should go to right by swapping their positions.
#       Pivot value itself might not be in its right position.
#       We need to find the right position for pivot element by a partition function
#       Once find, both left and right side of the pivot may not necessarily to be sorted.
#       Both right and left elements will need to be processed by recursion to be sorted
def partition(array, left, right):

    # i will find smaller element from left to right
    # j will find larger element from right to left
    i = left
    j = right-1
    pivot = array[right]

    # Until i & j Cross each other
    while i < j:
        # Move i to the right; j to the left & check if element is already less than Pivot
        # Then move.increment i towards right
        while i < right and array[i] < pivot:
            i += 1
        # Similarly, we have to check for j too and decrement towards left
        while j > left and array[j] >= pivot:
            j -= 1
        # if both above whiles are not met then array[i] > pivot and array[j] < pivot
        # if i & j did not cross each other
        # hence switch the element in the array
        if i < j :
            array[i],array[j] = array[j],array[i]

    # When i & j crossed each other
    # i index value is higher than pivot, then swap ith element and find the partition position for pivot
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







