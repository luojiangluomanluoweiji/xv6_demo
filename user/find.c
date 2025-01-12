#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

char * fmtname(char* path)
{
	char buf[DIRSIZ+1];//Why is it +1?
	char *p;
	
	for(p=path+strlen(path);p>path&&p!='/';p--)
		;
	p++;
	if(strlen(p)>DIRSIZ)
		return p;

	memcopy(buf,p,strlen(p));
	memset(buf," ",DIRSIZ-strlen(p));
	return buf;
}

void find(char *path)
{
	char buf[4096];
	char *p;
	int fd;
	struct dirent direntry;
	struct stat sta;

	if(open(path,0)==-1){
		printf("find open error");
	}

	if(fstat(fd,&sta)==-1){
		printf("find fstat error");
	}

	switch(sta.type)
	{
		case T_FILE:
			printf("%s\n",fmtname(path);

		case T_DIR:
			while(read(fd,&direntry,sizeof(direntry))==sizeof(direntry)){
			//not know what should be filled for the 3th pare;
				if(strcmp(dirent.name,".")==0||strcmp(dirent.name,"..")==0)
					continue;//not break!

				//now I am add "/+dirent.name" to *path
				p=dirent.name;
				buf=p;
				memset(buf,'/',1);
				for(int i=strlen(buf);i<strlen(p);i++){
					memset(buf,*p,1);
					p++;
				}

				//end
				find(buf);
			}




	}

		

}

int main(int argc,char* argv[])
{
	if(argc<2){
		printf("argument is not enough");
	}

	for(int i=1;i<argc;i++){
		find(argv[i]);
	}

	
	
	return 0;
}
