#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int main(int argc,char* argv[])
{
  int p2c[2];
  int c2p[2];
  int pid;
  char c2p_str[1024];

  pipe(p2c);
  pipe(c2p);
  pid=fork();
  if(pid>0)
  {

    close(p2c[0]);

    int ret=write(p2c[1],"!",1);
      if(ret==-1)
      {
        printf("parent write error\n");
        exit(1);
      }
    close(p2c[1]);


    close(c2p[1]);
    int n;

    n=read(c2p[0],c2p_str,sizeof(c2p_str));
      if(n==-1)
      {
        printf("parent read error\n");
        exit(1);
      }
    
    close(c2p[0]);

    printf("%d: received pong\n",getpid());

    exit(0);
  }
  if(pid==0)
  {
    char p2c_str[1024];
    int n;

    close(p2c[1]);
    while((n=read(p2c[0],p2c_str,sizeof(p2c_str)))>0)
    {
      if(n==-1)
      {
        printf("child read error\n");
        exit(1);
      }
    }
    close(p2c[0]);
    printf("%d: received ping\n",getpid());
    
    close(c2p[0]);
    int ret=write(c2p[1],"?",1);
      if(ret==-1)
      {
        printf("child write error\n");
        exit(1);
      }
    close(c2p[1]);

    exit(0);
  }
  return 0;
}
