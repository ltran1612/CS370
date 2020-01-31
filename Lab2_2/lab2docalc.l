%{
/*                 Small LEX routine which returns two formal tokens (INTEGER and VARIABLE)
                   along with single string elements like '+'.
 
                    This LEX definition is the companion to the docalc.y YACC routine which
                   is a simple calculator

                    Shaun Cooper
                    January 2015
*/

/*
	modifled lab2docal.l


	Long Tran
	, 2020

*/

int mydebug=1;
#include "y.tab.h"

%}


%%

[a-z]		{if (mydebug) fprintf(stderr,"Letter found\n"); 
                       yylval=*yytext-'a'; return(VARIABLE);}
[0-9][0-9]*	{if (mydebug) fprintf(stderr,"Digit found\n"); 
                       yylval=atoi((const char *)yytext); return(INTEGER);}
[ \t]		{if (mydebug) fprintf(stderr,"Whitespace found\n");}
[=\-+*/%&|] 	{ if (mydebug) fprintf(stderr,"return a token %c\n",*yytext); 
                       return (*yytext);}
\n 		{ if (mydebug) fprintf(stderr,"cariage return %c\n",*yytext); 
                       return (*yytext);}
[()] { if (mydebug) fprintf(stderr, "return %c\n", *yytext); return (*yytext);/*Whenever it encounters the parantheses, give it to yacc*/ /*Add a directive to give the paranthese token to yacc*/}

%% 

// end of rule, starts of program
int yywrap(void)
{ return 1;}


