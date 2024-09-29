#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"


void print_arr(char* arr,int size)//copy
{
  printf("a new print_arr\n");
  for(int i=0;i<size;i++)
  {
    printf("%d \n",*(arr+i));
  }
  return;
}

void erase_arr(char* arr,int size)
{
  for(int i=0;i<size;i++)//copy
  {
	  *(arr+i)=0;
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
//  print_arr(buf,sizeof(buf));


while(1)
  {

    //break condition judge(just after get the prime,before creat another process)
    if(buf[0]==0)
    {
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
	{
        write(p[1],&buf[i],sizeof(buf[i]));//take 0 as write ,666
	}
      }
    close(p[1]);

    wait(&pid);//here should be end of any process
    exit(0);

  }
  else if(pid==0)
  {
	sleep(10);
	erase_arr(buf,sizeof(buf));
      close(p[1]);
      int ret_read=read(p[0],buf,sizeof(buf));
      if(ret_read==-1)
      {
        printf("read error\n");
        exit(1);
      }
      close(p[0]);
 //     print_arr(buf,sizeof(buf));

      continue ;
  }
  else if(pid ==-1)
  {
    printf("fork error\n");
    exit(1);
  }
}
exit(0);
  return 0;
}
