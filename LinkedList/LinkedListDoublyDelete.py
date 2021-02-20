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
    ###################### Delete ############
    #****************************************#

    def delete(self,n1):
        if self.head is None and n1 is None:
            return
        if self.head == n1:
            self.head = n1.next
        if n1.next is not None:
            n1.next.prev = n1.prev
        if n1.prev is not None:
            n1.prev.next = n1.next