/*
    File Name: lab7.l
    Description: This lex routine will analyze the input given from yacc and return the appropriate tokens: INT, VOID, BOOLEAN, MYBEGIN, END, IF, THEN, ELSE, WHILE, DO, RETURN, READ, WRITE, LE, GE, EQ, NE, AND, OR, NOT, TRUE, FALSE, NUM, ID, '-', '+', '*', '/', '=', '(', ')', ',', ';', '<', '>', '[', ']'. 
    For NUM and ID, it will return with companion value.
    Author: Long Tran
    Date: March 28th, 2020
    Input: from yacc file
    Output: a token
    Changes:
    + added some comments 
*/


%{

// because lex does not know about OPERATORS and ASTNode, which is used in the union
// in yylval
#include "AST.h"

// header files created from .y file by yacc using -d flag
// include y.tab.h to access to the tokens from yacc
#include "y.tab.h"

// keep track of the line number
int linecount = 1;

// set 1 to print debug statement, 0 not to print
int debug = 0;
%}

digit [0-9]
letter [a-zA-Z]
NUM {digit}{digit}*
ID {letter}({letter}|{digit})*

%%
int     {
            if (debug) fprintf(stderr, "Found INT\n"); 
            return INT;
        } // of int
        
boolean {
            if (debug) fprintf(stderr, "Found BOOLEAN\n");
            return BOOLEAN;
        } // of boolean
        
void    {
            if (debug) fprintf(stderr, "Found VOID\n"); 
            return VOID;
        } // of void

begin   {
            if (debug) fprintf(stderr, "Found MYBEGIN\n"); 
            return MYBEGIN;
        } // of begin
        
end     {
            if (debug) fprintf(stderr, "Found END\n"); 
            return END;
        } // of end

if      {
            if (debug) fprintf(stderr, "Found IF\n"); 
            return IF;
        } // of if
        
then    {
            if (debug) fprintf(stderr, "Found THEN\n");
            return THEN;
        } // of then
        
else    {
            if (debug) fprintf(stderr, "Found ELSE\n");
            return ELSE;
        } // of else

while   {
            if (debug) fprintf(stderr, "Found WHILE\n");
            return WHILE;
        } // of while
        
do      {
            if (debug) fprintf(stderr, "Found DO\n");
            return DO;
        } // of do

return  {
            if (debug) fprintf(stderr, "Found RETURN\n");
            return RETURN;
        } // of return

read    {
            if (debug) fprintf(stderr, "Found READ\n");
            return READ;
        } // of read
        
write   {
            if (debug) fprintf(stderr, "Found WRITE\n");
            return WRITE;
        } // of write

"<="    {
            if (debug) fprintf(stderr, "Found <=\n");
            return LE;
        } // of <=
        
">="    {
            if (debug) fprintf(stderr, "Found >=\n");
            return GE;
        } // of >=
        
"=="    {   
            if (debug) fprintf(stderr, "Found ==\n");
            return EQ;
        } // of ==
        
"!="    {
            if (debug) fprintf(stderr, "Found !=\n");
            return NE;
        } // of !=

[-+*/=(),;<>\[\]] {
            if (debug) fprintf(stderr, "Found a token %c\n", *yytext);
            return *yytext;
        } // end of single character token

and     {
            if (debug) fprintf(stderr, "Found AND\n");
            return AND;
        } // end and
        
or      {
            if (debug) fprintf(stderr, "Found OR\n");
            return OR;
        } // end or

not     {
            if (debug) fprintf(stderr, "Found NOT\n");
            return NOT;
        } // end not
        
true    {
            if (debug) fprintf(stderr, "Found TRUE\n");
            return TRUE;
        } // end true
        
false   {
            if (debug) fprintf(stderr, "Found FALSE\n");
            return FALSE;
        } // end false

{NUM}   {
            yylval.value = atoi((const char *)yytext); 
            if (debug) fprintf(stderr, "Found a number: %d\n", yylval.value); 
            return NUM; 
        } // end NUM

{ID}    {
            yylval.string = strdup(yytext); 
            if (debug) fprintf(stderr, "Found an identifier named: %s\n", yylval.string); 
            return ID;
        } // end ID
\"(.|[ \t])*\"   {
            yylval.string = strdup(yytext);
            return STRING;
        } // end STRING

\n  linecount++; // count the line for error reporting

[ \t] // eats any whitespaces 

.   {
        if (debug) fprintf(stderr, "Found a character: %c\n", *yytext); 
        
        // return a non-token character, meaning syntax error
        return *yytext;
    } // end .
%%

int yywrap() {
    return 1;
} // end yywrap

// int main() {
//     yylex();
// }
