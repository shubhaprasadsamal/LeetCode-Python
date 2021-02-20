#****************************************#
###########    Define Node    ############
#****************************************#

class Node:
    def __init__(self,data):            #constructor of the class
        self.data = data
        self.next = None   # Why next is not populating with dif color ?

#****************************************#
########### Define LinkedList ############
#****************************************#

class LinkedList:
    def __init__(self):
        self.head = None

    #****************************************#
    ########### Append @ End      ############
    #****************************************#

    def append(self, data):
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
    ########### Printing Each Node############
    #****************************************#

    def print_node(self):
        cur = self.head
        while cur:
            print("Each Node: ",cur.data)
            cur = cur.next

    #****************************************#
    ###########    Delete Head    ############
    #****************************************#

    def delete(self,key):               # Key is the node to be Deleted
        cur = self.head
        if cur and cur.data == key:     # Check of head node in not none and Key is the head node
            self.head = cur.next
            cur = None
            return

    #****************************************#
    ########Delete intermidiate Node##########
    #****************************************#
        prev_node = None                # Keep track of previous node
        while cur and cur.data != key:
            prev_node = cur
            cur = cur.next
        if cur is None:                 # Check if we reach the end of the list
            print("Key is not in LinkedList")
            return
        prev_node.next = cur.next
        cur = None

    #****************************************#
    ########Delete at given Position##########
    #****************************************#

    def delete_node_at_pos(self,pos):
        cur = self.head
        if pos == 0:                    # Position 0 in a linked list is HEAD and then count gets increased
            self.head = cur.next
            cur = None
            return
        prev_node = None
        count = 0
        while cur and count != pos:
            prev_node = cur
            cur = cur.next
            count +=1
        if cur is None:
            print("Position doesn't match")
            return
        prev_node.next = cur.next
        cur = None

x = LinkedList()
x.append("A")
# x.print_node()
x.append("B")
x.append("C")
x.append("D")
x.append("E")
x.append("F")
x.append("G")
x.delete("G")
x.delete("E")
x.delete_node_at_pos(3)
x.print_node()

