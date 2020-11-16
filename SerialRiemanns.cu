//Christian Douglas
//Joseph Williamson
//Alex Trampert
//Riemann Summ Group Project
//Serial Code

#include <stdio.h>
#include "timer.h"

int main()
{
    //timer variables
    double start, finish, elapsed;

    float y;
    float a = 0;   //start
    float b = 100; //end
    float n = 10240; //number of intervals
    float deltaX = (b - a) / n, sum = 0;

    GET_TIME(start);
    for (float i = 0; i < n; i++)
    {   if (i == 0)
        {  y = (a * a) + (a * 3) + 3;
           sum += y;
        }
        else if (i == n-1)
        {   y = (b * b) + (b * 3) + 3;
            sum += y;
        }
        else
        {   float x = (a + i) * deltaX;
            y = 2 * ((x * x) + (x * 3) + 3);
            sum += y;
        } 
    }
    GET_TIME(finish);
    elapsed = finish - start;
    sum = (deltaX / 2) * sum;

    printf("The Riemann's Sum is: %f\n", sum);
    printf("The code to be timed took %e seconds\n", elapsed);

    return 0;
}