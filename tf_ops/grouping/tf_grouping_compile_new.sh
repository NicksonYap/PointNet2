#/bin/bash

CU_NAME=tf_grouping_g
CP_NAME=tf_grouping
SO_NAME=tf_grouping_so

CUDA_ROOT=/usr/local/cuda-9.0
TF_INC=$(python -c 'import tensorflow as tf; print(tf.sysconfig.get_include())')
TF_LIB=$(python -c 'import tensorflow as tf; print(tf.sysconfig.get_lib())')

echo $CU_NAME
echo $CP_NAME
echo $SO_NAME
echo $CUDA_ROOT
echo $TF_INC
echo $TF_LIB

$CUDA_ROOT/bin/nvcc $CU_NAME.cu -o $CU_NAME.cu.o -c -O2 -DGOOGLE_CUDA=1 -x cu -Xcompiler -fPIC

# TF>=1.4.0
g++ -std=c++11 $CP_NAME.cpp $CU_NAME.cu.o -o $SO_NAME.so -shared -fPIC -I$TF_INC/ -I$TF_INC/external/nsync/public -L$TF_LIB -ltensorflow_framework -I$CUDA_ROOT/include -lcudart -L$CUDA_ROOT/lib64/ -O2 -D_GLIBCXX_USE_CXX11_ABI=0