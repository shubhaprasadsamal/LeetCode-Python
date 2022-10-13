Pseudocode for the linear search algorithm

procedure linear_search (list, value)

for each item in the list:
    if match item == value:
        return the item's location
    end if
end for

end procedure

# Space Complexity:
#
# Since linear search uses no extra space, its space complexity is O(n), where n is the number of elements in an array.
#
# Time Complexity:
#
# Best-case complexity = O(1) occurs when the searched item is present at the first element in the search array.
# Worst-case complexity = O(n) occurs when the required element is at the tail of the array or not present at all.
# Average- case complexity = average case occurs when the item to be searched is in somewhere middle of the Array.