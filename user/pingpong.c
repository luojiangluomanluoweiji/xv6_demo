#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include <fcntl.h>              /* Definition of O_* constants */
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/wait.h>

int main(int argc,char* argv[])
{
  int p2c[2];
  int c2p[2];
  pid_t pid;
  char p2c_str[1024];
  char c2p_str[1024];

  pipe(p2c);
  pipe(c2p);
  pid=fork();
  if(pid>0)
  {
    int mypid=getpid();
    sprintf(p2c_str,"%d",getpid());

    close(p2c[0]);

    int ret=write(p2c[1],p2c_str,sizeof(p2c_str));
      if(ret==-1)
      {
        perror("parent write error");
        exit(1);
      }
    close(p2c[1]);


    close(c2p[1]);
    int n;
    wait(NULL);
    n=read(c2p[0],c2p_str,sizeof(c2p_str));
      if(n==-1)
      {
        perror("parent read error");
        exit(1);
      }
    
    close(c2p[0]);

    printf("%s pong\n",c2p_str);

    exit(0);
  }
  if(pid==0)
  {
    char p2c_str[1024];
    char c2p_str[1024];

    int mypid=getpid();
    sprintf(c2p_str,"%d",getpid());

    int n;

    close(p2c[1]);
    while((n=read(p2c[0],p2c_str,sizeof(p2c_str)))>0)
    {
      if(n==-1)
      {
        perror("child read error");
        exit(1);
      }
    }
    close(p2c[0]);
    printf("%s ping\n",p2c_str);
    
    close(c2p[0]);
    int ret=write(c2p[1],c2p_str,sizeof(c2p_str));
      if(ret==-1)
      {
        perror("child write error");
        exit(1);
      }
    close(c2p[1]);

    exit(0);
  }
  return 0;
}
