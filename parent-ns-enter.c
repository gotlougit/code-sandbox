#include <stdio.h>
#define _GNU_SOURCE

#include <sched.h>
#include <sys/ioctl.h>
#include <fcntl.h>
#include <sys/sysmacros.h>
#include <unistd.h>

#ifndef NS_GET_USERNS
#define NSIO 0xb7
#define NS_GET_USERNS _IO(NSIO, 0x1)
#define NS_GET_PARENT _IO(NSIO, 0x2)
#endif

int setns(int, int);

int main(int argc, char * const *argv) {
  int f = open(argv[1], O_RDONLY | O_CLOEXEC);
  int pf = ioctl(f, NS_GET_PARENT);
  int x = setns(pf, 0);
  
  execvp(argv[2], &argv[2]);
}
