#****************************************#
###########    Define Node    ############
#****************************************#

class Node:
    def __init__(self,data):            #constructor of the class
        self.data = data
        self.next = None
        self.prev = None

#****************************************#
########### Define LinkedList ############
#****************************************#

class DoublyLinkedList:
    def __init__(self):
        self.head = None

    #****************************************#
    ########### Add Node @ Begining ##########
    #****************************************#

    def push(self,n1):
        new_node = Node(n1)

        new_node.next = self.head.next
        self.head = new_node
        new_node.prev = None

    #****************************************#
    ########### Append @ End #### ############
    #****************************************#

    def append(self,n1):
        new_node = Node(n1)
        new_node.next = None                    # As this node is going to be last node

        if self.head is None:
            new_node.prev = None
            self.head = new_node
            return

        last_node = self.head

        while last_node.next:
            last_node = last_node.next
        last_node.next = new_node
        new_node.prev = last_node

    #****************************************#
    ##### Add a node before a given node #####
    #****************************************#

    def insertBefore(self,next_node,n1):
        new_node = Node(n1)

        if next_node is None and self.head:
            print("This node doesn't exist in DLL")
            return

        new_node.prev = next_node.next
        next_node.prev = new_node
        new_node.next = next_node

        if new_node.prev is not None:           # what if it's None ??
            new_node.prev.next = new_node

    #****************************************#
    ##### Add a node after a given node ######
    #****************************************#

    def insertAfter(self,prev_node,n1):
        new_node = Node(n1)

        if prev_node is None and self.head:
            print("This node doesn't exist in DLL")
            return

        new_node.next = prev_node.next
        prev_node.next = new_node
        new_node.prev = prev_node

        if new_node.next is not None:
            new_node.next.prev = new_node

llist = DoublyLinkedList()
# Insert 6. So the list becomes 6->None
llist.append(6)

# Insert 7 at the beginning.
# So linked list becomes 7->6->None
llist.push(7)

# Insert 1 at the beginning.
# So linked list becomes 1->7->6->None
llist.push(1)

# Insert 4 at the end.
# So linked list becomes 1->7->6->4->None
llist.append(4)

# Insert 8, after 7.
# So linked list becomes 1->7->8->6->4->None
llist.insertAfter(llist.head.next, 8)

print ("Created DLL is: ",printList(llist.head)) # Not Working