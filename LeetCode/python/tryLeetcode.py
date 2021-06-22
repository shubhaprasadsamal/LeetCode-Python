class Solution:
    def combine(self, n: int, k: int) -> List[List[int]]:
        output = []
        def worker(n,k,i,res):
            if len(res)==k:
                output.append(res[:])
                print("output: ",output)
            else:
                for x in range(i,n+1):
                    print("length res: ",len(res))
                    print("i: ",i)
                    print("x: ",x)
                    #                     if x<n+1 and i<k+1:

                    #                         if len(res)!=0 and res[0]==x:
                    #                             print("res[0]: ",res[0])
                    #                             print("res before append: ",res)
                    #                             continue
                    #                             print("res after append: ",res)
                    #                         else:
                    print("res before append in else: ",res)
                    res.append(x)
                    print("res after append in else: ",res)
                    # else:
                    #     break
                    worker(n,k,i+1,res)
                    print("res before pop: ",res)
                    print("i before pop: ",i)
                    print("x before pop: ",x)
                    res.pop()
                    print("res after pop: ",res)
                    print("i after pop: ",i)
                    print("x after pop: ",x)
        worker(n,k,1,[])
        return output
