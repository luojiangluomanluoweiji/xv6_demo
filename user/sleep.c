#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int main(int argc,char* argv[])
{
  if(argc < 2 )
  {
    printf("Usage:%s<num> \n",argv[0]);
    exit(1);
  }
  if(sleep(atoi(argv[1]))<0)
  {
    printf("sleep error");
  }
  exit(0);

}
