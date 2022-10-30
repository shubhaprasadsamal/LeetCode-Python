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
# class Node:
#     # Function to initialise the node object
#     def __init__(self, data):
#         self.data = data  # Assign data
#         self.next = None  # Initialize next as null
# # Linked List class contains a Node object
# class LinkedList:
#
#     # Function to initialize head
#     def __init__(self):
#         self.head = None
# # Code execution starts here
# if __name__ == '__main__':
#     # Start with the empty list
#     llist = LinkedList()
#
#     llist.head = Node(1)
#     second = Node(2)
#     third = Node(3)
#     llist.head.next = second
#     second.next = third
# print("Here is the LinkedList: ",llist.head.data)

# stringInput="Banana"
# listString=stringInput.split()
# print(listString)

# def factorial(nums: int):
#     if nums == 0:
#         return 1
#     return nums * factorial(nums-1)
#
#
# print(factorial(4))

# a = [1,2,3,4]
# print(a[0:2])

class Node:                                         # Define the Tree
    def __init__(self,val):
        self.val = val
        self.left = None
        self.right = None

def dfs(root):

    res = ""
    stack = []
    if root is None:
        return

    stack.append(root)
    i = len(stack)-1
    while i >= 0:
        # print(i)
        # print(stack[i])
        if stack[i].left:

            stack.append(stack[i].left)
            i += 1
        elif stack[i].right:

            node = stack.pop()
            print("node inside elif: ",node.val)
            res = res + ">" + str(node.val)
            stack.append(stack[i].right)
        else:
            print("Shitansu IF")
            node = stack.pop()
            print("node inside else: ",node.val)
            res = res + ">" + str(node.val)
            i -= 1

    print(res)

tree = Node(1)
tree.left = Node(2)
tree.right = Node(3)
tree.left.left = Node(4)
tree.left.right = Node(5)
tree.right.left = Node(6)
tree.right.right = Node(7)

dfs(tree)





