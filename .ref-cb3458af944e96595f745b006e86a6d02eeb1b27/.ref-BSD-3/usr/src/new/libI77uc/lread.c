/*
 * list directed read
 */

#include "fio.h"
#include "lio.h"

#define isblnk(x)	(ltab[x+1]&B)
#define issep(x)	(ltab[x+1]&SP)
#define isapos(x)	(ltab[x+1]&AP)
#define isexp(x)	(ltab[x+1]&EX)
#define isdigit(x)	(ltab[x+1]&D)
#define SP 1
#define B  2
#define AP 4
#define EX 8
#define D 16
#define GETC(x) (x=(*getn)())

char *lrd = "list read";
char *lchar;
double lx,ly;
int ltype;
int l_read(),t_getc(),ungetc();

char ltab[128+1] =
{		0, /* offset one for EOF */
/*   0- 15 */	0,0,AP,0,0,0,0,0,0,B,0,0,0,0,0,0,	/* ^B,TAB */
/*  16- 31 */	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
/*  32- 47 */	SP|B,0,AP,0,0,0,0,AP,0,0,0,0,SP,0,0,SP,	/* space,",',comma,/ */
/*  48- 63 */	D,D,D,D,D,D,D,D,D,D,0,0,0,0,0,0,	/* digits 0-9 */
/*  64- 79 */	0,0,0,0,EX,EX,0,0,0,0,0,0,0,0,0,0,	/* D,E */
/*  80- 95 */	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
/*  96-111 */	0,0,0,0,EX,EX,0,0,0,0,0,0,0,0,0,0,	/* d,e */
/* 112-127 */	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
};

s_rsle(a) cilist *a;	/* start read sequential list external */
{
	int n;
	reading = YES;
	if(n=c_le(a,READ)) return(n);
	l_first = YES;
	lquit = NO;
	lioproc = l_read;
	getn = t_getc;
	ungetn = ungetc;
	leof = curunit->uend;
	lcount = 0;
	if(curunit->uwrt) nowreading(curunit);
	return(OK);
}

t_getc()
{	int ch;
	if(curunit->uend) return(EOF);
	if((ch=getc(cf))!=EOF) return(ch);
	if(feof(cf))
	{	curunit->uend = YES;
		leof = EOF;
	}
	else clearerr(cf);
	return(EOF);
}

e_rsle()
{
	int ch;
	if(curunit->uend) return(OK);
	while((GETC(ch))!='\n' && ch!=EOF);
	return(OK);
}

l_read(number,ptr,len,type) ftnint *number,type; flex *ptr; ftnlen len;
{	int i,n,ch;
	double *yy;
	float *xx;
	for(i=0;i<*number;i++)
	{
		if(leof) err(endflag, EOF, lrd)
		if(l_first)
		{	l_first = NO;
			for(GETC(ch);isblnk(ch);GETC(ch));  /* skip blanks */
			(*ungetn)(ch,cf);
		}
		else if(lcount==0)		/* repeat count == 0 ? */
		{	ERR(t_sep());  /* look for non-blank, allow 1 comma */
			if(lquit) return(OK);	/* slash found */
		}
		switch((int)type)
		{
		case TYSHORT:
		case TYLONG:
		case TYREAL:
		case TYDREAL:
			ERR(l_R(1));
			break;
		case TYCOMPLEX:
		case TYDCOMPLEX:
			ERR(l_C());
			break;
		case TYLOGICAL:
			ERR(l_L());
			break;
		case TYCHAR:
			ERR(l_CHAR());
			break;
		}
		if(lquit) return(OK);
		if(leof) err(endflag,EOF,lrd)
		else if(external && ferror(cf)) err(errflag,errno,lrd)
		if(ltype) switch((int)type)
		{
		case TYSHORT:
			ptr->flshort=lx;
			break;
		case TYLOGICAL:
		case TYLONG:
			ptr->flint=lx;
			break;
		case TYREAL:
			ptr->flreal=lx;
			break;
		case TYDREAL:
			ptr->fldouble=lx;
			break;
		case TYCOMPLEX:
			xx=(float *)ptr;
			*xx++ = ly;
			*xx = lx;
			break;
		case TYDCOMPLEX:
			yy=(double *)ptr;
			*yy++ = ly;
			*yy = lx;
			break;
		case TYCHAR:
			b_char(lchar,(char *)ptr,len);
			break;
		}
		if(lcount>0) lcount--;
		ptr = (char *)ptr + len;
	}
	return(OK);
}

lr_comm()
{	int ch;
	if(lcount) return(lcount);
	ltype=NULL;
	while(isblnk(GETC(ch)));
	if(ch==',')
	{	lcount=1;
		return(lcount);
	}
	else if(ch=='/')
	{	lquit = YES;
		return(lquit);
	}
	else
	{	(*ungetn)(ch,cf);
		return(OK);
	}
}

get_repet()
{	char ch;
	double lc;
	if(isdigit(GETC(ch)))
	{	(*ungetn)(ch,cf);
		rd_int(&lc);
		lcount = (int)lc;
		if(GETC(ch)!='*')
			if(leof) return(EOF);
			else return(109);
	}
	else
	{	lcount = 1;
		(*ungetn)(ch,cf);
	}
	return(OK);
}

l_R(flg) int flg;
{	double a,b,c,d;
	int i,ch,sign=0,da,db,dc;
	a=b=c=d=0;
	da=db=dc=0;
	if(flg && lr_comm()) return(OK);
	da=rd_int(&a);
	if(da== -1) sign=da;
	if(GETC(ch)!='*')
	{	(*ungetn)(ch,cf);
		db=1;
		b=a;
		a=1;
	}
	else
		db=rd_int(&b);
	if(GETC(ch)!='.')
	{	dc=c=0;
		(*ungetn)(ch,cf);
	}
	else	dc=rd_int(&c);
	if(isexp(GETC(ch))) db=rd_int(&d);
	else
	{	(*ungetn)(ch,cf);
		d=0;
	}
	lcount=a;
	if(!db && !dc)
		return(OK);
	if(db && b<0)
	{	sign=1;
		b = -b;
	}
	for(i=0;i<dc;i++) c/=10;
	b=b+c;
	for(i=0;i<d;i++) b *= 10;
	for(i=0;i< -d;i++) b /= 10;
	if(sign) b = -b;
	ltype=TYLONG;
	lx=b;
	return(OK);
}

rd_int(x) double *x;
{	int ch,sign=0,i=0;
	double y=0.0;
	if(GETC(ch)=='-') sign = -1;
	else if(ch=='+') sign=0;
	else (*ungetn)(ch,cf);
	while(isdigit(GETC(ch)))
	{	i++;
		y=10*y + ch-'0';
	}
	(*ungetn)(ch,cf);
	if(sign) y = -y;
	*x = y;
	return(y!=0?i:sign);
}

l_C()
{	int ch,n;
	if(lr_comm()) return(OK);
	if(n=get_repet()) return(n);		/* get repeat count */
	if(GETC(ch)!='(') err(errflag,112,"no (")
	while(isblnk(GETC(ch)));
	(*ungetn)(ch,cf);
	l_R(0);		/* get real part */
	ly = lx;
	if(t_sep()) return(EOF);
	l_R(0);		/* get imag part */
	while(isblnk(GETC(ch)));
	if(ch!=')') err(errflag,112,"no )")
	ltype = TYCOMPLEX;
	return(OK);
}

l_L()
{
	int ch,n;
	if(lr_comm()) return(OK);
	if(n=get_repet()) return(n);		/* get repeat count */
	if(GETC(ch)=='.') GETC(ch);
	switch(ch)
	{
	case 't':
	case 'T':
		lx=1;
		break;
	case 'f':
	case 'F':
		lx=0;
		break;
	default:
		if(isblnk(ch) || issep(ch))
		{	(*ungetn)(ch,cf);
			lx=0;
			return(OK);
		}
		else if(ch==EOF) return(EOF);
		else	err(errflag,112,"logical not T or F");
	}
	ltype=TYLOGICAL;
	while(!issep(GETC(ch)) && !isblnk(ch) && ch!='\n' && ch!=EOF);
	return(OK);
}

#define BUFSIZE	128
l_CHAR()
{	int ch,size,i,n;
	char quote,*p;
	if(lr_comm()) return(OK);
	if(n=get_repet()) return(n);		/* get repeat count */
	if(isapos(GETC(ch))) quote=ch;
	else if(isblnk(ch) || issep(ch) || ch==EOF || ch=='\n')
	{	if(ch==EOF) return(EOF);
		(*ungetn)(ch,cf);
		return(OK);
	}
	else
	{	quote = '\0';	/* to allow single word non-quoted */
		(*ungetn)(ch,cf);
	}
	ltype=TYCHAR;
	if(lchar!=NULL) free(lchar);
	size=BUFSIZE-1;
	p=lchar=(char *)malloc(BUFSIZE);
	if(lchar==NULL) err(errflag,113,lrd)
	for(i=0;;)
	{	while( ( (quote && GETC(ch)!=quote) ||
			(!quote && !issep(GETC(ch)) && !isblnk(ch) ) )
			&& ch!='\n' && ch!=EOF && ++i<size )
				*p++ = ch;
		if(i==size)
		{
		newone:
			size += BUFSIZE;
			lchar=(char *)realloc(lchar, size+1);
			if(lchar==NULL) err(errflag,113,lrd)
			p=lchar+i-1;
			*p++ = ch;
		}
		else if(ch==EOF) return(EOF);
		else if(ch=='\n')
		{	if(*(p-1) == '\\') *(p-1) = ch;
			else if(!quote)
			{	*p = '\0';
				(*ungetn)(ch,cf);
				return(OK);
			}
		}
		else if(quote && GETC(ch)==quote)
		{	if(++i<size) *p++ = ch;
			else goto newone;
		}
		else
		{	(*ungetn)(ch,cf);
			*p = '\0';
			return(OK);
		}
	}
}

t_sep()
{
	int ch;
	while(isblnk(GETC(ch)));
	if(leof) return(EOF);
	if(ch=='/')
	{	lquit = YES;
		return(OK);
	}
	if(ch==',') while(isblnk(GETC(ch)));
	if(leof) return(EOF);
	(*ungetn)(ch,cf);
	return(OK);
}
