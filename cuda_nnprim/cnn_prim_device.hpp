#ifndef CNN_PRIM_DEVICE_H
#define CNN_PRIM_DEVICE_H

__global__
void vector_add_device(const float* __restrict__ a,
		       const float* __restrict__ b,
		       float* __restrict__ c,
		       int size);
#endif
