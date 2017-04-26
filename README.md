# Senior Project Repository (senior-project)
Senior Project Files and Directories

"./caffenet_proj/" contains the log files, protocol buffer specs, and parsing scripts for the Caffe framework that was used to test everything. Copy this model folder to the "models" directory in a caffe build to use its settings. Running training requires Caffe: http://caffe.berkeleyvision.org/


"./cuda_nnprim/" contains the GPU boilerplate and timing code, as well as a vector add kernel. Requires CUDA version 7.5 or later for compilation: https://developer.nvidia.com/cuda-downloads