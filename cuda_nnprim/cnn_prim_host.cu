#define CNN_PRIM_TIMING

#include "cnn_prim_device.hpp"
#include <iostream>
#include <string>

#ifdef CNN_PRIM_TIMING
  #include <chrono>
#endif

// argument must be of type cudaError_t!
#define CHECK_CUDA_ERROR(X) do{								    \
	cudaError_t err = X;								    \
     	if(err){									    \
	  std::cerr << "CUDA Error at line " << __LINE__ << " in file " << __FILE__ << ": " \
	  << cudaGetErrorName(err) << " -- " << cudaGetErrorString(err) << std::endl;  	    \
	}										    \
     }while(0)


__host__
void vector_add_cuda(const float* h_a, const float* h_b, float* h_c, const int& size){

     //GPU work specifications
     int blockDim = 256;
     int gridDim = (size + blockDim-1) / blockDim;
     
     float *d_a, *d_b, *d_c;

     //Allocate GPU memory
     CHECK_CUDA_ERROR(cudaMalloc((void**)&d_a, size*sizeof(float)));
     CHECK_CUDA_ERROR(cudaMalloc((void**)&d_b, size*sizeof(float)));
     CHECK_CUDA_ERROR(cudaMalloc((void**)&d_c, size*sizeof(float)));

     //Transfer to GPU
     CHECK_CUDA_ERROR(cudaMemcpy(d_a, h_a, size*sizeof(float), cudaMemcpyHostToDevice));
     CHECK_CUDA_ERROR(cudaMemcpy(d_b, h_b, size*sizeof(float), cudaMemcpyHostToDevice));


#ifdef CNN_PRIM_TIMING
     std::chrono::high_resolution_clock::time_point start;
     std::chrono::high_resolution_clock::time_point end;
     std::chrono::duration<double> elapsed;
    
     start = std::chrono::high_resolution_clock::now();
#endif

     //Kernel call & block
     vector_add_device<<<gridDim, blockDim>>>(d_a, d_b, d_c, size);
     CHECK_CUDA_ERROR(cudaDeviceSynchronize());

#ifdef CNN_PRIM_TIMING
     end = std::chrono::high_resolution_clock::now();
     elapsed = std::chrono::duration_cast<std::chrono::duration<double>>(end-start);
     std::cout << "\"vector_add_cuda\" kernel took " << elapsed.count() << " secs." << std::endl;
#endif

     //Get answer
     CHECK_CUDA_ERROR(cudaMemcpy(h_c, d_c, size*sizeof(float), cudaMemcpyDeviceToHost));

     //Release device allocations and reset
     CHECK_CUDA_ERROR(cudaFree(d_a));
     CHECK_CUDA_ERROR(cudaFree(d_b));
     CHECK_CUDA_ERROR(cudaFree(d_c));
     CHECK_CUDA_ERROR(cudaDeviceReset());
}
