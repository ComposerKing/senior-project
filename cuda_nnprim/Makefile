# MAKEFILE FOR cnn_prim
# DEVIN KING

.SUFFIXES: .C .c .cu ..c .i .o .cpp
CUDAHOME = /usr/local/cuda-8.0

#TARGET -- BASE FILENAME
TARGET = cnn_prim

#COMPILERS
CC = g++
NVCC = $(CUDAHOME)/bin/nvcc

#INCLUDE PATHS
NVCCINCS = -I. -I$(CUDAHOME)/common/inc -DUNIX

#COMPILE TIME FLAGS
CCFLAGS = -Wall -std=c++11 -march=native -O3 -m64 -g -DCUDA
NVCCFLAGS = --machine=64 --ptxas-options=-O3 --std=c++11 -gencode arch=compute_35,code=sm_35 $(NVCCINCS)

#LINKER FLAGS
CLFLAGS = -lm -lrt
CUDALIBS = -L$(CUDAHOME)/lib64 -lcudart -lcudadevrt

#SOURCE FILES
CSRCS = main.cpp
CUDASRCS = $(TARGET)_device.cu $(TARGET)_host.cu

#OBJECT FILES
CUDDEVOBJ = reloc_dev.o
COBJS = $(CSRCS:.cpp=.o)
CUDOBJS = $(CUDASRCS:.cu=.o)

all : $(TARGET)

$(TARGET) : $(CUDDEVOBJ) $(COBJS)
	$(CC) $(CCFLAGS) $(CUDOBJS) $(COBJS)  $(CUDDEVOBJ) $(CUDALIBS) -o $(TARGET)

.cpp.o :
	$(CC) $(CCFLAGS) -c $< $(CLFLAGS) -o $@

.cu.o :
	$(NVCC) $(NVCCFLAGS) -lineinfo -I. --device-c $< -o $@

reloc_dev.o : $(CUDOBJS)
	$(NVCC) $(NVCCFLAGS) --device-link $(CUDOBJS) --output-file $@

.PHONY : clean cleanobj cleanexe cleantemp cleandata

clean : cleanobj cleanexe cleantemp cleandata

cleanobj :
	rm -v -f *.o

cleanexe :
	rm -v -f $(TARGET)

cleantemp :
	rm -v -f *~ *#

