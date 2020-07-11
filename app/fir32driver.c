/* FIR filter compute */

#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/mman.h>

#define pi 3.14159265359

typedef long long int u64;

int main(int argc, char **argv) {
  
  /* IP addresses definition */
  unsigned int axifir_size = 0x10000;
  off_t axifir_pbase = 0x43C00000; /* physical base address */
  u64 *axifir_vptr;
  int fd;

  float h[33]; /* Filter coefficients */
  int window; /* Use hamming window */
  float gain; /* Fir filter gain */
  long long hq[33]; /* Filter coefficients quantified */
  float w[33]; /* Hanning window */
  float wc; /* Cut frequency according fnyquist */
  int i;
  float sum = 0.0;
  long long _2power;

  int n = 32; /* Filter order declaration */
  
  if (argc>4)
    printf("Too much arguments. Only 2 arguments needed \n");
  
  wc = atoi(argv[1])/1000.0;
  gain = atoi(argv[2])/100.0;
  window = atoi(argv[3]);

  printf("wc = %.3f\n",wc);
  wc = wc/2;

  if ((fd = open("/dev/mem", O_RDWR | O_SYNC)) == -1) {
  printf("Access memory error");
  return(0);
  }
  
  axifir_vptr = (u64 *)mmap(NULL, axifir_size, PROT_READ|PROT_WRITE, MAP_SHARED, fd, axifir_pbase);

  printf("Computing fir coefficients\n");
  for (i=0;i<=n;i++){
    if (i!=n/2)
      h[i] = sin(2*pi*(i-n/2)*wc)/(i-n/2);
    else
      h[i] = 2*pi*wc;
  }

  /* Normalizing coefficients */
  for (i=0;i<=n;i++)
    sum = sum+h[i];

  for (i=0;i<=n;i++)
    h[i] = h[i]/sum;

  for (i=0;i<=n;i++)
    h[i] = h[i]*gain;

  for (i=0;i<=n;i++)
    printf("%f ", h[i]);
  printf("\n");

  printf("Compute Hamming window\n");
  for (i=0;i<=n;i++)
    w[i] = 0.54-0.46*cos(2*pi*i/n);

  for (i=0;i<=n;i++)
    printf("%f ", w[i]);
  printf("\n");
  
  if (window) {
    printf("Applying Window\n");
    for (i=0;i<=n;i++)
      h[i] = h[i]*w[i];
  }

  printf("Quantifying coefficients\n");
  _2power = pow(2,32);
  for (i=0;i<=n;i++)
    hq[i] = h[i]*_2power;

  for (i=0;i<=n;i++)
    printf("%lld ", hq[i]);
  printf("\n");

  printf("Writting coefficients on PL\n");
  
  for (i=0;i<=n;i++)
    axifir_vptr[i] = hq[i];

}
