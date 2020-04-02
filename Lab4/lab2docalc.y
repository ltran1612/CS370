%{

/*
 *			**** CALC ****
 *
 * This routine will function like a desk calculator
 * There are 26 integer registers, named 'a' thru 'z'
 *
 */

/* This calculator depends on a LEX description which outputs either VARIABLE or INTEGER.
   The return type via yylval is integer 

   When we need to make yylval more complicated, we need to define a pointer type for yylval 
   and to instruct YACC to use a new type so that we can pass back better values
 
   The registers are based on 0, so we substract 'a' from each single letter we get.

   based on context, we have YACC do the correct memmory look up or the storage depending
   on position

   Shaun Cooper
    January 2015

   problems  fix unary minus, fix parenthesis, add multiplication
   problems  make it so that verbose is on and off with an input argument instead of compiled in
*/

/*
		modified lab2docal.y
		Purpose: it parses through the tokens (Variable, Integer, operators, parenthesis and newline) given by lex from analyzing the strings input from the user to check if the input has the right syntax described in the rule section and do calculations appropriately if right.
		There will be MAX_VARS amount of available space in regs instead of 26
		Variable name can now be as long as we want, the name can now include letters and numbers.
		Variables have to be declared before it is used, and the declaration have to be done before the calculation.
		This is done by using a symbol table defined in symtable.h and symtable.c.

		Long Tran
		February 25, 2020

		Input: strings from the user
		Output: print out the right result of the operations input if it has the right syntax described.
*/

	/* begin specs */
int yylex(); // prototypes to get rid of gcc warning
#include <stdio.h>
#include <ctype.h>
#include "symtable.h"
#define MAX_VARS 4 // define the number of variables in regs

// arrays corresponding to MAX_VARS amount of variables
int regs[MAX_VARS];
int base, debugsw;

// denote an available location in regs to store another variable.
int offset = 0;

void yyerror (s)  /* Called by yyparse on error */
     char *s;
{
  fprintf (stderr, "Error: %s\n", s);
  exit(1);
} // end yyerror


%}
/*  defines the start symbol, what values come back from LEX and how the operators are associated  */

// start at program nonterminal
%start program

// declare a uninon
%union {
    int number;
    char * string;
} // end union

%token <number> INTEGER
%token <string> VARIABLE
%token INT // add token for INT

%type <number> expr 

// Association order
%left '|'
%left '&'
%left '+' '-'
%left '*' '/' '%'
%left UMINUS

%%	/* end specs, begin rules */

program : DECLS list
        ;

DECLS   : DEC DECLS
        | /*empty*/
        ;

DEC     : INT VARIABLE ';' '\n' 
                {
					// if there is no more space, BARF
					// else if the variable has been declared, BARF
					// else add it in the symbol table.
                    if (offset >= MAX_VARS)
                    {
                        yyerror("Cannot declare more variables");
					} // end if
                    else if (Search($2)) 
                    {
                        yyerror(strcat($2, " has already been declared"));
					} // end else if
                    else {
						Insert($2, offset);
                        offset++; // go to the next available location for a variable in regs after having declared a variable.
                        fprintf(stderr, "Variable declared\n\n");
                    } // end else
                }
        ;

list	:	/* empty */
	|	list stat '\n'
			{ }
	|	list error '\n'
			{ yyerrok; }
	;

stat	:	expr
			{ 
                fprintf(stderr,"the anwser is%d\n", $1); 
            } 
            
	|	VARIABLE '=' expr
			{ 
                // find the address
				// if the address is not -1, it is in the symtable, store the new value to that address 
				// else, the address is not found, meaning it is not the symtable, BARF
                int offset = FetchAddress($1);
                if (offset != -1)
                    regs[offset] = $3; 
                else  
                    yyerror(strcat($1, " has not been declared"));
			}
	;

expr	:	'(' expr ')'
			{ $$ = $2; /*parenthesis*/ }
	|	expr '-' expr
			{ $$ = $1 - $3; /*minus*/}
	|	expr '+' expr
			{ $$ = $1 + $3;/*plus*/ }
	|	expr '/' expr
			{ $$ = $1 / $3; /*division*/}
	| 	expr '*' expr
			{ $$ = $1 * $3; /*Add a rule for multiplication*/}
	|	expr '%' expr
			{ $$ = $1 % $3;/*modulo*/ }
	|	expr '&' expr
			{ $$ = $1 & $3;/*binary and*/ }
	|	expr '|' expr
			{ $$ = $1 | $3; /*binary or*/}
	|	'-' expr	%prec UMINUS
			{ $$ = -$2; /*remove the expr before '-'*/ }
	|	VARIABLE
			{
				// find the address of the variable
				// if the address is not -1, meaning an entry has been found, get the number value of that variable and assign it to the value of expr.
				// else, the address is not found, barf
                int offset = FetchAddress($1);
                if (offset != -1)
                {
                    $$ = regs[offset]; 
                    fprintf(stderr,"found a variable value =%d\n",$$); 
                } // end if
				else  // if the address of the variable with that name is not found
					yyerror(strcat($1, " has not been declared"));
            }
	|	INTEGER {$$=$1; fprintf(stderr,"found an integer\n");}
	;


%%	/* end of rules, start of program */

// explicitly define the return type for main function
int main()
{ yyparse();
} // end main
