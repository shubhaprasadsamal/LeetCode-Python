# There is no Data structure called Linked list in Python.
# Hence we have to design it by using class.
# Linked list is collection of nodes and the first node is called header node.
# A Node has two attributes i.e. a Data and Next
# Data is the value that is stored in the node and Next is the pointer which stores the address of next node

class Node:                         # This class is for node in a linked list i.e. how it is structured
    def __init__(self,value):       # self is the constructor of the class
        self.value = value
        self.next= None

class linked_list:                  # This class for linked list having nodes
    def __init__(self):
        self.head = None
