id = 1
def plus(a, b):
    return a + b

def voidFunc():
    return

def minus(a, b):
    return a - b

def isPositive(a):
    return a > 0

def main():
    a = 2
    b = 3
    c = plus(a, b)
    if a > 0:
        if a > 1:
            if a > 3:
                a = 3
            
        
    
    if isPositive(a):
        i = 0
        while i < c:
            i += 1
            
            a = minus(a, 1)
        
    
    while b < c + 2:
        
        b += 1
        b = plus(b, 1)
    

    if a < c:
        a = c / b
        d = c * b
    
    elif a < c:
        d = b // 2
    
    else:
        d = b
    
    d = c - 2 * 3 // 2
    return 0

if __name__ == "__main__":
	main()
