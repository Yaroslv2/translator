id = 1
def Plus(a, b):
    return a + b

def voidFunc():
    return

def Minus(a, b):
    return a - b

def isPositive(a):
    return a > 0

def main():
    print("HELLO!\n")
    helloMessage = "Hello!1\n"
    print(helloMessage)
    a = 2
    b = 3
    f = 1.222000
    c = Plus(a, b)
    if a > 0:
        if a > 1:
            if a > 3:
                a = 3
            
        
    
    if isPositive(a):
        i = 0
        while i < c:
            i += 1
            
            a = Minus(a, 1)
        
    
    while b < c + 2:
        
        b += 1
        b = Plus(b, 1)
        print(b)
        print("\n")
    

    if a < c:
        a = c / b
        d = c * b
    
    elif a < c:
        d = b // 2
    
    else:
        d = b
    
    if a == 2 or not (b == 3):
        b = d
    
    print(c - 2 * 3 // 2)
    print("\n")
    d = c - 2 * 3 // 2
    boolValue = True
    inc = 0
    while boolValue:
        
        print("INFINITY LOOP\n")
        if inc < 8:
            inc += 1
        
        else:
            boolValue = False
        
    
    return 0

if __name__ == "__main__":
	main()
