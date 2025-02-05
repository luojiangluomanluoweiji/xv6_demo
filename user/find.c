#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fs.h"

void find(char* path,char* target)
{
	char buf[512];
	char* p;
	int fd;
	struct dirent de;
	struct stat st;

	//if!
	if((fd=open(path,0))<0){//forget 

		fprintf(2,"find: cannot open %s\n",path);
		return;
	}
	//if!
	if(fstat(fd,&st)<0){
		fprintf(2, "find: cannot stat %s\n", path);
		close(fd);
		return;
	}

	switch(st.type){
		case T_FILE:
      if(strcmp(path+strlen(path)-strlen(target),target)==0){
	      printf("%s\n",path);//*target or target?

	}
      break;
		case T_DIR:
      //first compare whether buf can contain somuch words
	   
      strcpy(buf,path);
      p=buf+strlen(buf);
      *p++='/';

      //I have no idea that while should be used when reading dir entry 
      while(read(fd,&de,sizeof(de))==sizeof(de)){
		      
		      //inum?
		      //
		      if(de.inum==0) continue;
		      memmove(p,de.name,DIRSIZ);//*?
		      if(strcmp(buf+strlen(buf)-2,"/.")!=0&&strcmp(buf+strlen(buf)-3,"/..")!=0){
		      find(buf,target);

		      }

		}
		break;
	}
	close(fd);
}

int main(int argc,char* argv[])
{
	//difference between char* argv[] and char* argv
	if(argc<3){
		printf("argument is too less\n");
		exit(0);
	}


	char target[512];
	target[0]='/';
	strcpy(target+1,argv[2]);//should be check:argv[2]pointer?or not
	find(argv[1],target);
	exit(0);
}

