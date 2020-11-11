//Christian Douglas
//Joseph Williamson
//Alex Trampert
//Riemann Summ Group Project
//Serial Code

#include <stdio.h>

int main()
{
    int y, sum = 0;
    int a = 0;   //start
    int b = 100; //end
    int n = 100; //number of intervals
    float deltaX = (b - a) / n;

    for (int i = 0; i <= n; i++)
    {
        if (i == 0 || i == 100)
        {
           y = i + 3;
           sum += y;
        }
        else
        {
            
            y = 2 * (i + 3);
            sum += y;
        }
    }

    sum *= deltaX / 2;

    printf("The Riemann's Sum is: %d\n", sum);
}