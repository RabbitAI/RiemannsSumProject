//Christian Douglas
//Joseph Williamson
//Alex Trampert
//Riemann Summ Group Project
//Parallel code

#include <stdio.h>
#include "timer.h"
#include <cuda.h>
#include <cuda_runtime.h>

#define NUMBER_OF_THREADS 10240

// CUDA kernel
__global__ void findArea(float *n, float a, float b)
{	__shared__ float dX;
	dX = (b - a)/NUMBER_OF_THREADS;
    // Get our thread ID
    int id = blockIdx.x*blockDim.x+threadIdx.x;
	
    if (id == 0 ) {
        n[id] = (a * a) + (a * 3) + 3;
	}
	if (id == NUMBER_OF_THREADS-1){
		n[id] = (b * b) + (b * 3) + 3;
    } else if(id != 0) {
		float x = id * dX;
		n[id] = (2 * ((x * x) + (x * 3) + 3));
    }
}

int main()
{	
    //timer variables
    double start, finish, elapsed;
    //host variables
	float a = 0, b = 100;
	float sum = 0;
	const int size = NUMBER_OF_THREADS*sizeof(float);
    float n[size];
	
	float total = 0;
    //device variables
	float* n_dev;

    //allocate on gpu 
    cudaMalloc((void**)&n_dev, size);
    cudaMemcpy(n_dev, n, size, cudaMemcpyHostToDevice);

    dim3 GridDim(10,1);
    dim3 BlockDim(1024,1);

    GET_TIME(start);
    //call kernel 
    findArea<<<GridDim,BlockDim>>>(n_dev, a, b);
    cudaDeviceSynchronize();
    GET_TIME(finish);
    elapsed = finish - start;

	cudaMemcpy(n, n_dev, size, cudaMemcpyDeviceToHost);
    cudaFree(n_dev);
    
	for (int i = 0; i < NUMBER_OF_THREADS; i++) 
	{	
        sum += n[i];
	}
    
	total = ((b - a)/(2 * NUMBER_OF_THREADS)) * sum;
	
    printf("Riemann's Sum: %f\n", total);
    printf("The code to be timed took %e seconds\n", elapsed);

    return 0;
}

