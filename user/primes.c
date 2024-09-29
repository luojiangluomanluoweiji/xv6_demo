#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"


void print_arr(int* arr,int size)//copy
{
  for(int i=0;i<size;i++)
  {
    printf("a new print_arr\n");
    printf("%d \n",*(arr+i));
  }
  return;
}


int main(int argc,char* argv[])
{
  char buf[34];

    for(int i=2;i<36;i++)
    {
      buf[i-2]=i;
    }
  //here should have a test to print buf
  print_arr(buf,sizeof(buf));


while(1)
  {
    if(buf[0]!=2)//the first parent process can`t run this block
    {
      close(p[1])
      int ret_read=read(p[0],buf,sizeof(p[0]));
      if(ret_read==-1)
      {
        printf("read error\n");
        exit(1);
      }
      close(p[0]);
    }

    //break condition judge(just after get the prime,before creat another process)
    if(sizeof(buf)==4)
    {
    printf("prime %d\n",buf[0]);//printf what i want;
    break;
    }

  int p[2];
  int pid;

  int ret_pipe=pipe(p);
  if(ret_pipe==-1)
  {
    printf("pipe error\n");
    exit(1);
  }//copy but check

  pid=fork();
  if(pid>0)
  {
    printf("prime %d\n",buf[0]);//printf what i want;

    close(p[0]);//copy
    for(int i=1;i<sizeof(buf);i++)
      {
        if((buf[i]/buf[0])*buf[0]!=buf[i])//第i个数can`t be divided by buf[0]
        write(p[0],&buf[i],sizeof(buf[i]));
      }
    close(p[1]);

    wait();//here should be end of any process

  }
  else if(pid==0)
  {
      continue ;
  }
  }
  else 
  {
    printf("fork error\n");
    exit(1);
  }
}
  return 0;
}
