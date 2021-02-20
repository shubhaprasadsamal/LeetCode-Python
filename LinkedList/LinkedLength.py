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
    ########### Append @ Begining ############
    #****************************************#

    def prepend_node(self,data):
        new_node = Node(data)
        new_node.next = self.head
        self.head = new_node

    # Length: (Iterative Method)

    def length_iter(self):

        if self.head is None:
            return 0

        temp = self.head
        count = 0

        while temp:
            temp = temp.next
            count +=1
        return count

    # Length: (Recursive Method)

    def length_recur(self):
        if self.head is None:
            return 0
        else:
            # temp = self.head
            return (1 + self.length_recur(self.head.next)) # Need to check why it's not working

if __name__=='__main__':
    llist = LinkedList()
    llist.prepend_node(1)
    llist.prepend_node(3)
    llist.prepend_node(1)
    llist.prepend_node(2)
    llist.prepend_node(1)
    print ('Count of nodes in iter is : ',llist.length_iter())
    print ('Count of nodes in recur is : ',llist.length_recur())

