#************************
#Recurssion Function Implementation
#************************


class Node:                                         # Define the Tree
    def __init__(self,value):
        self.value = value
        self.left = None
        self.right = None

def height(node):
    print('NodeF: ',node.value)
    if node is None:
        print("Inside 1st if")
        return 0
    else :
        # Compute the height of each subtree                    ### NOT WORKING: NEED TO CHECK####
        print('Inside 1st Else')
        print('NodeLeftF: ',node.left.value)
        lheight = height(node.left)
        print("lheight: ",lheight)
        rheight = height(node.right)
        print("rheight: ",rheight)

        #Use the larger one
        if lheight > rheight :
            # print("inside 2nd If")
            return lheight+1
            print('lheight sum: ',lheight+1)
        else:
            return rheight+1
            print('rheight sum: ',rheight+1)

root = Node(1)
root.left = Node(2)
root.right = Node(3)
root.left.left = Node(4)
root.left.right = Node(5)
#
# print(root.value)
# print(root.left.value)
# print(root.right.value)
# print(root.left.left.value)
# print(root.left.right.value)

height(root)