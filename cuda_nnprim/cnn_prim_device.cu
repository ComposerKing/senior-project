#include "cnn_prim_device.hpp"

__global__
void vector_add_device(const float* __restrict__ a,
     		       const float* __restrict__ b,
		       float* __restrict__ c,
		       int size){
   int i = blockIdx.x * blockDim.x + threadIdx.x;
   if(i < size) 
   	c[i] = a[i] + b[i];
}