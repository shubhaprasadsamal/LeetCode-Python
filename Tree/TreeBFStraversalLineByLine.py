class Node:                                         # Define the Tree
    def __init__(self,value):
        self.value = value
        self.left = None
        self.right = None

def bfsLineByLine(root):

    if root is None:
        return
    queue = []                                      # Define a queue and insert
    queue.append(root)

    while queue:
        count = len(queue)
        while (count > 0):
            # print('queue: ',queue[0])
            node = queue.pop(0)                         # Take out the first node in the queue and check for the child element and then insert it into queue
            print(node.value,end = ' ')
            if node.left:
                queue.append(node.left)
            if node.right:
                queue.append(node.right)
            count-=1
        print('X')                                      # ?????????????????????????????????




tree = Node(1)
tree.left = Node(2)
tree.right = Node(3)
tree.left.left = Node(4)
tree.left.right = Node(5)
tree.right.left = Node(6)
tree.right.right = Node(7)


bfsLineByLine(tree)