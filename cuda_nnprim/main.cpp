#include <iostream>
#include <random>
#include <cstdlib>
#include "cnn_prim.hpp"

int main(int argc, char** argv){

  int nElements = 5e+7;
  
  //Allocate vectors
  float *a, *b, *c;
  a = (float*)calloc(nElements, sizeof(float));
  b = (float*)calloc(nElements, sizeof(float));
  c = (float*)calloc(nElements, sizeof(float));

  //Uniformly distributed random ints
  std::default_random_engine generator;
  std::uniform_int_distribution<int> distribution(0,80000);
  for(int i(0); i < nElements; ++i){
    a[i] = b[i] = static_cast<float>(distribution(generator));
  }

  //GPU runtime
  vector_add_cuda(a, b, c, 25);
  
  //Deallocate vectors
  free(a);
  free(b);
  free(c);
  
  return 0;
}
