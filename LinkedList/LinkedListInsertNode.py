#****************************************#
###########    Define Node    ############
#****************************************#

class Node:
    def __init__(self,data):            #constructor of the class
        self.data = data
        self.next = None

#****************************************#
########### Define LinkedList ############
#****************************************#

class LinkedList:
    def __init__(self):
        self.head = None

    #****************************************#
    ########### Append @ End      ############
    #****************************************#

    def append_node(self, data):
        new_node = Node(data)               # Class Composition
        if self.head is None:               # Check if if it's an empty node
            self.head = new_node
            return
        last_node = self.head               # As we have to insert an new node at the end of the list hence define a pointer
                                            # to first node of the lost and traverse through to find out the last element and once found then add the new node
        while last_node.next:               # Check in the last_node.next is not null
            last_node = last_node.next
        last_node.next = new_node

    #****************************************#
    ########### Append @ Begining ############
    #****************************************#

    def prepend_node(self,data):
        new_node = Node(data)
        new_node.next = self.head
        self.head = new_node

    #****************************************#
    ########### Insert After Node ############
    #****************************************#

    def insert_after_node(self,prev_node,data):

        if not prev_node:
            print("Nothing to be added")
            return
        new_node = Node(data)
        new_node.next  = prev_node.next
        prev_node.next = new_node

    #****************************************#
    ########### Printing Each Node############
    #****************************************#

    def print_node(self):
        cur = self.head
        while cur:
            print("Each Node: ",cur.data)
            cur = cur.next

x = LinkedList()
x.append_node("A")
# x.print_node()
x.append_node("B")
x.append_node("C")
x.append_node("D")
x.append_node("E")
x.append_node("F")
x.prepend_node("G")
print("Data Component of Head: ",x.head.data)       #Print out the data component of the head of the list
print("Data Component of Head: ",x.head.next.data)  #Print out the data component of the next element of head of the list
# x.insert_after_node(x.head.next,"Q")
x.insert_after_node("A","Q")
x.print_node()

