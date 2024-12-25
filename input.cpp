#include <iostream>

using namespace std;

int id = 1;

int Plus(int a, int b) 
{
    return a + b;
}

void voidFunc() {
    return;
}

int Minus(int a, int b) {
    return a - b;
}

bool isPositive(int a)
{
    return a > 0;
}

int main()
{
    cout << "HELLO!";
    char* helloMessage = "Hello!1";
    cout << helloMessage;
    int a = 2;
    int b = 3;
    float f = 1.222;
    int c = Plus(a, b);

    if (a > 0) {
        if (a > 1) {
            if (a > 3) {
                a = 3;
            }
        }
    }
    if (isPositive(a))
    {
        for (int i = 0; i < c; i += 1) {
            a = Minus(a, 1);
        }
    }

    while (b < c + 2)
    {
        b += 1;
        b = Plus(b, 1);
        cout << b;
    }

    int d;
    if (a < c)
    {
        a = c / b;
        d = c * b;
    } else if (a < c) {
        d = b % 2;
    } else 
    {
        d = b;
    }

    if (a == 2 || !(b == 3)) {
        b = d;
    }

    d = c - 2 * 3 % 2;

    while(true) {
        cout << "INFINITY LOOP";
    }
    return 0;
}