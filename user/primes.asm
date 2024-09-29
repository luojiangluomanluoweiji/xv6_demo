
user/_primes:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <print_arr>:
#include "kernel/stat.h"
#include "user/user.h"


void print_arr(char* arr,int size)//copy
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	1800                	addi	s0,sp,48
   e:	892a                	mv	s2,a0
  10:	89ae                	mv	s3,a1
  printf("a new print_arr\n");
  12:	00001517          	auipc	a0,0x1
  16:	97e50513          	addi	a0,a0,-1666 # 990 <malloc+0xe6>
  1a:	00000097          	auipc	ra,0x0
  1e:	7d2080e7          	jalr	2002(ra) # 7ec <printf>
  for(int i=0;i<size;i++)
  22:	03305763          	blez	s3,50 <print_arr+0x50>
  26:	84ca                	mv	s1,s2
  28:	0905                	addi	s2,s2,1
  2a:	39fd                	addiw	s3,s3,-1
  2c:	1982                	slli	s3,s3,0x20
  2e:	0209d993          	srli	s3,s3,0x20
  32:	994e                	add	s2,s2,s3
  {
    printf("%d \n",*(arr+i));
  34:	00001997          	auipc	s3,0x1
  38:	97498993          	addi	s3,s3,-1676 # 9a8 <malloc+0xfe>
  3c:	0004c583          	lbu	a1,0(s1)
  40:	854e                	mv	a0,s3
  42:	00000097          	auipc	ra,0x0
  46:	7aa080e7          	jalr	1962(ra) # 7ec <printf>
  for(int i=0;i<size;i++)
  4a:	0485                	addi	s1,s1,1
  4c:	ff2498e3          	bne	s1,s2,3c <print_arr+0x3c>
  }
  return;
}
  50:	70a2                	ld	ra,40(sp)
  52:	7402                	ld	s0,32(sp)
  54:	64e2                	ld	s1,24(sp)
  56:	6942                	ld	s2,16(sp)
  58:	69a2                	ld	s3,8(sp)
  5a:	6145                	addi	sp,sp,48
  5c:	8082                	ret

000000000000005e <erase_arr>:

void erase_arr(char* arr,int size)
{
  5e:	1141                	addi	sp,sp,-16
  60:	e422                	sd	s0,8(sp)
  62:	0800                	addi	s0,sp,16
  for(int i=0;i<size;i++)//copy
  64:	00b05e63          	blez	a1,80 <erase_arr+0x22>
  68:	87aa                	mv	a5,a0
  6a:	0505                	addi	a0,a0,1
  6c:	fff5871b          	addiw	a4,a1,-1
  70:	1702                	slli	a4,a4,0x20
  72:	9301                	srli	a4,a4,0x20
  74:	972a                	add	a4,a4,a0
  {
	  *(arr+i)=0;
  76:	00078023          	sb	zero,0(a5)
  for(int i=0;i<size;i++)//copy
  7a:	0785                	addi	a5,a5,1
  7c:	fee79de3          	bne	a5,a4,76 <erase_arr+0x18>
  }
  return;
	
}
  80:	6422                	ld	s0,8(sp)
  82:	0141                	addi	sp,sp,16
  84:	8082                	ret

0000000000000086 <main>:


int main(int argc,char* argv[])
{
  86:	711d                	addi	sp,sp,-96
  88:	ec86                	sd	ra,88(sp)
  8a:	e8a2                	sd	s0,80(sp)
  8c:	e4a6                	sd	s1,72(sp)
  8e:	e0ca                	sd	s2,64(sp)
  90:	1080                	addi	s0,sp,96
  char buf[34];

    for(int i=2;i<36;i++)
  92:	fb840713          	addi	a4,s0,-72
  96:	fda40493          	addi	s1,s0,-38
{
  9a:	87ba                	mv	a5,a4
    {
      buf[i-2]=i;
  9c:	4689                	li	a3,2
  9e:	9e99                	subw	a3,a3,a4
  a0:	00f6873b          	addw	a4,a3,a5
  a4:	00e78023          	sb	a4,0(a5)
    for(int i=2;i<36;i++)
  a8:	0785                	addi	a5,a5,1
  aa:	fe979be3          	bne	a5,s1,a0 <main+0x1a>

while(1)
  {

    //break condition judge(just after get the prime,before creat another process)
    if(buf[0]==0)
  ae:	fb844783          	lbu	a5,-72(s0)
  b2:	14078163          	beqz	a5,1f4 <main+0x16e>

  int p[2];
  int pid;

  int ret_pipe=pipe(p);
  if(ret_pipe==-1)
  b6:	597d                	li	s2,-1
  b8:	a8f5                	j	1b4 <main+0x12e>
  {
    printf("pipe error\n");
  ba:	00001517          	auipc	a0,0x1
  be:	8f650513          	addi	a0,a0,-1802 # 9b0 <malloc+0x106>
  c2:	00000097          	auipc	ra,0x0
  c6:	72a080e7          	jalr	1834(ra) # 7ec <printf>
    exit(1);
  ca:	4505                	li	a0,1
  cc:	00000097          	auipc	ra,0x0
  d0:	3a8080e7          	jalr	936(ra) # 474 <exit>
  }//copy but check

  pid=fork();
  if(pid>0)
  {
    printf("prime %d\n",buf[0]);//printf what i want;
  d4:	fb844583          	lbu	a1,-72(s0)
  d8:	00001517          	auipc	a0,0x1
  dc:	8e850513          	addi	a0,a0,-1816 # 9c0 <malloc+0x116>
  e0:	00000097          	auipc	ra,0x0
  e4:	70c080e7          	jalr	1804(ra) # 7ec <printf>

    close(p[0]);//copy
  e8:	fb042503          	lw	a0,-80(s0)
  ec:	00000097          	auipc	ra,0x0
  f0:	3b0080e7          	jalr	944(ra) # 49c <close>
    for(int i=1;i<sizeof(buf);i++)
  f4:	fb940913          	addi	s2,s0,-71
  f8:	a021                	j	100 <main+0x7a>
  fa:	0905                	addi	s2,s2,1
  fc:	02990663          	beq	s2,s1,128 <main+0xa2>
      {
        if((buf[i]/buf[0])*buf[0]!=buf[i])//第i个数can`t be divided by buf[0]
 100:	00094783          	lbu	a5,0(s2)
 104:	fb844683          	lbu	a3,-72(s0)
 108:	02d7d73b          	divuw	a4,a5,a3
 10c:	02d7073b          	mulw	a4,a4,a3
 110:	2781                	sext.w	a5,a5
 112:	fef704e3          	beq	a4,a5,fa <main+0x74>
	{
        write(p[1],&buf[i],sizeof(buf[i]));//take 0 as write ,666
 116:	4605                	li	a2,1
 118:	85ca                	mv	a1,s2
 11a:	fb442503          	lw	a0,-76(s0)
 11e:	00000097          	auipc	ra,0x0
 122:	376080e7          	jalr	886(ra) # 494 <write>
 126:	bfd1                	j	fa <main+0x74>
	}
      }
    close(p[1]);
 128:	fb442503          	lw	a0,-76(s0)
 12c:	00000097          	auipc	ra,0x0
 130:	370080e7          	jalr	880(ra) # 49c <close>

    wait(&pid);//here should be end of any process
 134:	fac40513          	addi	a0,s0,-84
 138:	00000097          	auipc	ra,0x0
 13c:	344080e7          	jalr	836(ra) # 47c <wait>
    exit(0);
 140:	4501                	li	a0,0
 142:	00000097          	auipc	ra,0x0
 146:	332080e7          	jalr	818(ra) # 474 <exit>

  }
  else if(pid==0)
  {
	sleep(10);
 14a:	4529                	li	a0,10
 14c:	00000097          	auipc	ra,0x0
 150:	3b8080e7          	jalr	952(ra) # 504 <sleep>
	erase_arr(buf,sizeof(buf));
 154:	02200593          	li	a1,34
 158:	fb840513          	addi	a0,s0,-72
 15c:	00000097          	auipc	ra,0x0
 160:	f02080e7          	jalr	-254(ra) # 5e <erase_arr>
      close(p[1]);
 164:	fb442503          	lw	a0,-76(s0)
 168:	00000097          	auipc	ra,0x0
 16c:	334080e7          	jalr	820(ra) # 49c <close>
      int ret_read=read(p[0],buf,sizeof(buf));
 170:	02200613          	li	a2,34
 174:	fb840593          	addi	a1,s0,-72
 178:	fb042503          	lw	a0,-80(s0)
 17c:	00000097          	auipc	ra,0x0
 180:	310080e7          	jalr	784(ra) # 48c <read>
      if(ret_read==-1)
 184:	01251f63          	bne	a0,s2,1a2 <main+0x11c>
      {
        printf("read error\n");
 188:	00001517          	auipc	a0,0x1
 18c:	84850513          	addi	a0,a0,-1976 # 9d0 <malloc+0x126>
 190:	00000097          	auipc	ra,0x0
 194:	65c080e7          	jalr	1628(ra) # 7ec <printf>
        exit(1);
 198:	4505                	li	a0,1
 19a:	00000097          	auipc	ra,0x0
 19e:	2da080e7          	jalr	730(ra) # 474 <exit>
      }
      close(p[0]);
 1a2:	fb042503          	lw	a0,-80(s0)
 1a6:	00000097          	auipc	ra,0x0
 1aa:	2f6080e7          	jalr	758(ra) # 49c <close>
    if(buf[0]==0)
 1ae:	fb844783          	lbu	a5,-72(s0)
 1b2:	c3a9                	beqz	a5,1f4 <main+0x16e>
  int ret_pipe=pipe(p);
 1b4:	fb040513          	addi	a0,s0,-80
 1b8:	00000097          	auipc	ra,0x0
 1bc:	2cc080e7          	jalr	716(ra) # 484 <pipe>
  if(ret_pipe==-1)
 1c0:	ef250de3          	beq	a0,s2,ba <main+0x34>
  pid=fork();
 1c4:	00000097          	auipc	ra,0x0
 1c8:	2a8080e7          	jalr	680(ra) # 46c <fork>
 1cc:	faa42623          	sw	a0,-84(s0)
  if(pid>0)
 1d0:	f0a042e3          	bgtz	a0,d4 <main+0x4e>
  else if(pid==0)
 1d4:	d93d                	beqz	a0,14a <main+0xc4>
 //     print_arr(buf,sizeof(buf));

      continue ;
  }
  else if(pid ==-1)
 1d6:	fd251ce3          	bne	a0,s2,1ae <main+0x128>
  {
    printf("fork error\n");
 1da:	00001517          	auipc	a0,0x1
 1de:	80650513          	addi	a0,a0,-2042 # 9e0 <malloc+0x136>
 1e2:	00000097          	auipc	ra,0x0
 1e6:	60a080e7          	jalr	1546(ra) # 7ec <printf>
    exit(1);
 1ea:	4505                	li	a0,1
 1ec:	00000097          	auipc	ra,0x0
 1f0:	288080e7          	jalr	648(ra) # 474 <exit>
  }
}
exit(0);
 1f4:	4501                	li	a0,0
 1f6:	00000097          	auipc	ra,0x0
 1fa:	27e080e7          	jalr	638(ra) # 474 <exit>

00000000000001fe <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 1fe:	1141                	addi	sp,sp,-16
 200:	e422                	sd	s0,8(sp)
 202:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 204:	87aa                	mv	a5,a0
 206:	0585                	addi	a1,a1,1
 208:	0785                	addi	a5,a5,1
 20a:	fff5c703          	lbu	a4,-1(a1)
 20e:	fee78fa3          	sb	a4,-1(a5)
 212:	fb75                	bnez	a4,206 <strcpy+0x8>
    ;
  return os;
}
 214:	6422                	ld	s0,8(sp)
 216:	0141                	addi	sp,sp,16
 218:	8082                	ret

000000000000021a <strcmp>:

int
strcmp(const char *p, const char *q)
{
 21a:	1141                	addi	sp,sp,-16
 21c:	e422                	sd	s0,8(sp)
 21e:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 220:	00054783          	lbu	a5,0(a0)
 224:	cb91                	beqz	a5,238 <strcmp+0x1e>
 226:	0005c703          	lbu	a4,0(a1)
 22a:	00f71763          	bne	a4,a5,238 <strcmp+0x1e>
    p++, q++;
 22e:	0505                	addi	a0,a0,1
 230:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 232:	00054783          	lbu	a5,0(a0)
 236:	fbe5                	bnez	a5,226 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 238:	0005c503          	lbu	a0,0(a1)
}
 23c:	40a7853b          	subw	a0,a5,a0
 240:	6422                	ld	s0,8(sp)
 242:	0141                	addi	sp,sp,16
 244:	8082                	ret

0000000000000246 <strlen>:

uint
strlen(const char *s)
{
 246:	1141                	addi	sp,sp,-16
 248:	e422                	sd	s0,8(sp)
 24a:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 24c:	00054783          	lbu	a5,0(a0)
 250:	cf91                	beqz	a5,26c <strlen+0x26>
 252:	0505                	addi	a0,a0,1
 254:	87aa                	mv	a5,a0
 256:	4685                	li	a3,1
 258:	9e89                	subw	a3,a3,a0
 25a:	00f6853b          	addw	a0,a3,a5
 25e:	0785                	addi	a5,a5,1
 260:	fff7c703          	lbu	a4,-1(a5)
 264:	fb7d                	bnez	a4,25a <strlen+0x14>
    ;
  return n;
}
 266:	6422                	ld	s0,8(sp)
 268:	0141                	addi	sp,sp,16
 26a:	8082                	ret
  for(n = 0; s[n]; n++)
 26c:	4501                	li	a0,0
 26e:	bfe5                	j	266 <strlen+0x20>

0000000000000270 <memset>:

void*
memset(void *dst, int c, uint n)
{
 270:	1141                	addi	sp,sp,-16
 272:	e422                	sd	s0,8(sp)
 274:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 276:	ce09                	beqz	a2,290 <memset+0x20>
 278:	87aa                	mv	a5,a0
 27a:	fff6071b          	addiw	a4,a2,-1
 27e:	1702                	slli	a4,a4,0x20
 280:	9301                	srli	a4,a4,0x20
 282:	0705                	addi	a4,a4,1
 284:	972a                	add	a4,a4,a0
    cdst[i] = c;
 286:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 28a:	0785                	addi	a5,a5,1
 28c:	fee79de3          	bne	a5,a4,286 <memset+0x16>
  }
  return dst;
}
 290:	6422                	ld	s0,8(sp)
 292:	0141                	addi	sp,sp,16
 294:	8082                	ret

0000000000000296 <strchr>:

char*
strchr(const char *s, char c)
{
 296:	1141                	addi	sp,sp,-16
 298:	e422                	sd	s0,8(sp)
 29a:	0800                	addi	s0,sp,16
  for(; *s; s++)
 29c:	00054783          	lbu	a5,0(a0)
 2a0:	cb99                	beqz	a5,2b6 <strchr+0x20>
    if(*s == c)
 2a2:	00f58763          	beq	a1,a5,2b0 <strchr+0x1a>
  for(; *s; s++)
 2a6:	0505                	addi	a0,a0,1
 2a8:	00054783          	lbu	a5,0(a0)
 2ac:	fbfd                	bnez	a5,2a2 <strchr+0xc>
      return (char*)s;
  return 0;
 2ae:	4501                	li	a0,0
}
 2b0:	6422                	ld	s0,8(sp)
 2b2:	0141                	addi	sp,sp,16
 2b4:	8082                	ret
  return 0;
 2b6:	4501                	li	a0,0
 2b8:	bfe5                	j	2b0 <strchr+0x1a>

00000000000002ba <gets>:

char*
gets(char *buf, int max)
{
 2ba:	711d                	addi	sp,sp,-96
 2bc:	ec86                	sd	ra,88(sp)
 2be:	e8a2                	sd	s0,80(sp)
 2c0:	e4a6                	sd	s1,72(sp)
 2c2:	e0ca                	sd	s2,64(sp)
 2c4:	fc4e                	sd	s3,56(sp)
 2c6:	f852                	sd	s4,48(sp)
 2c8:	f456                	sd	s5,40(sp)
 2ca:	f05a                	sd	s6,32(sp)
 2cc:	ec5e                	sd	s7,24(sp)
 2ce:	1080                	addi	s0,sp,96
 2d0:	8baa                	mv	s7,a0
 2d2:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2d4:	892a                	mv	s2,a0
 2d6:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 2d8:	4aa9                	li	s5,10
 2da:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 2dc:	89a6                	mv	s3,s1
 2de:	2485                	addiw	s1,s1,1
 2e0:	0344d863          	bge	s1,s4,310 <gets+0x56>
    cc = read(0, &c, 1);
 2e4:	4605                	li	a2,1
 2e6:	faf40593          	addi	a1,s0,-81
 2ea:	4501                	li	a0,0
 2ec:	00000097          	auipc	ra,0x0
 2f0:	1a0080e7          	jalr	416(ra) # 48c <read>
    if(cc < 1)
 2f4:	00a05e63          	blez	a0,310 <gets+0x56>
    buf[i++] = c;
 2f8:	faf44783          	lbu	a5,-81(s0)
 2fc:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 300:	01578763          	beq	a5,s5,30e <gets+0x54>
 304:	0905                	addi	s2,s2,1
 306:	fd679be3          	bne	a5,s6,2dc <gets+0x22>
  for(i=0; i+1 < max; ){
 30a:	89a6                	mv	s3,s1
 30c:	a011                	j	310 <gets+0x56>
 30e:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 310:	99de                	add	s3,s3,s7
 312:	00098023          	sb	zero,0(s3)
  return buf;
}
 316:	855e                	mv	a0,s7
 318:	60e6                	ld	ra,88(sp)
 31a:	6446                	ld	s0,80(sp)
 31c:	64a6                	ld	s1,72(sp)
 31e:	6906                	ld	s2,64(sp)
 320:	79e2                	ld	s3,56(sp)
 322:	7a42                	ld	s4,48(sp)
 324:	7aa2                	ld	s5,40(sp)
 326:	7b02                	ld	s6,32(sp)
 328:	6be2                	ld	s7,24(sp)
 32a:	6125                	addi	sp,sp,96
 32c:	8082                	ret

000000000000032e <stat>:

int
stat(const char *n, struct stat *st)
{
 32e:	1101                	addi	sp,sp,-32
 330:	ec06                	sd	ra,24(sp)
 332:	e822                	sd	s0,16(sp)
 334:	e426                	sd	s1,8(sp)
 336:	e04a                	sd	s2,0(sp)
 338:	1000                	addi	s0,sp,32
 33a:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 33c:	4581                	li	a1,0
 33e:	00000097          	auipc	ra,0x0
 342:	176080e7          	jalr	374(ra) # 4b4 <open>
  if(fd < 0)
 346:	02054563          	bltz	a0,370 <stat+0x42>
 34a:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 34c:	85ca                	mv	a1,s2
 34e:	00000097          	auipc	ra,0x0
 352:	17e080e7          	jalr	382(ra) # 4cc <fstat>
 356:	892a                	mv	s2,a0
  close(fd);
 358:	8526                	mv	a0,s1
 35a:	00000097          	auipc	ra,0x0
 35e:	142080e7          	jalr	322(ra) # 49c <close>
  return r;
}
 362:	854a                	mv	a0,s2
 364:	60e2                	ld	ra,24(sp)
 366:	6442                	ld	s0,16(sp)
 368:	64a2                	ld	s1,8(sp)
 36a:	6902                	ld	s2,0(sp)
 36c:	6105                	addi	sp,sp,32
 36e:	8082                	ret
    return -1;
 370:	597d                	li	s2,-1
 372:	bfc5                	j	362 <stat+0x34>

0000000000000374 <atoi>:

int
atoi(const char *s)
{
 374:	1141                	addi	sp,sp,-16
 376:	e422                	sd	s0,8(sp)
 378:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 37a:	00054603          	lbu	a2,0(a0)
 37e:	fd06079b          	addiw	a5,a2,-48
 382:	0ff7f793          	andi	a5,a5,255
 386:	4725                	li	a4,9
 388:	02f76963          	bltu	a4,a5,3ba <atoi+0x46>
 38c:	86aa                	mv	a3,a0
  n = 0;
 38e:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 390:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 392:	0685                	addi	a3,a3,1
 394:	0025179b          	slliw	a5,a0,0x2
 398:	9fa9                	addw	a5,a5,a0
 39a:	0017979b          	slliw	a5,a5,0x1
 39e:	9fb1                	addw	a5,a5,a2
 3a0:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 3a4:	0006c603          	lbu	a2,0(a3)
 3a8:	fd06071b          	addiw	a4,a2,-48
 3ac:	0ff77713          	andi	a4,a4,255
 3b0:	fee5f1e3          	bgeu	a1,a4,392 <atoi+0x1e>
  return n;
}
 3b4:	6422                	ld	s0,8(sp)
 3b6:	0141                	addi	sp,sp,16
 3b8:	8082                	ret
  n = 0;
 3ba:	4501                	li	a0,0
 3bc:	bfe5                	j	3b4 <atoi+0x40>

00000000000003be <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3be:	1141                	addi	sp,sp,-16
 3c0:	e422                	sd	s0,8(sp)
 3c2:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 3c4:	02b57663          	bgeu	a0,a1,3f0 <memmove+0x32>
    while(n-- > 0)
 3c8:	02c05163          	blez	a2,3ea <memmove+0x2c>
 3cc:	fff6079b          	addiw	a5,a2,-1
 3d0:	1782                	slli	a5,a5,0x20
 3d2:	9381                	srli	a5,a5,0x20
 3d4:	0785                	addi	a5,a5,1
 3d6:	97aa                	add	a5,a5,a0
  dst = vdst;
 3d8:	872a                	mv	a4,a0
      *dst++ = *src++;
 3da:	0585                	addi	a1,a1,1
 3dc:	0705                	addi	a4,a4,1
 3de:	fff5c683          	lbu	a3,-1(a1)
 3e2:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 3e6:	fee79ae3          	bne	a5,a4,3da <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 3ea:	6422                	ld	s0,8(sp)
 3ec:	0141                	addi	sp,sp,16
 3ee:	8082                	ret
    dst += n;
 3f0:	00c50733          	add	a4,a0,a2
    src += n;
 3f4:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 3f6:	fec05ae3          	blez	a2,3ea <memmove+0x2c>
 3fa:	fff6079b          	addiw	a5,a2,-1
 3fe:	1782                	slli	a5,a5,0x20
 400:	9381                	srli	a5,a5,0x20
 402:	fff7c793          	not	a5,a5
 406:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 408:	15fd                	addi	a1,a1,-1
 40a:	177d                	addi	a4,a4,-1
 40c:	0005c683          	lbu	a3,0(a1)
 410:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 414:	fee79ae3          	bne	a5,a4,408 <memmove+0x4a>
 418:	bfc9                	j	3ea <memmove+0x2c>

000000000000041a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 41a:	1141                	addi	sp,sp,-16
 41c:	e422                	sd	s0,8(sp)
 41e:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 420:	ca05                	beqz	a2,450 <memcmp+0x36>
 422:	fff6069b          	addiw	a3,a2,-1
 426:	1682                	slli	a3,a3,0x20
 428:	9281                	srli	a3,a3,0x20
 42a:	0685                	addi	a3,a3,1
 42c:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 42e:	00054783          	lbu	a5,0(a0)
 432:	0005c703          	lbu	a4,0(a1)
 436:	00e79863          	bne	a5,a4,446 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 43a:	0505                	addi	a0,a0,1
    p2++;
 43c:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 43e:	fed518e3          	bne	a0,a3,42e <memcmp+0x14>
  }
  return 0;
 442:	4501                	li	a0,0
 444:	a019                	j	44a <memcmp+0x30>
      return *p1 - *p2;
 446:	40e7853b          	subw	a0,a5,a4
}
 44a:	6422                	ld	s0,8(sp)
 44c:	0141                	addi	sp,sp,16
 44e:	8082                	ret
  return 0;
 450:	4501                	li	a0,0
 452:	bfe5                	j	44a <memcmp+0x30>

0000000000000454 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 454:	1141                	addi	sp,sp,-16
 456:	e406                	sd	ra,8(sp)
 458:	e022                	sd	s0,0(sp)
 45a:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 45c:	00000097          	auipc	ra,0x0
 460:	f62080e7          	jalr	-158(ra) # 3be <memmove>
}
 464:	60a2                	ld	ra,8(sp)
 466:	6402                	ld	s0,0(sp)
 468:	0141                	addi	sp,sp,16
 46a:	8082                	ret

000000000000046c <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 46c:	4885                	li	a7,1
 ecall
 46e:	00000073          	ecall
 ret
 472:	8082                	ret

0000000000000474 <exit>:
.global exit
exit:
 li a7, SYS_exit
 474:	4889                	li	a7,2
 ecall
 476:	00000073          	ecall
 ret
 47a:	8082                	ret

000000000000047c <wait>:
.global wait
wait:
 li a7, SYS_wait
 47c:	488d                	li	a7,3
 ecall
 47e:	00000073          	ecall
 ret
 482:	8082                	ret

0000000000000484 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 484:	4891                	li	a7,4
 ecall
 486:	00000073          	ecall
 ret
 48a:	8082                	ret

000000000000048c <read>:
.global read
read:
 li a7, SYS_read
 48c:	4895                	li	a7,5
 ecall
 48e:	00000073          	ecall
 ret
 492:	8082                	ret

0000000000000494 <write>:
.global write
write:
 li a7, SYS_write
 494:	48c1                	li	a7,16
 ecall
 496:	00000073          	ecall
 ret
 49a:	8082                	ret

000000000000049c <close>:
.global close
close:
 li a7, SYS_close
 49c:	48d5                	li	a7,21
 ecall
 49e:	00000073          	ecall
 ret
 4a2:	8082                	ret

00000000000004a4 <kill>:
.global kill
kill:
 li a7, SYS_kill
 4a4:	4899                	li	a7,6
 ecall
 4a6:	00000073          	ecall
 ret
 4aa:	8082                	ret

00000000000004ac <exec>:
.global exec
exec:
 li a7, SYS_exec
 4ac:	489d                	li	a7,7
 ecall
 4ae:	00000073          	ecall
 ret
 4b2:	8082                	ret

00000000000004b4 <open>:
.global open
open:
 li a7, SYS_open
 4b4:	48bd                	li	a7,15
 ecall
 4b6:	00000073          	ecall
 ret
 4ba:	8082                	ret

00000000000004bc <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 4bc:	48c5                	li	a7,17
 ecall
 4be:	00000073          	ecall
 ret
 4c2:	8082                	ret

00000000000004c4 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 4c4:	48c9                	li	a7,18
 ecall
 4c6:	00000073          	ecall
 ret
 4ca:	8082                	ret

00000000000004cc <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 4cc:	48a1                	li	a7,8
 ecall
 4ce:	00000073          	ecall
 ret
 4d2:	8082                	ret

00000000000004d4 <link>:
.global link
link:
 li a7, SYS_link
 4d4:	48cd                	li	a7,19
 ecall
 4d6:	00000073          	ecall
 ret
 4da:	8082                	ret

00000000000004dc <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 4dc:	48d1                	li	a7,20
 ecall
 4de:	00000073          	ecall
 ret
 4e2:	8082                	ret

00000000000004e4 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 4e4:	48a5                	li	a7,9
 ecall
 4e6:	00000073          	ecall
 ret
 4ea:	8082                	ret

00000000000004ec <dup>:
.global dup
dup:
 li a7, SYS_dup
 4ec:	48a9                	li	a7,10
 ecall
 4ee:	00000073          	ecall
 ret
 4f2:	8082                	ret

00000000000004f4 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 4f4:	48ad                	li	a7,11
 ecall
 4f6:	00000073          	ecall
 ret
 4fa:	8082                	ret

00000000000004fc <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 4fc:	48b1                	li	a7,12
 ecall
 4fe:	00000073          	ecall
 ret
 502:	8082                	ret

0000000000000504 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 504:	48b5                	li	a7,13
 ecall
 506:	00000073          	ecall
 ret
 50a:	8082                	ret

000000000000050c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 50c:	48b9                	li	a7,14
 ecall
 50e:	00000073          	ecall
 ret
 512:	8082                	ret

0000000000000514 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 514:	1101                	addi	sp,sp,-32
 516:	ec06                	sd	ra,24(sp)
 518:	e822                	sd	s0,16(sp)
 51a:	1000                	addi	s0,sp,32
 51c:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 520:	4605                	li	a2,1
 522:	fef40593          	addi	a1,s0,-17
 526:	00000097          	auipc	ra,0x0
 52a:	f6e080e7          	jalr	-146(ra) # 494 <write>
}
 52e:	60e2                	ld	ra,24(sp)
 530:	6442                	ld	s0,16(sp)
 532:	6105                	addi	sp,sp,32
 534:	8082                	ret

0000000000000536 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 536:	7139                	addi	sp,sp,-64
 538:	fc06                	sd	ra,56(sp)
 53a:	f822                	sd	s0,48(sp)
 53c:	f426                	sd	s1,40(sp)
 53e:	f04a                	sd	s2,32(sp)
 540:	ec4e                	sd	s3,24(sp)
 542:	0080                	addi	s0,sp,64
 544:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 546:	c299                	beqz	a3,54c <printint+0x16>
 548:	0805c863          	bltz	a1,5d8 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 54c:	2581                	sext.w	a1,a1
  neg = 0;
 54e:	4881                	li	a7,0
 550:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 554:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 556:	2601                	sext.w	a2,a2
 558:	00000517          	auipc	a0,0x0
 55c:	4a050513          	addi	a0,a0,1184 # 9f8 <digits>
 560:	883a                	mv	a6,a4
 562:	2705                	addiw	a4,a4,1
 564:	02c5f7bb          	remuw	a5,a1,a2
 568:	1782                	slli	a5,a5,0x20
 56a:	9381                	srli	a5,a5,0x20
 56c:	97aa                	add	a5,a5,a0
 56e:	0007c783          	lbu	a5,0(a5)
 572:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 576:	0005879b          	sext.w	a5,a1
 57a:	02c5d5bb          	divuw	a1,a1,a2
 57e:	0685                	addi	a3,a3,1
 580:	fec7f0e3          	bgeu	a5,a2,560 <printint+0x2a>
  if(neg)
 584:	00088b63          	beqz	a7,59a <printint+0x64>
    buf[i++] = '-';
 588:	fd040793          	addi	a5,s0,-48
 58c:	973e                	add	a4,a4,a5
 58e:	02d00793          	li	a5,45
 592:	fef70823          	sb	a5,-16(a4)
 596:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 59a:	02e05863          	blez	a4,5ca <printint+0x94>
 59e:	fc040793          	addi	a5,s0,-64
 5a2:	00e78933          	add	s2,a5,a4
 5a6:	fff78993          	addi	s3,a5,-1
 5aa:	99ba                	add	s3,s3,a4
 5ac:	377d                	addiw	a4,a4,-1
 5ae:	1702                	slli	a4,a4,0x20
 5b0:	9301                	srli	a4,a4,0x20
 5b2:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 5b6:	fff94583          	lbu	a1,-1(s2)
 5ba:	8526                	mv	a0,s1
 5bc:	00000097          	auipc	ra,0x0
 5c0:	f58080e7          	jalr	-168(ra) # 514 <putc>
  while(--i >= 0)
 5c4:	197d                	addi	s2,s2,-1
 5c6:	ff3918e3          	bne	s2,s3,5b6 <printint+0x80>
}
 5ca:	70e2                	ld	ra,56(sp)
 5cc:	7442                	ld	s0,48(sp)
 5ce:	74a2                	ld	s1,40(sp)
 5d0:	7902                	ld	s2,32(sp)
 5d2:	69e2                	ld	s3,24(sp)
 5d4:	6121                	addi	sp,sp,64
 5d6:	8082                	ret
    x = -xx;
 5d8:	40b005bb          	negw	a1,a1
    neg = 1;
 5dc:	4885                	li	a7,1
    x = -xx;
 5de:	bf8d                	j	550 <printint+0x1a>

00000000000005e0 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 5e0:	7119                	addi	sp,sp,-128
 5e2:	fc86                	sd	ra,120(sp)
 5e4:	f8a2                	sd	s0,112(sp)
 5e6:	f4a6                	sd	s1,104(sp)
 5e8:	f0ca                	sd	s2,96(sp)
 5ea:	ecce                	sd	s3,88(sp)
 5ec:	e8d2                	sd	s4,80(sp)
 5ee:	e4d6                	sd	s5,72(sp)
 5f0:	e0da                	sd	s6,64(sp)
 5f2:	fc5e                	sd	s7,56(sp)
 5f4:	f862                	sd	s8,48(sp)
 5f6:	f466                	sd	s9,40(sp)
 5f8:	f06a                	sd	s10,32(sp)
 5fa:	ec6e                	sd	s11,24(sp)
 5fc:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 5fe:	0005c903          	lbu	s2,0(a1)
 602:	18090f63          	beqz	s2,7a0 <vprintf+0x1c0>
 606:	8aaa                	mv	s5,a0
 608:	8b32                	mv	s6,a2
 60a:	00158493          	addi	s1,a1,1
  state = 0;
 60e:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 610:	02500a13          	li	s4,37
      if(c == 'd'){
 614:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 618:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 61c:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 620:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 624:	00000b97          	auipc	s7,0x0
 628:	3d4b8b93          	addi	s7,s7,980 # 9f8 <digits>
 62c:	a839                	j	64a <vprintf+0x6a>
        putc(fd, c);
 62e:	85ca                	mv	a1,s2
 630:	8556                	mv	a0,s5
 632:	00000097          	auipc	ra,0x0
 636:	ee2080e7          	jalr	-286(ra) # 514 <putc>
 63a:	a019                	j	640 <vprintf+0x60>
    } else if(state == '%'){
 63c:	01498f63          	beq	s3,s4,65a <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 640:	0485                	addi	s1,s1,1
 642:	fff4c903          	lbu	s2,-1(s1)
 646:	14090d63          	beqz	s2,7a0 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 64a:	0009079b          	sext.w	a5,s2
    if(state == 0){
 64e:	fe0997e3          	bnez	s3,63c <vprintf+0x5c>
      if(c == '%'){
 652:	fd479ee3          	bne	a5,s4,62e <vprintf+0x4e>
        state = '%';
 656:	89be                	mv	s3,a5
 658:	b7e5                	j	640 <vprintf+0x60>
      if(c == 'd'){
 65a:	05878063          	beq	a5,s8,69a <vprintf+0xba>
      } else if(c == 'l') {
 65e:	05978c63          	beq	a5,s9,6b6 <vprintf+0xd6>
      } else if(c == 'x') {
 662:	07a78863          	beq	a5,s10,6d2 <vprintf+0xf2>
      } else if(c == 'p') {
 666:	09b78463          	beq	a5,s11,6ee <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 66a:	07300713          	li	a4,115
 66e:	0ce78663          	beq	a5,a4,73a <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 672:	06300713          	li	a4,99
 676:	0ee78e63          	beq	a5,a4,772 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 67a:	11478863          	beq	a5,s4,78a <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 67e:	85d2                	mv	a1,s4
 680:	8556                	mv	a0,s5
 682:	00000097          	auipc	ra,0x0
 686:	e92080e7          	jalr	-366(ra) # 514 <putc>
        putc(fd, c);
 68a:	85ca                	mv	a1,s2
 68c:	8556                	mv	a0,s5
 68e:	00000097          	auipc	ra,0x0
 692:	e86080e7          	jalr	-378(ra) # 514 <putc>
      }
      state = 0;
 696:	4981                	li	s3,0
 698:	b765                	j	640 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 69a:	008b0913          	addi	s2,s6,8
 69e:	4685                	li	a3,1
 6a0:	4629                	li	a2,10
 6a2:	000b2583          	lw	a1,0(s6)
 6a6:	8556                	mv	a0,s5
 6a8:	00000097          	auipc	ra,0x0
 6ac:	e8e080e7          	jalr	-370(ra) # 536 <printint>
 6b0:	8b4a                	mv	s6,s2
      state = 0;
 6b2:	4981                	li	s3,0
 6b4:	b771                	j	640 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6b6:	008b0913          	addi	s2,s6,8
 6ba:	4681                	li	a3,0
 6bc:	4629                	li	a2,10
 6be:	000b2583          	lw	a1,0(s6)
 6c2:	8556                	mv	a0,s5
 6c4:	00000097          	auipc	ra,0x0
 6c8:	e72080e7          	jalr	-398(ra) # 536 <printint>
 6cc:	8b4a                	mv	s6,s2
      state = 0;
 6ce:	4981                	li	s3,0
 6d0:	bf85                	j	640 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 6d2:	008b0913          	addi	s2,s6,8
 6d6:	4681                	li	a3,0
 6d8:	4641                	li	a2,16
 6da:	000b2583          	lw	a1,0(s6)
 6de:	8556                	mv	a0,s5
 6e0:	00000097          	auipc	ra,0x0
 6e4:	e56080e7          	jalr	-426(ra) # 536 <printint>
 6e8:	8b4a                	mv	s6,s2
      state = 0;
 6ea:	4981                	li	s3,0
 6ec:	bf91                	j	640 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 6ee:	008b0793          	addi	a5,s6,8
 6f2:	f8f43423          	sd	a5,-120(s0)
 6f6:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 6fa:	03000593          	li	a1,48
 6fe:	8556                	mv	a0,s5
 700:	00000097          	auipc	ra,0x0
 704:	e14080e7          	jalr	-492(ra) # 514 <putc>
  putc(fd, 'x');
 708:	85ea                	mv	a1,s10
 70a:	8556                	mv	a0,s5
 70c:	00000097          	auipc	ra,0x0
 710:	e08080e7          	jalr	-504(ra) # 514 <putc>
 714:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 716:	03c9d793          	srli	a5,s3,0x3c
 71a:	97de                	add	a5,a5,s7
 71c:	0007c583          	lbu	a1,0(a5)
 720:	8556                	mv	a0,s5
 722:	00000097          	auipc	ra,0x0
 726:	df2080e7          	jalr	-526(ra) # 514 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 72a:	0992                	slli	s3,s3,0x4
 72c:	397d                	addiw	s2,s2,-1
 72e:	fe0914e3          	bnez	s2,716 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 732:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 736:	4981                	li	s3,0
 738:	b721                	j	640 <vprintf+0x60>
        s = va_arg(ap, char*);
 73a:	008b0993          	addi	s3,s6,8
 73e:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 742:	02090163          	beqz	s2,764 <vprintf+0x184>
        while(*s != 0){
 746:	00094583          	lbu	a1,0(s2)
 74a:	c9a1                	beqz	a1,79a <vprintf+0x1ba>
          putc(fd, *s);
 74c:	8556                	mv	a0,s5
 74e:	00000097          	auipc	ra,0x0
 752:	dc6080e7          	jalr	-570(ra) # 514 <putc>
          s++;
 756:	0905                	addi	s2,s2,1
        while(*s != 0){
 758:	00094583          	lbu	a1,0(s2)
 75c:	f9e5                	bnez	a1,74c <vprintf+0x16c>
        s = va_arg(ap, char*);
 75e:	8b4e                	mv	s6,s3
      state = 0;
 760:	4981                	li	s3,0
 762:	bdf9                	j	640 <vprintf+0x60>
          s = "(null)";
 764:	00000917          	auipc	s2,0x0
 768:	28c90913          	addi	s2,s2,652 # 9f0 <malloc+0x146>
        while(*s != 0){
 76c:	02800593          	li	a1,40
 770:	bff1                	j	74c <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 772:	008b0913          	addi	s2,s6,8
 776:	000b4583          	lbu	a1,0(s6)
 77a:	8556                	mv	a0,s5
 77c:	00000097          	auipc	ra,0x0
 780:	d98080e7          	jalr	-616(ra) # 514 <putc>
 784:	8b4a                	mv	s6,s2
      state = 0;
 786:	4981                	li	s3,0
 788:	bd65                	j	640 <vprintf+0x60>
        putc(fd, c);
 78a:	85d2                	mv	a1,s4
 78c:	8556                	mv	a0,s5
 78e:	00000097          	auipc	ra,0x0
 792:	d86080e7          	jalr	-634(ra) # 514 <putc>
      state = 0;
 796:	4981                	li	s3,0
 798:	b565                	j	640 <vprintf+0x60>
        s = va_arg(ap, char*);
 79a:	8b4e                	mv	s6,s3
      state = 0;
 79c:	4981                	li	s3,0
 79e:	b54d                	j	640 <vprintf+0x60>
    }
  }
}
 7a0:	70e6                	ld	ra,120(sp)
 7a2:	7446                	ld	s0,112(sp)
 7a4:	74a6                	ld	s1,104(sp)
 7a6:	7906                	ld	s2,96(sp)
 7a8:	69e6                	ld	s3,88(sp)
 7aa:	6a46                	ld	s4,80(sp)
 7ac:	6aa6                	ld	s5,72(sp)
 7ae:	6b06                	ld	s6,64(sp)
 7b0:	7be2                	ld	s7,56(sp)
 7b2:	7c42                	ld	s8,48(sp)
 7b4:	7ca2                	ld	s9,40(sp)
 7b6:	7d02                	ld	s10,32(sp)
 7b8:	6de2                	ld	s11,24(sp)
 7ba:	6109                	addi	sp,sp,128
 7bc:	8082                	ret

00000000000007be <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 7be:	715d                	addi	sp,sp,-80
 7c0:	ec06                	sd	ra,24(sp)
 7c2:	e822                	sd	s0,16(sp)
 7c4:	1000                	addi	s0,sp,32
 7c6:	e010                	sd	a2,0(s0)
 7c8:	e414                	sd	a3,8(s0)
 7ca:	e818                	sd	a4,16(s0)
 7cc:	ec1c                	sd	a5,24(s0)
 7ce:	03043023          	sd	a6,32(s0)
 7d2:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 7d6:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 7da:	8622                	mv	a2,s0
 7dc:	00000097          	auipc	ra,0x0
 7e0:	e04080e7          	jalr	-508(ra) # 5e0 <vprintf>
}
 7e4:	60e2                	ld	ra,24(sp)
 7e6:	6442                	ld	s0,16(sp)
 7e8:	6161                	addi	sp,sp,80
 7ea:	8082                	ret

00000000000007ec <printf>:

void
printf(const char *fmt, ...)
{
 7ec:	711d                	addi	sp,sp,-96
 7ee:	ec06                	sd	ra,24(sp)
 7f0:	e822                	sd	s0,16(sp)
 7f2:	1000                	addi	s0,sp,32
 7f4:	e40c                	sd	a1,8(s0)
 7f6:	e810                	sd	a2,16(s0)
 7f8:	ec14                	sd	a3,24(s0)
 7fa:	f018                	sd	a4,32(s0)
 7fc:	f41c                	sd	a5,40(s0)
 7fe:	03043823          	sd	a6,48(s0)
 802:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 806:	00840613          	addi	a2,s0,8
 80a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 80e:	85aa                	mv	a1,a0
 810:	4505                	li	a0,1
 812:	00000097          	auipc	ra,0x0
 816:	dce080e7          	jalr	-562(ra) # 5e0 <vprintf>
}
 81a:	60e2                	ld	ra,24(sp)
 81c:	6442                	ld	s0,16(sp)
 81e:	6125                	addi	sp,sp,96
 820:	8082                	ret

0000000000000822 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 822:	1141                	addi	sp,sp,-16
 824:	e422                	sd	s0,8(sp)
 826:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 828:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 82c:	00000797          	auipc	a5,0x0
 830:	1e47b783          	ld	a5,484(a5) # a10 <freep>
 834:	a805                	j	864 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 836:	4618                	lw	a4,8(a2)
 838:	9db9                	addw	a1,a1,a4
 83a:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 83e:	6398                	ld	a4,0(a5)
 840:	6318                	ld	a4,0(a4)
 842:	fee53823          	sd	a4,-16(a0)
 846:	a091                	j	88a <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 848:	ff852703          	lw	a4,-8(a0)
 84c:	9e39                	addw	a2,a2,a4
 84e:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 850:	ff053703          	ld	a4,-16(a0)
 854:	e398                	sd	a4,0(a5)
 856:	a099                	j	89c <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 858:	6398                	ld	a4,0(a5)
 85a:	00e7e463          	bltu	a5,a4,862 <free+0x40>
 85e:	00e6ea63          	bltu	a3,a4,872 <free+0x50>
{
 862:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 864:	fed7fae3          	bgeu	a5,a3,858 <free+0x36>
 868:	6398                	ld	a4,0(a5)
 86a:	00e6e463          	bltu	a3,a4,872 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 86e:	fee7eae3          	bltu	a5,a4,862 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 872:	ff852583          	lw	a1,-8(a0)
 876:	6390                	ld	a2,0(a5)
 878:	02059713          	slli	a4,a1,0x20
 87c:	9301                	srli	a4,a4,0x20
 87e:	0712                	slli	a4,a4,0x4
 880:	9736                	add	a4,a4,a3
 882:	fae60ae3          	beq	a2,a4,836 <free+0x14>
    bp->s.ptr = p->s.ptr;
 886:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 88a:	4790                	lw	a2,8(a5)
 88c:	02061713          	slli	a4,a2,0x20
 890:	9301                	srli	a4,a4,0x20
 892:	0712                	slli	a4,a4,0x4
 894:	973e                	add	a4,a4,a5
 896:	fae689e3          	beq	a3,a4,848 <free+0x26>
  } else
    p->s.ptr = bp;
 89a:	e394                	sd	a3,0(a5)
  freep = p;
 89c:	00000717          	auipc	a4,0x0
 8a0:	16f73a23          	sd	a5,372(a4) # a10 <freep>
}
 8a4:	6422                	ld	s0,8(sp)
 8a6:	0141                	addi	sp,sp,16
 8a8:	8082                	ret

00000000000008aa <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8aa:	7139                	addi	sp,sp,-64
 8ac:	fc06                	sd	ra,56(sp)
 8ae:	f822                	sd	s0,48(sp)
 8b0:	f426                	sd	s1,40(sp)
 8b2:	f04a                	sd	s2,32(sp)
 8b4:	ec4e                	sd	s3,24(sp)
 8b6:	e852                	sd	s4,16(sp)
 8b8:	e456                	sd	s5,8(sp)
 8ba:	e05a                	sd	s6,0(sp)
 8bc:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8be:	02051493          	slli	s1,a0,0x20
 8c2:	9081                	srli	s1,s1,0x20
 8c4:	04bd                	addi	s1,s1,15
 8c6:	8091                	srli	s1,s1,0x4
 8c8:	0014899b          	addiw	s3,s1,1
 8cc:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 8ce:	00000517          	auipc	a0,0x0
 8d2:	14253503          	ld	a0,322(a0) # a10 <freep>
 8d6:	c515                	beqz	a0,902 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8d8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8da:	4798                	lw	a4,8(a5)
 8dc:	02977f63          	bgeu	a4,s1,91a <malloc+0x70>
 8e0:	8a4e                	mv	s4,s3
 8e2:	0009871b          	sext.w	a4,s3
 8e6:	6685                	lui	a3,0x1
 8e8:	00d77363          	bgeu	a4,a3,8ee <malloc+0x44>
 8ec:	6a05                	lui	s4,0x1
 8ee:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 8f2:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8f6:	00000917          	auipc	s2,0x0
 8fa:	11a90913          	addi	s2,s2,282 # a10 <freep>
  if(p == (char*)-1)
 8fe:	5afd                	li	s5,-1
 900:	a88d                	j	972 <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
 902:	00000797          	auipc	a5,0x0
 906:	11678793          	addi	a5,a5,278 # a18 <base>
 90a:	00000717          	auipc	a4,0x0
 90e:	10f73323          	sd	a5,262(a4) # a10 <freep>
 912:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 914:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 918:	b7e1                	j	8e0 <malloc+0x36>
      if(p->s.size == nunits)
 91a:	02e48b63          	beq	s1,a4,950 <malloc+0xa6>
        p->s.size -= nunits;
 91e:	4137073b          	subw	a4,a4,s3
 922:	c798                	sw	a4,8(a5)
        p += p->s.size;
 924:	1702                	slli	a4,a4,0x20
 926:	9301                	srli	a4,a4,0x20
 928:	0712                	slli	a4,a4,0x4
 92a:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 92c:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 930:	00000717          	auipc	a4,0x0
 934:	0ea73023          	sd	a0,224(a4) # a10 <freep>
      return (void*)(p + 1);
 938:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 93c:	70e2                	ld	ra,56(sp)
 93e:	7442                	ld	s0,48(sp)
 940:	74a2                	ld	s1,40(sp)
 942:	7902                	ld	s2,32(sp)
 944:	69e2                	ld	s3,24(sp)
 946:	6a42                	ld	s4,16(sp)
 948:	6aa2                	ld	s5,8(sp)
 94a:	6b02                	ld	s6,0(sp)
 94c:	6121                	addi	sp,sp,64
 94e:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 950:	6398                	ld	a4,0(a5)
 952:	e118                	sd	a4,0(a0)
 954:	bff1                	j	930 <malloc+0x86>
  hp->s.size = nu;
 956:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 95a:	0541                	addi	a0,a0,16
 95c:	00000097          	auipc	ra,0x0
 960:	ec6080e7          	jalr	-314(ra) # 822 <free>
  return freep;
 964:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 968:	d971                	beqz	a0,93c <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 96a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 96c:	4798                	lw	a4,8(a5)
 96e:	fa9776e3          	bgeu	a4,s1,91a <malloc+0x70>
    if(p == freep)
 972:	00093703          	ld	a4,0(s2)
 976:	853e                	mv	a0,a5
 978:	fef719e3          	bne	a4,a5,96a <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
 97c:	8552                	mv	a0,s4
 97e:	00000097          	auipc	ra,0x0
 982:	b7e080e7          	jalr	-1154(ra) # 4fc <sbrk>
  if(p == (char*)-1)
 986:	fd5518e3          	bne	a0,s5,956 <malloc+0xac>
        return 0;
 98a:	4501                	li	a0,0
 98c:	bf45                	j	93c <malloc+0x92>
