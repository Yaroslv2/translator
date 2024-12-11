#include <iostream>

int id = 1;

int plus(int a, int b) 
{
    return a + b;
}

void voidFunc() {
    return;
}

int minus(int a, int b) {
    return a - b;
}

bool isPositive(int a)
{
    return a > 0;
}

int main()
{
    int a = 2;
    int b = 3;
    int c = plus(a, b);

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
            a = minus(a, 1);
        }
    }

    while (b < c + 2)
    {
        b += 1;
        b = plus(b, 1);
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

    d = c - 2 * 3 % 2;
    return 0;
}