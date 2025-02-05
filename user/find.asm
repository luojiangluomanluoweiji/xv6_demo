
user/_find:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <find>:
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fs.h"

void find(char* path,char* target)
{
   0:	d8010113          	addi	sp,sp,-640
   4:	26113c23          	sd	ra,632(sp)
   8:	26813823          	sd	s0,624(sp)
   c:	26913423          	sd	s1,616(sp)
  10:	27213023          	sd	s2,608(sp)
  14:	25313c23          	sd	s3,600(sp)
  18:	25413823          	sd	s4,592(sp)
  1c:	25513423          	sd	s5,584(sp)
  20:	25613023          	sd	s6,576(sp)
  24:	23713c23          	sd	s7,568(sp)
  28:	0500                	addi	s0,sp,640
  2a:	892a                	mv	s2,a0
  2c:	89ae                	mv	s3,a1
	int fd;
	struct dirent de;
	struct stat st;

	//if!
	if((fd=open(path,0))<0){//forget 
  2e:	4581                	li	a1,0
  30:	00000097          	auipc	ra,0x0
  34:	4c0080e7          	jalr	1216(ra) # 4f0 <open>
  38:	08054963          	bltz	a0,ca <find+0xca>
  3c:	84aa                	mv	s1,a0

		fprintf(2,"find: cannot open %s\n",path);
		return;
	}
	//if!
	if(fstat(fd,&st)<0){
  3e:	d8840593          	addi	a1,s0,-632
  42:	00000097          	auipc	ra,0x0
  46:	4c6080e7          	jalr	1222(ra) # 508 <fstat>
  4a:	08054b63          	bltz	a0,e0 <find+0xe0>
		fprintf(2, "find: cannot stat %s\n", path);
		close(fd);
		return;
	}

	switch(st.type){
  4e:	d9041783          	lh	a5,-624(s0)
  52:	0007869b          	sext.w	a3,a5
  56:	4705                	li	a4,1
  58:	0ae68e63          	beq	a3,a4,114 <find+0x114>
  5c:	4709                	li	a4,2
  5e:	02e69c63          	bne	a3,a4,96 <find+0x96>
		case T_FILE:
      if(strcmp(path+strlen(path)-strlen(target),target)==0){
  62:	854a                	mv	a0,s2
  64:	00000097          	auipc	ra,0x0
  68:	21e080e7          	jalr	542(ra) # 282 <strlen>
  6c:	00050a1b          	sext.w	s4,a0
  70:	854e                	mv	a0,s3
  72:	00000097          	auipc	ra,0x0
  76:	210080e7          	jalr	528(ra) # 282 <strlen>
  7a:	1a02                	slli	s4,s4,0x20
  7c:	020a5a13          	srli	s4,s4,0x20
  80:	1502                	slli	a0,a0,0x20
  82:	9101                	srli	a0,a0,0x20
  84:	40aa0533          	sub	a0,s4,a0
  88:	85ce                	mv	a1,s3
  8a:	954a                	add	a0,a0,s2
  8c:	00000097          	auipc	ra,0x0
  90:	1ca080e7          	jalr	458(ra) # 256 <strcmp>
  94:	c535                	beqz	a0,100 <find+0x100>
		      }

		}
		break;
	}
	close(fd);
  96:	8526                	mv	a0,s1
  98:	00000097          	auipc	ra,0x0
  9c:	440080e7          	jalr	1088(ra) # 4d8 <close>
}
  a0:	27813083          	ld	ra,632(sp)
  a4:	27013403          	ld	s0,624(sp)
  a8:	26813483          	ld	s1,616(sp)
  ac:	26013903          	ld	s2,608(sp)
  b0:	25813983          	ld	s3,600(sp)
  b4:	25013a03          	ld	s4,592(sp)
  b8:	24813a83          	ld	s5,584(sp)
  bc:	24013b03          	ld	s6,576(sp)
  c0:	23813b83          	ld	s7,568(sp)
  c4:	28010113          	addi	sp,sp,640
  c8:	8082                	ret
		fprintf(2,"find: cannot open %s\n",path);
  ca:	864a                	mv	a2,s2
  cc:	00001597          	auipc	a1,0x1
  d0:	90458593          	addi	a1,a1,-1788 # 9d0 <malloc+0xea>
  d4:	4509                	li	a0,2
  d6:	00000097          	auipc	ra,0x0
  da:	724080e7          	jalr	1828(ra) # 7fa <fprintf>
		return;
  de:	b7c9                	j	a0 <find+0xa0>
		fprintf(2, "find: cannot stat %s\n", path);
  e0:	864a                	mv	a2,s2
  e2:	00001597          	auipc	a1,0x1
  e6:	90658593          	addi	a1,a1,-1786 # 9e8 <malloc+0x102>
  ea:	4509                	li	a0,2
  ec:	00000097          	auipc	ra,0x0
  f0:	70e080e7          	jalr	1806(ra) # 7fa <fprintf>
		close(fd);
  f4:	8526                	mv	a0,s1
  f6:	00000097          	auipc	ra,0x0
  fa:	3e2080e7          	jalr	994(ra) # 4d8 <close>
		return;
  fe:	b74d                	j	a0 <find+0xa0>
	      printf("%s\n",path);//*target or target?
 100:	85ca                	mv	a1,s2
 102:	00001517          	auipc	a0,0x1
 106:	8fe50513          	addi	a0,a0,-1794 # a00 <malloc+0x11a>
 10a:	00000097          	auipc	ra,0x0
 10e:	71e080e7          	jalr	1822(ra) # 828 <printf>
 112:	b751                	j	96 <find+0x96>
      strcpy(buf,path);
 114:	85ca                	mv	a1,s2
 116:	db040513          	addi	a0,s0,-592
 11a:	00000097          	auipc	ra,0x0
 11e:	120080e7          	jalr	288(ra) # 23a <strcpy>
      p=buf+strlen(buf);
 122:	db040513          	addi	a0,s0,-592
 126:	00000097          	auipc	ra,0x0
 12a:	15c080e7          	jalr	348(ra) # 282 <strlen>
 12e:	1502                	slli	a0,a0,0x20
 130:	9101                	srli	a0,a0,0x20
 132:	db040793          	addi	a5,s0,-592
 136:	953e                	add	a0,a0,a5
      *p++='/';
 138:	00150a93          	addi	s5,a0,1
 13c:	02f00793          	li	a5,47
 140:	00f50023          	sb	a5,0(a0)
		      if(strcmp(buf+strlen(buf)-2,"/.")!=0&&strcmp(buf+strlen(buf)-3,"/..")!=0){
 144:	00001a17          	auipc	s4,0x1
 148:	8c4a0a13          	addi	s4,s4,-1852 # a08 <malloc+0x122>
 14c:	db040b13          	addi	s6,s0,-592
 150:	00001b97          	auipc	s7,0x1
 154:	8c0b8b93          	addi	s7,s7,-1856 # a10 <malloc+0x12a>
 158:	895a                	mv	s2,s6
      while(read(fd,&de,sizeof(de))==sizeof(de)){
 15a:	4641                	li	a2,16
 15c:	da040593          	addi	a1,s0,-608
 160:	8526                	mv	a0,s1
 162:	00000097          	auipc	ra,0x0
 166:	366080e7          	jalr	870(ra) # 4c8 <read>
 16a:	47c1                	li	a5,16
 16c:	f2f515e3          	bne	a0,a5,96 <find+0x96>
		      if(de.inum==0) continue;
 170:	da045783          	lhu	a5,-608(s0)
 174:	d3fd                	beqz	a5,15a <find+0x15a>
		      memmove(p,de.name,DIRSIZ);//*?
 176:	4639                	li	a2,14
 178:	da240593          	addi	a1,s0,-606
 17c:	8556                	mv	a0,s5
 17e:	00000097          	auipc	ra,0x0
 182:	27c080e7          	jalr	636(ra) # 3fa <memmove>
		      if(strcmp(buf+strlen(buf)-2,"/.")!=0&&strcmp(buf+strlen(buf)-3,"/..")!=0){
 186:	854a                	mv	a0,s2
 188:	00000097          	auipc	ra,0x0
 18c:	0fa080e7          	jalr	250(ra) # 282 <strlen>
 190:	1502                	slli	a0,a0,0x20
 192:	9101                	srli	a0,a0,0x20
 194:	1579                	addi	a0,a0,-2
 196:	85d2                	mv	a1,s4
 198:	db040793          	addi	a5,s0,-592
 19c:	953e                	add	a0,a0,a5
 19e:	00000097          	auipc	ra,0x0
 1a2:	0b8080e7          	jalr	184(ra) # 256 <strcmp>
 1a6:	d955                	beqz	a0,15a <find+0x15a>
 1a8:	854a                	mv	a0,s2
 1aa:	00000097          	auipc	ra,0x0
 1ae:	0d8080e7          	jalr	216(ra) # 282 <strlen>
 1b2:	1502                	slli	a0,a0,0x20
 1b4:	9101                	srli	a0,a0,0x20
 1b6:	1575                	addi	a0,a0,-3
 1b8:	85de                	mv	a1,s7
 1ba:	db040793          	addi	a5,s0,-592
 1be:	953e                	add	a0,a0,a5
 1c0:	00000097          	auipc	ra,0x0
 1c4:	096080e7          	jalr	150(ra) # 256 <strcmp>
 1c8:	d949                	beqz	a0,15a <find+0x15a>
		      find(buf,target);
 1ca:	85ce                	mv	a1,s3
 1cc:	855a                	mv	a0,s6
 1ce:	00000097          	auipc	ra,0x0
 1d2:	e32080e7          	jalr	-462(ra) # 0 <find>
 1d6:	b751                	j	15a <find+0x15a>

00000000000001d8 <main>:

int main(int argc,char* argv[])
{
 1d8:	de010113          	addi	sp,sp,-544
 1dc:	20113c23          	sd	ra,536(sp)
 1e0:	20813823          	sd	s0,528(sp)
 1e4:	20913423          	sd	s1,520(sp)
 1e8:	1400                	addi	s0,sp,544
	//difference between char* argv[] and char* argv
	if(argc<3){
 1ea:	4789                	li	a5,2
 1ec:	00a7cf63          	blt	a5,a0,20a <main+0x32>
		printf("argument is too less\n");
 1f0:	00001517          	auipc	a0,0x1
 1f4:	82850513          	addi	a0,a0,-2008 # a18 <malloc+0x132>
 1f8:	00000097          	auipc	ra,0x0
 1fc:	630080e7          	jalr	1584(ra) # 828 <printf>
		exit(0);
 200:	4501                	li	a0,0
 202:	00000097          	auipc	ra,0x0
 206:	2ae080e7          	jalr	686(ra) # 4b0 <exit>
 20a:	84ae                	mv	s1,a1
	}


	char target[512];
	target[0]='/';
 20c:	02f00793          	li	a5,47
 210:	def40023          	sb	a5,-544(s0)
	strcpy(target+1,argv[2]);//should be check:argv[2]pointer?or not
 214:	698c                	ld	a1,16(a1)
 216:	de140513          	addi	a0,s0,-543
 21a:	00000097          	auipc	ra,0x0
 21e:	020080e7          	jalr	32(ra) # 23a <strcpy>
	find(argv[1],target);
 222:	de040593          	addi	a1,s0,-544
 226:	6488                	ld	a0,8(s1)
 228:	00000097          	auipc	ra,0x0
 22c:	dd8080e7          	jalr	-552(ra) # 0 <find>
	exit(0);
 230:	4501                	li	a0,0
 232:	00000097          	auipc	ra,0x0
 236:	27e080e7          	jalr	638(ra) # 4b0 <exit>

000000000000023a <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 23a:	1141                	addi	sp,sp,-16
 23c:	e422                	sd	s0,8(sp)
 23e:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 240:	87aa                	mv	a5,a0
 242:	0585                	addi	a1,a1,1
 244:	0785                	addi	a5,a5,1
 246:	fff5c703          	lbu	a4,-1(a1)
 24a:	fee78fa3          	sb	a4,-1(a5)
 24e:	fb75                	bnez	a4,242 <strcpy+0x8>
    ;
  return os;
}
 250:	6422                	ld	s0,8(sp)
 252:	0141                	addi	sp,sp,16
 254:	8082                	ret

0000000000000256 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 256:	1141                	addi	sp,sp,-16
 258:	e422                	sd	s0,8(sp)
 25a:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 25c:	00054783          	lbu	a5,0(a0)
 260:	cb91                	beqz	a5,274 <strcmp+0x1e>
 262:	0005c703          	lbu	a4,0(a1)
 266:	00f71763          	bne	a4,a5,274 <strcmp+0x1e>
    p++, q++;
 26a:	0505                	addi	a0,a0,1
 26c:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 26e:	00054783          	lbu	a5,0(a0)
 272:	fbe5                	bnez	a5,262 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 274:	0005c503          	lbu	a0,0(a1)
}
 278:	40a7853b          	subw	a0,a5,a0
 27c:	6422                	ld	s0,8(sp)
 27e:	0141                	addi	sp,sp,16
 280:	8082                	ret

0000000000000282 <strlen>:

uint
strlen(const char *s)
{
 282:	1141                	addi	sp,sp,-16
 284:	e422                	sd	s0,8(sp)
 286:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 288:	00054783          	lbu	a5,0(a0)
 28c:	cf91                	beqz	a5,2a8 <strlen+0x26>
 28e:	0505                	addi	a0,a0,1
 290:	87aa                	mv	a5,a0
 292:	4685                	li	a3,1
 294:	9e89                	subw	a3,a3,a0
 296:	00f6853b          	addw	a0,a3,a5
 29a:	0785                	addi	a5,a5,1
 29c:	fff7c703          	lbu	a4,-1(a5)
 2a0:	fb7d                	bnez	a4,296 <strlen+0x14>
    ;
  return n;
}
 2a2:	6422                	ld	s0,8(sp)
 2a4:	0141                	addi	sp,sp,16
 2a6:	8082                	ret
  for(n = 0; s[n]; n++)
 2a8:	4501                	li	a0,0
 2aa:	bfe5                	j	2a2 <strlen+0x20>

00000000000002ac <memset>:

void*
memset(void *dst, int c, uint n)
{
 2ac:	1141                	addi	sp,sp,-16
 2ae:	e422                	sd	s0,8(sp)
 2b0:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 2b2:	ce09                	beqz	a2,2cc <memset+0x20>
 2b4:	87aa                	mv	a5,a0
 2b6:	fff6071b          	addiw	a4,a2,-1
 2ba:	1702                	slli	a4,a4,0x20
 2bc:	9301                	srli	a4,a4,0x20
 2be:	0705                	addi	a4,a4,1
 2c0:	972a                	add	a4,a4,a0
    cdst[i] = c;
 2c2:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 2c6:	0785                	addi	a5,a5,1
 2c8:	fee79de3          	bne	a5,a4,2c2 <memset+0x16>
  }
  return dst;
}
 2cc:	6422                	ld	s0,8(sp)
 2ce:	0141                	addi	sp,sp,16
 2d0:	8082                	ret

00000000000002d2 <strchr>:

char*
strchr(const char *s, char c)
{
 2d2:	1141                	addi	sp,sp,-16
 2d4:	e422                	sd	s0,8(sp)
 2d6:	0800                	addi	s0,sp,16
  for(; *s; s++)
 2d8:	00054783          	lbu	a5,0(a0)
 2dc:	cb99                	beqz	a5,2f2 <strchr+0x20>
    if(*s == c)
 2de:	00f58763          	beq	a1,a5,2ec <strchr+0x1a>
  for(; *s; s++)
 2e2:	0505                	addi	a0,a0,1
 2e4:	00054783          	lbu	a5,0(a0)
 2e8:	fbfd                	bnez	a5,2de <strchr+0xc>
      return (char*)s;
  return 0;
 2ea:	4501                	li	a0,0
}
 2ec:	6422                	ld	s0,8(sp)
 2ee:	0141                	addi	sp,sp,16
 2f0:	8082                	ret
  return 0;
 2f2:	4501                	li	a0,0
 2f4:	bfe5                	j	2ec <strchr+0x1a>

00000000000002f6 <gets>:

char*
gets(char *buf, int max)
{
 2f6:	711d                	addi	sp,sp,-96
 2f8:	ec86                	sd	ra,88(sp)
 2fa:	e8a2                	sd	s0,80(sp)
 2fc:	e4a6                	sd	s1,72(sp)
 2fe:	e0ca                	sd	s2,64(sp)
 300:	fc4e                	sd	s3,56(sp)
 302:	f852                	sd	s4,48(sp)
 304:	f456                	sd	s5,40(sp)
 306:	f05a                	sd	s6,32(sp)
 308:	ec5e                	sd	s7,24(sp)
 30a:	1080                	addi	s0,sp,96
 30c:	8baa                	mv	s7,a0
 30e:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 310:	892a                	mv	s2,a0
 312:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 314:	4aa9                	li	s5,10
 316:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 318:	89a6                	mv	s3,s1
 31a:	2485                	addiw	s1,s1,1
 31c:	0344d863          	bge	s1,s4,34c <gets+0x56>
    cc = read(0, &c, 1);
 320:	4605                	li	a2,1
 322:	faf40593          	addi	a1,s0,-81
 326:	4501                	li	a0,0
 328:	00000097          	auipc	ra,0x0
 32c:	1a0080e7          	jalr	416(ra) # 4c8 <read>
    if(cc < 1)
 330:	00a05e63          	blez	a0,34c <gets+0x56>
    buf[i++] = c;
 334:	faf44783          	lbu	a5,-81(s0)
 338:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 33c:	01578763          	beq	a5,s5,34a <gets+0x54>
 340:	0905                	addi	s2,s2,1
 342:	fd679be3          	bne	a5,s6,318 <gets+0x22>
  for(i=0; i+1 < max; ){
 346:	89a6                	mv	s3,s1
 348:	a011                	j	34c <gets+0x56>
 34a:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 34c:	99de                	add	s3,s3,s7
 34e:	00098023          	sb	zero,0(s3)
  return buf;
}
 352:	855e                	mv	a0,s7
 354:	60e6                	ld	ra,88(sp)
 356:	6446                	ld	s0,80(sp)
 358:	64a6                	ld	s1,72(sp)
 35a:	6906                	ld	s2,64(sp)
 35c:	79e2                	ld	s3,56(sp)
 35e:	7a42                	ld	s4,48(sp)
 360:	7aa2                	ld	s5,40(sp)
 362:	7b02                	ld	s6,32(sp)
 364:	6be2                	ld	s7,24(sp)
 366:	6125                	addi	sp,sp,96
 368:	8082                	ret

000000000000036a <stat>:

int
stat(const char *n, struct stat *st)
{
 36a:	1101                	addi	sp,sp,-32
 36c:	ec06                	sd	ra,24(sp)
 36e:	e822                	sd	s0,16(sp)
 370:	e426                	sd	s1,8(sp)
 372:	e04a                	sd	s2,0(sp)
 374:	1000                	addi	s0,sp,32
 376:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 378:	4581                	li	a1,0
 37a:	00000097          	auipc	ra,0x0
 37e:	176080e7          	jalr	374(ra) # 4f0 <open>
  if(fd < 0)
 382:	02054563          	bltz	a0,3ac <stat+0x42>
 386:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 388:	85ca                	mv	a1,s2
 38a:	00000097          	auipc	ra,0x0
 38e:	17e080e7          	jalr	382(ra) # 508 <fstat>
 392:	892a                	mv	s2,a0
  close(fd);
 394:	8526                	mv	a0,s1
 396:	00000097          	auipc	ra,0x0
 39a:	142080e7          	jalr	322(ra) # 4d8 <close>
  return r;
}
 39e:	854a                	mv	a0,s2
 3a0:	60e2                	ld	ra,24(sp)
 3a2:	6442                	ld	s0,16(sp)
 3a4:	64a2                	ld	s1,8(sp)
 3a6:	6902                	ld	s2,0(sp)
 3a8:	6105                	addi	sp,sp,32
 3aa:	8082                	ret
    return -1;
 3ac:	597d                	li	s2,-1
 3ae:	bfc5                	j	39e <stat+0x34>

00000000000003b0 <atoi>:

int
atoi(const char *s)
{
 3b0:	1141                	addi	sp,sp,-16
 3b2:	e422                	sd	s0,8(sp)
 3b4:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3b6:	00054603          	lbu	a2,0(a0)
 3ba:	fd06079b          	addiw	a5,a2,-48
 3be:	0ff7f793          	andi	a5,a5,255
 3c2:	4725                	li	a4,9
 3c4:	02f76963          	bltu	a4,a5,3f6 <atoi+0x46>
 3c8:	86aa                	mv	a3,a0
  n = 0;
 3ca:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 3cc:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 3ce:	0685                	addi	a3,a3,1
 3d0:	0025179b          	slliw	a5,a0,0x2
 3d4:	9fa9                	addw	a5,a5,a0
 3d6:	0017979b          	slliw	a5,a5,0x1
 3da:	9fb1                	addw	a5,a5,a2
 3dc:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 3e0:	0006c603          	lbu	a2,0(a3)
 3e4:	fd06071b          	addiw	a4,a2,-48
 3e8:	0ff77713          	andi	a4,a4,255
 3ec:	fee5f1e3          	bgeu	a1,a4,3ce <atoi+0x1e>
  return n;
}
 3f0:	6422                	ld	s0,8(sp)
 3f2:	0141                	addi	sp,sp,16
 3f4:	8082                	ret
  n = 0;
 3f6:	4501                	li	a0,0
 3f8:	bfe5                	j	3f0 <atoi+0x40>

00000000000003fa <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3fa:	1141                	addi	sp,sp,-16
 3fc:	e422                	sd	s0,8(sp)
 3fe:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 400:	02b57663          	bgeu	a0,a1,42c <memmove+0x32>
    while(n-- > 0)
 404:	02c05163          	blez	a2,426 <memmove+0x2c>
 408:	fff6079b          	addiw	a5,a2,-1
 40c:	1782                	slli	a5,a5,0x20
 40e:	9381                	srli	a5,a5,0x20
 410:	0785                	addi	a5,a5,1
 412:	97aa                	add	a5,a5,a0
  dst = vdst;
 414:	872a                	mv	a4,a0
      *dst++ = *src++;
 416:	0585                	addi	a1,a1,1
 418:	0705                	addi	a4,a4,1
 41a:	fff5c683          	lbu	a3,-1(a1)
 41e:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 422:	fee79ae3          	bne	a5,a4,416 <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 426:	6422                	ld	s0,8(sp)
 428:	0141                	addi	sp,sp,16
 42a:	8082                	ret
    dst += n;
 42c:	00c50733          	add	a4,a0,a2
    src += n;
 430:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 432:	fec05ae3          	blez	a2,426 <memmove+0x2c>
 436:	fff6079b          	addiw	a5,a2,-1
 43a:	1782                	slli	a5,a5,0x20
 43c:	9381                	srli	a5,a5,0x20
 43e:	fff7c793          	not	a5,a5
 442:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 444:	15fd                	addi	a1,a1,-1
 446:	177d                	addi	a4,a4,-1
 448:	0005c683          	lbu	a3,0(a1)
 44c:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 450:	fee79ae3          	bne	a5,a4,444 <memmove+0x4a>
 454:	bfc9                	j	426 <memmove+0x2c>

0000000000000456 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 456:	1141                	addi	sp,sp,-16
 458:	e422                	sd	s0,8(sp)
 45a:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 45c:	ca05                	beqz	a2,48c <memcmp+0x36>
 45e:	fff6069b          	addiw	a3,a2,-1
 462:	1682                	slli	a3,a3,0x20
 464:	9281                	srli	a3,a3,0x20
 466:	0685                	addi	a3,a3,1
 468:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 46a:	00054783          	lbu	a5,0(a0)
 46e:	0005c703          	lbu	a4,0(a1)
 472:	00e79863          	bne	a5,a4,482 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 476:	0505                	addi	a0,a0,1
    p2++;
 478:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 47a:	fed518e3          	bne	a0,a3,46a <memcmp+0x14>
  }
  return 0;
 47e:	4501                	li	a0,0
 480:	a019                	j	486 <memcmp+0x30>
      return *p1 - *p2;
 482:	40e7853b          	subw	a0,a5,a4
}
 486:	6422                	ld	s0,8(sp)
 488:	0141                	addi	sp,sp,16
 48a:	8082                	ret
  return 0;
 48c:	4501                	li	a0,0
 48e:	bfe5                	j	486 <memcmp+0x30>

0000000000000490 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 490:	1141                	addi	sp,sp,-16
 492:	e406                	sd	ra,8(sp)
 494:	e022                	sd	s0,0(sp)
 496:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 498:	00000097          	auipc	ra,0x0
 49c:	f62080e7          	jalr	-158(ra) # 3fa <memmove>
}
 4a0:	60a2                	ld	ra,8(sp)
 4a2:	6402                	ld	s0,0(sp)
 4a4:	0141                	addi	sp,sp,16
 4a6:	8082                	ret

00000000000004a8 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 4a8:	4885                	li	a7,1
 ecall
 4aa:	00000073          	ecall
 ret
 4ae:	8082                	ret

00000000000004b0 <exit>:
.global exit
exit:
 li a7, SYS_exit
 4b0:	4889                	li	a7,2
 ecall
 4b2:	00000073          	ecall
 ret
 4b6:	8082                	ret

00000000000004b8 <wait>:
.global wait
wait:
 li a7, SYS_wait
 4b8:	488d                	li	a7,3
 ecall
 4ba:	00000073          	ecall
 ret
 4be:	8082                	ret

00000000000004c0 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 4c0:	4891                	li	a7,4
 ecall
 4c2:	00000073          	ecall
 ret
 4c6:	8082                	ret

00000000000004c8 <read>:
.global read
read:
 li a7, SYS_read
 4c8:	4895                	li	a7,5
 ecall
 4ca:	00000073          	ecall
 ret
 4ce:	8082                	ret

00000000000004d0 <write>:
.global write
write:
 li a7, SYS_write
 4d0:	48c1                	li	a7,16
 ecall
 4d2:	00000073          	ecall
 ret
 4d6:	8082                	ret

00000000000004d8 <close>:
.global close
close:
 li a7, SYS_close
 4d8:	48d5                	li	a7,21
 ecall
 4da:	00000073          	ecall
 ret
 4de:	8082                	ret

00000000000004e0 <kill>:
.global kill
kill:
 li a7, SYS_kill
 4e0:	4899                	li	a7,6
 ecall
 4e2:	00000073          	ecall
 ret
 4e6:	8082                	ret

00000000000004e8 <exec>:
.global exec
exec:
 li a7, SYS_exec
 4e8:	489d                	li	a7,7
 ecall
 4ea:	00000073          	ecall
 ret
 4ee:	8082                	ret

00000000000004f0 <open>:
.global open
open:
 li a7, SYS_open
 4f0:	48bd                	li	a7,15
 ecall
 4f2:	00000073          	ecall
 ret
 4f6:	8082                	ret

00000000000004f8 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 4f8:	48c5                	li	a7,17
 ecall
 4fa:	00000073          	ecall
 ret
 4fe:	8082                	ret

0000000000000500 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 500:	48c9                	li	a7,18
 ecall
 502:	00000073          	ecall
 ret
 506:	8082                	ret

0000000000000508 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 508:	48a1                	li	a7,8
 ecall
 50a:	00000073          	ecall
 ret
 50e:	8082                	ret

0000000000000510 <link>:
.global link
link:
 li a7, SYS_link
 510:	48cd                	li	a7,19
 ecall
 512:	00000073          	ecall
 ret
 516:	8082                	ret

0000000000000518 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 518:	48d1                	li	a7,20
 ecall
 51a:	00000073          	ecall
 ret
 51e:	8082                	ret

0000000000000520 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 520:	48a5                	li	a7,9
 ecall
 522:	00000073          	ecall
 ret
 526:	8082                	ret

0000000000000528 <dup>:
.global dup
dup:
 li a7, SYS_dup
 528:	48a9                	li	a7,10
 ecall
 52a:	00000073          	ecall
 ret
 52e:	8082                	ret

0000000000000530 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 530:	48ad                	li	a7,11
 ecall
 532:	00000073          	ecall
 ret
 536:	8082                	ret

0000000000000538 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 538:	48b1                	li	a7,12
 ecall
 53a:	00000073          	ecall
 ret
 53e:	8082                	ret

0000000000000540 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 540:	48b5                	li	a7,13
 ecall
 542:	00000073          	ecall
 ret
 546:	8082                	ret

0000000000000548 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 548:	48b9                	li	a7,14
 ecall
 54a:	00000073          	ecall
 ret
 54e:	8082                	ret

0000000000000550 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 550:	1101                	addi	sp,sp,-32
 552:	ec06                	sd	ra,24(sp)
 554:	e822                	sd	s0,16(sp)
 556:	1000                	addi	s0,sp,32
 558:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 55c:	4605                	li	a2,1
 55e:	fef40593          	addi	a1,s0,-17
 562:	00000097          	auipc	ra,0x0
 566:	f6e080e7          	jalr	-146(ra) # 4d0 <write>
}
 56a:	60e2                	ld	ra,24(sp)
 56c:	6442                	ld	s0,16(sp)
 56e:	6105                	addi	sp,sp,32
 570:	8082                	ret

0000000000000572 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 572:	7139                	addi	sp,sp,-64
 574:	fc06                	sd	ra,56(sp)
 576:	f822                	sd	s0,48(sp)
 578:	f426                	sd	s1,40(sp)
 57a:	f04a                	sd	s2,32(sp)
 57c:	ec4e                	sd	s3,24(sp)
 57e:	0080                	addi	s0,sp,64
 580:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 582:	c299                	beqz	a3,588 <printint+0x16>
 584:	0805c863          	bltz	a1,614 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 588:	2581                	sext.w	a1,a1
  neg = 0;
 58a:	4881                	li	a7,0
 58c:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 590:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 592:	2601                	sext.w	a2,a2
 594:	00000517          	auipc	a0,0x0
 598:	4a450513          	addi	a0,a0,1188 # a38 <digits>
 59c:	883a                	mv	a6,a4
 59e:	2705                	addiw	a4,a4,1
 5a0:	02c5f7bb          	remuw	a5,a1,a2
 5a4:	1782                	slli	a5,a5,0x20
 5a6:	9381                	srli	a5,a5,0x20
 5a8:	97aa                	add	a5,a5,a0
 5aa:	0007c783          	lbu	a5,0(a5)
 5ae:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 5b2:	0005879b          	sext.w	a5,a1
 5b6:	02c5d5bb          	divuw	a1,a1,a2
 5ba:	0685                	addi	a3,a3,1
 5bc:	fec7f0e3          	bgeu	a5,a2,59c <printint+0x2a>
  if(neg)
 5c0:	00088b63          	beqz	a7,5d6 <printint+0x64>
    buf[i++] = '-';
 5c4:	fd040793          	addi	a5,s0,-48
 5c8:	973e                	add	a4,a4,a5
 5ca:	02d00793          	li	a5,45
 5ce:	fef70823          	sb	a5,-16(a4)
 5d2:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 5d6:	02e05863          	blez	a4,606 <printint+0x94>
 5da:	fc040793          	addi	a5,s0,-64
 5de:	00e78933          	add	s2,a5,a4
 5e2:	fff78993          	addi	s3,a5,-1
 5e6:	99ba                	add	s3,s3,a4
 5e8:	377d                	addiw	a4,a4,-1
 5ea:	1702                	slli	a4,a4,0x20
 5ec:	9301                	srli	a4,a4,0x20
 5ee:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 5f2:	fff94583          	lbu	a1,-1(s2)
 5f6:	8526                	mv	a0,s1
 5f8:	00000097          	auipc	ra,0x0
 5fc:	f58080e7          	jalr	-168(ra) # 550 <putc>
  while(--i >= 0)
 600:	197d                	addi	s2,s2,-1
 602:	ff3918e3          	bne	s2,s3,5f2 <printint+0x80>
}
 606:	70e2                	ld	ra,56(sp)
 608:	7442                	ld	s0,48(sp)
 60a:	74a2                	ld	s1,40(sp)
 60c:	7902                	ld	s2,32(sp)
 60e:	69e2                	ld	s3,24(sp)
 610:	6121                	addi	sp,sp,64
 612:	8082                	ret
    x = -xx;
 614:	40b005bb          	negw	a1,a1
    neg = 1;
 618:	4885                	li	a7,1
    x = -xx;
 61a:	bf8d                	j	58c <printint+0x1a>

000000000000061c <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 61c:	7119                	addi	sp,sp,-128
 61e:	fc86                	sd	ra,120(sp)
 620:	f8a2                	sd	s0,112(sp)
 622:	f4a6                	sd	s1,104(sp)
 624:	f0ca                	sd	s2,96(sp)
 626:	ecce                	sd	s3,88(sp)
 628:	e8d2                	sd	s4,80(sp)
 62a:	e4d6                	sd	s5,72(sp)
 62c:	e0da                	sd	s6,64(sp)
 62e:	fc5e                	sd	s7,56(sp)
 630:	f862                	sd	s8,48(sp)
 632:	f466                	sd	s9,40(sp)
 634:	f06a                	sd	s10,32(sp)
 636:	ec6e                	sd	s11,24(sp)
 638:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 63a:	0005c903          	lbu	s2,0(a1)
 63e:	18090f63          	beqz	s2,7dc <vprintf+0x1c0>
 642:	8aaa                	mv	s5,a0
 644:	8b32                	mv	s6,a2
 646:	00158493          	addi	s1,a1,1
  state = 0;
 64a:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 64c:	02500a13          	li	s4,37
      if(c == 'd'){
 650:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 654:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 658:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 65c:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 660:	00000b97          	auipc	s7,0x0
 664:	3d8b8b93          	addi	s7,s7,984 # a38 <digits>
 668:	a839                	j	686 <vprintf+0x6a>
        putc(fd, c);
 66a:	85ca                	mv	a1,s2
 66c:	8556                	mv	a0,s5
 66e:	00000097          	auipc	ra,0x0
 672:	ee2080e7          	jalr	-286(ra) # 550 <putc>
 676:	a019                	j	67c <vprintf+0x60>
    } else if(state == '%'){
 678:	01498f63          	beq	s3,s4,696 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 67c:	0485                	addi	s1,s1,1
 67e:	fff4c903          	lbu	s2,-1(s1)
 682:	14090d63          	beqz	s2,7dc <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 686:	0009079b          	sext.w	a5,s2
    if(state == 0){
 68a:	fe0997e3          	bnez	s3,678 <vprintf+0x5c>
      if(c == '%'){
 68e:	fd479ee3          	bne	a5,s4,66a <vprintf+0x4e>
        state = '%';
 692:	89be                	mv	s3,a5
 694:	b7e5                	j	67c <vprintf+0x60>
      if(c == 'd'){
 696:	05878063          	beq	a5,s8,6d6 <vprintf+0xba>
      } else if(c == 'l') {
 69a:	05978c63          	beq	a5,s9,6f2 <vprintf+0xd6>
      } else if(c == 'x') {
 69e:	07a78863          	beq	a5,s10,70e <vprintf+0xf2>
      } else if(c == 'p') {
 6a2:	09b78463          	beq	a5,s11,72a <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 6a6:	07300713          	li	a4,115
 6aa:	0ce78663          	beq	a5,a4,776 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 6ae:	06300713          	li	a4,99
 6b2:	0ee78e63          	beq	a5,a4,7ae <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 6b6:	11478863          	beq	a5,s4,7c6 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 6ba:	85d2                	mv	a1,s4
 6bc:	8556                	mv	a0,s5
 6be:	00000097          	auipc	ra,0x0
 6c2:	e92080e7          	jalr	-366(ra) # 550 <putc>
        putc(fd, c);
 6c6:	85ca                	mv	a1,s2
 6c8:	8556                	mv	a0,s5
 6ca:	00000097          	auipc	ra,0x0
 6ce:	e86080e7          	jalr	-378(ra) # 550 <putc>
      }
      state = 0;
 6d2:	4981                	li	s3,0
 6d4:	b765                	j	67c <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 6d6:	008b0913          	addi	s2,s6,8
 6da:	4685                	li	a3,1
 6dc:	4629                	li	a2,10
 6de:	000b2583          	lw	a1,0(s6)
 6e2:	8556                	mv	a0,s5
 6e4:	00000097          	auipc	ra,0x0
 6e8:	e8e080e7          	jalr	-370(ra) # 572 <printint>
 6ec:	8b4a                	mv	s6,s2
      state = 0;
 6ee:	4981                	li	s3,0
 6f0:	b771                	j	67c <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6f2:	008b0913          	addi	s2,s6,8
 6f6:	4681                	li	a3,0
 6f8:	4629                	li	a2,10
 6fa:	000b2583          	lw	a1,0(s6)
 6fe:	8556                	mv	a0,s5
 700:	00000097          	auipc	ra,0x0
 704:	e72080e7          	jalr	-398(ra) # 572 <printint>
 708:	8b4a                	mv	s6,s2
      state = 0;
 70a:	4981                	li	s3,0
 70c:	bf85                	j	67c <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 70e:	008b0913          	addi	s2,s6,8
 712:	4681                	li	a3,0
 714:	4641                	li	a2,16
 716:	000b2583          	lw	a1,0(s6)
 71a:	8556                	mv	a0,s5
 71c:	00000097          	auipc	ra,0x0
 720:	e56080e7          	jalr	-426(ra) # 572 <printint>
 724:	8b4a                	mv	s6,s2
      state = 0;
 726:	4981                	li	s3,0
 728:	bf91                	j	67c <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 72a:	008b0793          	addi	a5,s6,8
 72e:	f8f43423          	sd	a5,-120(s0)
 732:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 736:	03000593          	li	a1,48
 73a:	8556                	mv	a0,s5
 73c:	00000097          	auipc	ra,0x0
 740:	e14080e7          	jalr	-492(ra) # 550 <putc>
  putc(fd, 'x');
 744:	85ea                	mv	a1,s10
 746:	8556                	mv	a0,s5
 748:	00000097          	auipc	ra,0x0
 74c:	e08080e7          	jalr	-504(ra) # 550 <putc>
 750:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 752:	03c9d793          	srli	a5,s3,0x3c
 756:	97de                	add	a5,a5,s7
 758:	0007c583          	lbu	a1,0(a5)
 75c:	8556                	mv	a0,s5
 75e:	00000097          	auipc	ra,0x0
 762:	df2080e7          	jalr	-526(ra) # 550 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 766:	0992                	slli	s3,s3,0x4
 768:	397d                	addiw	s2,s2,-1
 76a:	fe0914e3          	bnez	s2,752 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 76e:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 772:	4981                	li	s3,0
 774:	b721                	j	67c <vprintf+0x60>
        s = va_arg(ap, char*);
 776:	008b0993          	addi	s3,s6,8
 77a:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 77e:	02090163          	beqz	s2,7a0 <vprintf+0x184>
        while(*s != 0){
 782:	00094583          	lbu	a1,0(s2)
 786:	c9a1                	beqz	a1,7d6 <vprintf+0x1ba>
          putc(fd, *s);
 788:	8556                	mv	a0,s5
 78a:	00000097          	auipc	ra,0x0
 78e:	dc6080e7          	jalr	-570(ra) # 550 <putc>
          s++;
 792:	0905                	addi	s2,s2,1
        while(*s != 0){
 794:	00094583          	lbu	a1,0(s2)
 798:	f9e5                	bnez	a1,788 <vprintf+0x16c>
        s = va_arg(ap, char*);
 79a:	8b4e                	mv	s6,s3
      state = 0;
 79c:	4981                	li	s3,0
 79e:	bdf9                	j	67c <vprintf+0x60>
          s = "(null)";
 7a0:	00000917          	auipc	s2,0x0
 7a4:	29090913          	addi	s2,s2,656 # a30 <malloc+0x14a>
        while(*s != 0){
 7a8:	02800593          	li	a1,40
 7ac:	bff1                	j	788 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 7ae:	008b0913          	addi	s2,s6,8
 7b2:	000b4583          	lbu	a1,0(s6)
 7b6:	8556                	mv	a0,s5
 7b8:	00000097          	auipc	ra,0x0
 7bc:	d98080e7          	jalr	-616(ra) # 550 <putc>
 7c0:	8b4a                	mv	s6,s2
      state = 0;
 7c2:	4981                	li	s3,0
 7c4:	bd65                	j	67c <vprintf+0x60>
        putc(fd, c);
 7c6:	85d2                	mv	a1,s4
 7c8:	8556                	mv	a0,s5
 7ca:	00000097          	auipc	ra,0x0
 7ce:	d86080e7          	jalr	-634(ra) # 550 <putc>
      state = 0;
 7d2:	4981                	li	s3,0
 7d4:	b565                	j	67c <vprintf+0x60>
        s = va_arg(ap, char*);
 7d6:	8b4e                	mv	s6,s3
      state = 0;
 7d8:	4981                	li	s3,0
 7da:	b54d                	j	67c <vprintf+0x60>
    }
  }
}
 7dc:	70e6                	ld	ra,120(sp)
 7de:	7446                	ld	s0,112(sp)
 7e0:	74a6                	ld	s1,104(sp)
 7e2:	7906                	ld	s2,96(sp)
 7e4:	69e6                	ld	s3,88(sp)
 7e6:	6a46                	ld	s4,80(sp)
 7e8:	6aa6                	ld	s5,72(sp)
 7ea:	6b06                	ld	s6,64(sp)
 7ec:	7be2                	ld	s7,56(sp)
 7ee:	7c42                	ld	s8,48(sp)
 7f0:	7ca2                	ld	s9,40(sp)
 7f2:	7d02                	ld	s10,32(sp)
 7f4:	6de2                	ld	s11,24(sp)
 7f6:	6109                	addi	sp,sp,128
 7f8:	8082                	ret

00000000000007fa <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 7fa:	715d                	addi	sp,sp,-80
 7fc:	ec06                	sd	ra,24(sp)
 7fe:	e822                	sd	s0,16(sp)
 800:	1000                	addi	s0,sp,32
 802:	e010                	sd	a2,0(s0)
 804:	e414                	sd	a3,8(s0)
 806:	e818                	sd	a4,16(s0)
 808:	ec1c                	sd	a5,24(s0)
 80a:	03043023          	sd	a6,32(s0)
 80e:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 812:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 816:	8622                	mv	a2,s0
 818:	00000097          	auipc	ra,0x0
 81c:	e04080e7          	jalr	-508(ra) # 61c <vprintf>
}
 820:	60e2                	ld	ra,24(sp)
 822:	6442                	ld	s0,16(sp)
 824:	6161                	addi	sp,sp,80
 826:	8082                	ret

0000000000000828 <printf>:

void
printf(const char *fmt, ...)
{
 828:	711d                	addi	sp,sp,-96
 82a:	ec06                	sd	ra,24(sp)
 82c:	e822                	sd	s0,16(sp)
 82e:	1000                	addi	s0,sp,32
 830:	e40c                	sd	a1,8(s0)
 832:	e810                	sd	a2,16(s0)
 834:	ec14                	sd	a3,24(s0)
 836:	f018                	sd	a4,32(s0)
 838:	f41c                	sd	a5,40(s0)
 83a:	03043823          	sd	a6,48(s0)
 83e:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 842:	00840613          	addi	a2,s0,8
 846:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 84a:	85aa                	mv	a1,a0
 84c:	4505                	li	a0,1
 84e:	00000097          	auipc	ra,0x0
 852:	dce080e7          	jalr	-562(ra) # 61c <vprintf>
}
 856:	60e2                	ld	ra,24(sp)
 858:	6442                	ld	s0,16(sp)
 85a:	6125                	addi	sp,sp,96
 85c:	8082                	ret

000000000000085e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 85e:	1141                	addi	sp,sp,-16
 860:	e422                	sd	s0,8(sp)
 862:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 864:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 868:	00000797          	auipc	a5,0x0
 86c:	1e87b783          	ld	a5,488(a5) # a50 <freep>
 870:	a805                	j	8a0 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 872:	4618                	lw	a4,8(a2)
 874:	9db9                	addw	a1,a1,a4
 876:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 87a:	6398                	ld	a4,0(a5)
 87c:	6318                	ld	a4,0(a4)
 87e:	fee53823          	sd	a4,-16(a0)
 882:	a091                	j	8c6 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 884:	ff852703          	lw	a4,-8(a0)
 888:	9e39                	addw	a2,a2,a4
 88a:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 88c:	ff053703          	ld	a4,-16(a0)
 890:	e398                	sd	a4,0(a5)
 892:	a099                	j	8d8 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 894:	6398                	ld	a4,0(a5)
 896:	00e7e463          	bltu	a5,a4,89e <free+0x40>
 89a:	00e6ea63          	bltu	a3,a4,8ae <free+0x50>
{
 89e:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8a0:	fed7fae3          	bgeu	a5,a3,894 <free+0x36>
 8a4:	6398                	ld	a4,0(a5)
 8a6:	00e6e463          	bltu	a3,a4,8ae <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8aa:	fee7eae3          	bltu	a5,a4,89e <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 8ae:	ff852583          	lw	a1,-8(a0)
 8b2:	6390                	ld	a2,0(a5)
 8b4:	02059713          	slli	a4,a1,0x20
 8b8:	9301                	srli	a4,a4,0x20
 8ba:	0712                	slli	a4,a4,0x4
 8bc:	9736                	add	a4,a4,a3
 8be:	fae60ae3          	beq	a2,a4,872 <free+0x14>
    bp->s.ptr = p->s.ptr;
 8c2:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 8c6:	4790                	lw	a2,8(a5)
 8c8:	02061713          	slli	a4,a2,0x20
 8cc:	9301                	srli	a4,a4,0x20
 8ce:	0712                	slli	a4,a4,0x4
 8d0:	973e                	add	a4,a4,a5
 8d2:	fae689e3          	beq	a3,a4,884 <free+0x26>
  } else
    p->s.ptr = bp;
 8d6:	e394                	sd	a3,0(a5)
  freep = p;
 8d8:	00000717          	auipc	a4,0x0
 8dc:	16f73c23          	sd	a5,376(a4) # a50 <freep>
}
 8e0:	6422                	ld	s0,8(sp)
 8e2:	0141                	addi	sp,sp,16
 8e4:	8082                	ret

00000000000008e6 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8e6:	7139                	addi	sp,sp,-64
 8e8:	fc06                	sd	ra,56(sp)
 8ea:	f822                	sd	s0,48(sp)
 8ec:	f426                	sd	s1,40(sp)
 8ee:	f04a                	sd	s2,32(sp)
 8f0:	ec4e                	sd	s3,24(sp)
 8f2:	e852                	sd	s4,16(sp)
 8f4:	e456                	sd	s5,8(sp)
 8f6:	e05a                	sd	s6,0(sp)
 8f8:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8fa:	02051493          	slli	s1,a0,0x20
 8fe:	9081                	srli	s1,s1,0x20
 900:	04bd                	addi	s1,s1,15
 902:	8091                	srli	s1,s1,0x4
 904:	0014899b          	addiw	s3,s1,1
 908:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 90a:	00000517          	auipc	a0,0x0
 90e:	14653503          	ld	a0,326(a0) # a50 <freep>
 912:	c515                	beqz	a0,93e <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 914:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 916:	4798                	lw	a4,8(a5)
 918:	02977f63          	bgeu	a4,s1,956 <malloc+0x70>
 91c:	8a4e                	mv	s4,s3
 91e:	0009871b          	sext.w	a4,s3
 922:	6685                	lui	a3,0x1
 924:	00d77363          	bgeu	a4,a3,92a <malloc+0x44>
 928:	6a05                	lui	s4,0x1
 92a:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 92e:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 932:	00000917          	auipc	s2,0x0
 936:	11e90913          	addi	s2,s2,286 # a50 <freep>
  if(p == (char*)-1)
 93a:	5afd                	li	s5,-1
 93c:	a88d                	j	9ae <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
 93e:	00000797          	auipc	a5,0x0
 942:	11a78793          	addi	a5,a5,282 # a58 <base>
 946:	00000717          	auipc	a4,0x0
 94a:	10f73523          	sd	a5,266(a4) # a50 <freep>
 94e:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 950:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 954:	b7e1                	j	91c <malloc+0x36>
      if(p->s.size == nunits)
 956:	02e48b63          	beq	s1,a4,98c <malloc+0xa6>
        p->s.size -= nunits;
 95a:	4137073b          	subw	a4,a4,s3
 95e:	c798                	sw	a4,8(a5)
        p += p->s.size;
 960:	1702                	slli	a4,a4,0x20
 962:	9301                	srli	a4,a4,0x20
 964:	0712                	slli	a4,a4,0x4
 966:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 968:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 96c:	00000717          	auipc	a4,0x0
 970:	0ea73223          	sd	a0,228(a4) # a50 <freep>
      return (void*)(p + 1);
 974:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 978:	70e2                	ld	ra,56(sp)
 97a:	7442                	ld	s0,48(sp)
 97c:	74a2                	ld	s1,40(sp)
 97e:	7902                	ld	s2,32(sp)
 980:	69e2                	ld	s3,24(sp)
 982:	6a42                	ld	s4,16(sp)
 984:	6aa2                	ld	s5,8(sp)
 986:	6b02                	ld	s6,0(sp)
 988:	6121                	addi	sp,sp,64
 98a:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 98c:	6398                	ld	a4,0(a5)
 98e:	e118                	sd	a4,0(a0)
 990:	bff1                	j	96c <malloc+0x86>
  hp->s.size = nu;
 992:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 996:	0541                	addi	a0,a0,16
 998:	00000097          	auipc	ra,0x0
 99c:	ec6080e7          	jalr	-314(ra) # 85e <free>
  return freep;
 9a0:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 9a4:	d971                	beqz	a0,978 <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9a6:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9a8:	4798                	lw	a4,8(a5)
 9aa:	fa9776e3          	bgeu	a4,s1,956 <malloc+0x70>
    if(p == freep)
 9ae:	00093703          	ld	a4,0(s2)
 9b2:	853e                	mv	a0,a5
 9b4:	fef719e3          	bne	a4,a5,9a6 <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
 9b8:	8552                	mv	a0,s4
 9ba:	00000097          	auipc	ra,0x0
 9be:	b7e080e7          	jalr	-1154(ra) # 538 <sbrk>
  if(p == (char*)-1)
 9c2:	fd5518e3          	bne	a0,s5,992 <malloc+0xac>
        return 0;
 9c6:	4501                	li	a0,0
 9c8:	bf45                	j	978 <malloc+0x92>
