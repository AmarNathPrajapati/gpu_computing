%%writefile cuda_memory_transfer_program.cu
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <stdio.h>

__global__ void memTransfer(int *input) {
    int threadId = threadIdx.x;
    printf("Array Index = %d, Array Value = %d\n", threadId, input[threadId]);
}

int main() {
    int size = 128;
    int byte_size = size * sizeof(int);
    int *h_input = (int *)malloc(byte_size);

    // Corrected the random number generation
    for (int i = 0; i < size; i++) {
        h_input[i] = rand() % 100 + 1;
    }

    int *d_input;
    cudaMalloc((void **)&d_input, byte_size);

    // Corrected the cudaMemcpy function and added cudaDeviceSynchronize
    cudaMemcpy(d_input, h_input, byte_size, cudaMemcpyHostToDevice);
    cudaDeviceSynchronize();

    // dim3 grid(1, 1, 1);
    // dim3 block(128, 1, 1);
    // dim3 grid(2, 1, 1);
    // dim3 block(64, 1, 1);
    dim3 grid(4, 1, 1);
    dim3 block(32, 1, 1);
    memTransfer<<<grid, block>>>(d_input);
    cudaDeviceSynchronize();

    free(h_input);
    cudaFree(d_input);

    return 0;
}
