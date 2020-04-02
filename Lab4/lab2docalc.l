%{
/*                 Small LEX routine which returns two formal tokens (INTEGER and VARIABLE)
                   along with single string elements like '+'.
 
                    This LEX definition is the companion to the docalc.y YACC routine which
                   is a simple calculator

                    Shaun Cooper
                    January 2015
*/

/*
	modified lab2docal.l
	Purpose: scan the input string for tokens(operators, variables, and Integer, newline), and return it to yacc when found.
	Variable name can now include letters and numbers and it can be as long as we want. 
	The program will now also return ';' token and "INT" token

	Long Tran
	February 25, 2020

	Input: strings from yacc
	Output: the token and its value if needed to yacc (variables, integer, newline, operators, and tokens) 
*/

// variable to determine if we are going to print the debug statement
int mydebug=0;
#include "y.tab.h"

%}

%%
int       {return INT; fprintf(stderr,"INT token found\n");}

[a-zA-Z][a-zA-Z0-9]*    {
                            if (mydebug) fprintf(stderr,"Variable found\n"); 
                            yylval.string = strdup(yytext); return(VARIABLE); /*return a VARIABLE token*/
                        }
                        
[0-9][0-9]*	{   
                if (mydebug) fprintf(stderr,"Digit found\n"); // if a digit has been found 
                yylval.number = atoi((const char *)yytext)/*give lex the digit value*/; 
                return(INTEGER);/*return an INTEGER token*/
            }
            
[ \t]		{ if (mydebug) fprintf(stderr,"Whitespace found\n");/*find white space, do nothing*/}

[=\-+*/%&|;()] 	{ if (mydebug) fprintf(stderr,"return a token %c\n",*yytext); 
                       return (*yytext);/*return tokens in the regular expression*/}
                       
\n 		{ if (mydebug) fprintf(stderr,"cariage return %c\n",*yytext); 
                       return (*yytext);/*return a new line*/}
%% 

// end of rule, starts of program
int yywrap(void)
{ return 1;}

