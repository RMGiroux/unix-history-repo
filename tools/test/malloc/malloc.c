#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

u_long NBUCKETS		= 2000;
u_long NOPS		= 200000;
u_long NSIZE		= (16*1024);

char **foo;

int
main(int argc, char **argv) 
{
    int i,j,k;
    
    if (argc > 1) NOPS     = strtoul(argv[1],0,0);
    if (argc > 2) NBUCKETS = strtoul(argv[2],0,0);
    if (argc > 3) NSIZE	   = strtoul(argv[3],0,0);
    printf("BRK(0)=%x ",sbrk(0));
    foo = malloc (sizeof *foo * NBUCKETS);
    memset(foo,0,sizeof *foo * NBUCKETS);
    for (i = 0 ; i < NOPS ; i++) {
	j = rand() % NBUCKETS;
	if (foo[j]) {
	    free(foo[j]);
	    foo[j] = 0;
	} else {
	    k = rand() % NSIZE;
	    foo[j] = malloc(k);
	    foo[j][0] = 1;
	}
    }
    printf("BRK(1)=%x ",sbrk(0));
    for (j = 0 ; j < NBUCKETS ; j++) {
	if (foo[j]) {
	    free(foo[j]);
	    foo[j] = 0;
	}
    }
    printf("BRK(2)=%x NOPS=%lu NBUCKETS=%lu NSIZE=%lu\n",
	sbrk(0),NOPS,NBUCKETS,NSIZE);
    return 0;
}
