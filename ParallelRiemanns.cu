//Christian Douglas
//Joseph Williamson
//Alex Trampert
//Riemann Summ Group Project
//Parallel code

#include <stdio.h>

#define NUMBER_OF_THREADS 1024

// CUDA kernel
__global__ void findArea(float* deltaX)
{   __shared__float sum = 0;

    // Get our global thread ID
    float id = blockIdx.x*blockDim.x+threadIdx.x;
    if (id == 0 || id == NUMBER_OF_THREADS) {
        sum += (id * id) + (id * 3) + 3;
    }  else {
        float x = (id) * deltaX;
        sum += 2 * ((x * x) + (x * 3) + 3);
    }
}

int main()
{
    //host variables
    float a = 0, b = 100,
     deltaX = (b-a)/NUMBER_OF_THREADS;
    //device variables
    float* deltaX_dev;

    //allocate on gpu 
    cudaMalloc((void**)a_dev, deltaX);
    cudaMemcpy(deltaX_dev, deltaX, deltaX, cudaMemcpyHostToDevice);

    dim3 GridDim(1,1);
    dim3 BlockDim(NUMBER_OF_THREADS,1);

    //call kernel 
    findArea<<<GridDim,BlockDim>>>(deltaX_dev);
    
    cudaFree(deltaX_dev);
    
    printf("Riemann's Sum: %f\n", sum);

    return 0;
}