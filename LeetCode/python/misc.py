# def zip_func() -> list:
#     a = [1,2,3,4]
#     b = ['a','b','c','d']
#     c = zip(b,a)
#     print(c)
#     return b

# a = [1,2,3,4]
# b = ['a','b','c','d']
# c = zip(b,a)
# print(tuple(c)) # (('a', 1), ('b', 2), ('c', 3), ('d', 4))
# print(dict(zip(b,a))) # {'a': 1, 'b': 2, 'c': 3, 'd': 4}

# a = [1,2,3,4,5,6]
# print(a[2:4])


# Create just a linkedList
##########################
class Node:
    # Function to initialise the node object
    def __init__(self, data):
        self.data = data  # Assign data
        self.next = None  # Initialize next as null
# Linked List class contains a Node object
class LinkedList:

    # Function to initialize head
    def __init__(self):
        self.head = None
# Code execution starts here
if __name__ == '__main__':
    # Start with the empty list
    llist = LinkedList()

    llist.head = Node(1)
    second = Node(2)
    third = Node(3)
    llist.head.next = second
    second.next = third
print("Here is the LinkedList: ",llist.head.data)
