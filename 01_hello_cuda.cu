%%writefile my_first_cuda_program.cu
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <stdio.h>
__global__ void hello_world(){
  // printf("Hello cuda\n");
  printf("Thread Idx x = %d, Thread Idx y= %d, Thread Idx z  = %d\n",
  threadIdx.x,threadIdx.y, threadIdx.z);
}
int main(){
  dim3 grid(2,2,2);
  dim3 block(2,2,2);
  hello_world<<<grid,block>>>();
  cudaDeviceSynchronize();
  cudaDeviceReset();
  return 0;
}