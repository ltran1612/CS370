/*
    File Name: lab6.y
    Description: This yacc routine will parse the input and checks if the program matches the syntax of the ALGOL_C. It will print out any possible syntax error with the line on which the error is.
    Author: Long Tran
    Date: March 3rd, 2020
    Input: strings
    Output: If the program is syntactically correct, it will print "The program is syntactically correct"
*/

%{
#include <stdio.h>
#include <string.h>
#include "AST.h"

// linecount is  by lex
extern int linecount;

// called yyparase on syntax error
void yyerror(char const * s) {
    fprintf(stderr, "%s on line %d\n", s, linecount);
} // end yyerror

// prototype to avoid having to include yy.lex.c
int yylex();

// set 1 to print debug statement, 0 for no debug statement
int yacc_debug = 1;

// the node to the abstract syntax tree of the entire program.
ASTNode * gp;

%}
%start program
// union
%union {
    int value;
    char * string;
    struct ASTNode * node;
    enum OPERATORS oprt;
} // end union

// tokens
%token <value> NUM
%token <string> ID

%token INT VOID BOOLEAN

%token MYBEGIN END

%token IF THEN ELSE

%token WHILE DO

%token RETURN

%token READ WRITE

%token LE GE EQ NE

%token AND OR NOT

%token TRUE FALSE

// declaration
%type <node> var_declaration var_list fun_declaration  declaration_list declaration local_declaration 

// params
%type <node> params param_list param 
// statements
%type <node> statement_list statement compound_stmt iteration_stmt selection_stmt return_stmt read_stmt write_stmt expression_stmt assignment_stmt
// expression
%type <node> simple_expression expression additive_expression
// arguments
%type <node> args arg_list
// other
%type <node> term factor call var

// type_specifier
%type <oprt> type_specifier;

// comparison
%type <oprt> relop;

// math operations
%type <oprt> addop;
%type <oprt> multop;


%%
program : declaration_list /*program → declaration-list*/
            {
                // pass the pointer to the global pointer
                gp = $1;
            }
        ;
        
declaration_list: declaration  /*declaration-list → declaration { declaration }*/
                    {   
                        // pass the pointer
                        $$ = $1;
                    }
                | declaration declaration_list 
                    {
                        $1->next = $2;
                        $$ = $1;
                    }
                ;
                
declaration : var_declaration /*declaration → var-declaration | fun-declaration*/
                {   
                    // pass the pointer
                    $$ = $1;
                }
            | fun_declaration 
                {   
                    // pass the pointer
                    $$ = $1;
                }
            ;

var_declaration : type_specifier var_list ';' /*var-declaration → type-specifier var-list ;*/
                    {
                        // change the type
                        ASTNode * p;
                        for (p = $2; p != NULL; p = p->s1) {
                            p->operator = $1;
                        } // end for p
                        
                        // pass up the pointer
                        $$ = $2;
                    } // end type_specifier var_list
                ;

var_list    :   ID /*var-list → ID | ID [ NUM ] | ID , var-list | ID [ NUM ] , var-list*/
                {
                    $$ = ASTCreateNode(VARDEC);
                    $$->name = $1;
                    $$->value = 1;
                } // end ID
                
            |   ID '[' NUM ']' 
                {
                    $$ = ASTCreateNode(VARDEC);
                    $$->name = $1;
                    $$->value = $3;
                } // end ID [NUM]
                
            |   ID  ',' var_list 
                {
                   $$ = ASTCreateNode(VARDEC);
                   $$->name = $1;
                   $$->value = 1;
                   $$->s1 = $3;
                } // end ID , var_list
                
            |   ID '[' NUM ']' ',' var_list 
                {
                   $$ = ASTCreateNode(VARDEC);
                   $$->name = $1;
                   $$->value = $3;
                   $$->s1 = $6;
                } // end ID [NUM] , var_list
            ;

type_specifier  : INT /*type-specifier → int | void | boolean*/
                    {
                        $$ = INTTYPE;
                    }
                | VOID 
                    {
                        $$ = VOIDTYPE;
                    }
                | BOOLEAN 
                    {
                        $$ = BOOLTYPE;
                    }
                ;

fun_declaration : type_specifier ID '(' params ')' compound_stmt /*fun-declaration →type-specifier ID ( params ) compound-stmt*/
                    {
                        $$ = ASTCreateNode(FUNDEC);
                        $$->name = $2;
                        $$->operator = $1;
                        $$->s1 = $4;
                        $$->s2 = $6;
                    }  // end type_specifier
                ;

params  : VOID /*params → void | param-list*/
            {
                $$ = NULL;
            }
        | param_list 
            {
                $$ = $1;
            }
            
        ;
        
param_list  : param /*param-list → param { , param }*/
                {
                    $$ = $1;
                }
            | param ',' param_list 
                {
                    $$ = $1;
                    $$->next = $3;
                }
            ;
            
param   : type_specifier ID /*param → type-specifier ID [ [] ]*/
            {
                // Create new node for a non-array parameter
                $$ = ASTCreateNode(PARAM);
                $$->name = $2;
                $$->value = 1;
                $$->operator = $1;
            } // end type_specifier ID
            
        | type_specifier ID '[' ']' 
            {
                // Create new node for an array parameter
                $$ = ASTCreateNode(PARAM);
                $$->name = $2;
                $$->value = 2;
                $$->operator = $1;
            } // end type_specifier ID []
        ;
        
statement_list  : /*empty*/ /*statement-list → { statement }*/
                    {   
                        // empty statement list NULL
                        $$ = NULL;
                    }
                | statement statement_list 
                    {
                        // connect statement with other statement in statement list
                        $$ = $1;
                        if ($$ != NULL)
                            $$->next = $2;
                    } // end statement statement_list
                ;
                
statement   : expression_stmt /*statement → expression-stmt | compound-stmt | selection-stmt |iteration-stmt | assignment-stmt | return-stmt | read-stmt | write-stmt*/
                {
                    $$ = $1;
                }
            | compound_stmt 
                {
                    $$ = $1;
                }
            | selection_stmt    
                {
                    $$ = $1;
                }
            | iteration_stmt    
                {
                    $$ = $1;
                }
            | assignment_stmt 
                {
                    $$ = $1;
                }
            | return_stmt   
                {
                    $$ = $1;
                }
            | read_stmt 
                {
                    $$ = $1;
                }
            | write_stmt    
                {
                    $$ = $1;
                }
            ;
                
compound_stmt   : MYBEGIN local_declaration statement_list END /*compound-stmt → begin local-declarations statement-list end*/
                    {
                        // create new node for compound statement
                        $$ = ASTCreateNode(COMPSTMT);
                        $$->s1 = $2;
                        $$->s2 = $3;
                    }
                ;
                
local_declaration   : /*empty*/ /*local-declarations → { var-declarations }*/
                        {
                            $$ = NULL;
                        }
                    | var_declaration local_declaration
                        {
                            $$ =  $1;
                            if ($$ != NULL)
                                $$->next = $2;
                        }
                    ;

expression_stmt : expression ';' /*expression-stmt → expression ; | ;*/
                        {
                            $$ = ASTCreateNode(EXPRSTMT);
                            $$->s1 = $1;
                        }
                | ';'
                        {
                            // no expression
                            $$ = ASTCreateNode(EXPRSTMT);
                        }
                ;

selection_stmt  : IF expression THEN statement /*selection-stmt → if expression then statement [ else statement ] +*/
                    {
                        $$ = ASTCreateNode(IFSTMT);
                        $$->s1 = $2;
                        $$->s2 = ASTCreateNode(IFSTMT1);
                        $$->s2->s1 = $4;
                    }
                | IF expression THEN statement ELSE statement
                    {
                        $$ = ASTCreateNode(IFSTMT);
                        $$->s1 = $2;
                        $$->s2 = ASTCreateNode(IFSTMT1);
                        $$->s2->s1 = $4;
                        $$->s2->s2 = $6;
                    }
                ;

iteration_stmt  : WHILE expression DO statement /*iteration-stmt → while expression do statement*/
                    {
                        $$ = ASTCreateNode(ITERSTMT);
                        $$->s1 = $2;
                        $$->s2 = $4;
                    }
                ;

return_stmt : RETURN ';' /*return-stmt → return [ expression ] + ;*/
                    {
                        $$ = ASTCreateNode(RETURNSTMT);
                    }
            | RETURN expression ';'
                    {
                        $$ = ASTCreateNode(RETURNSTMT);
                        $$->s1 = $2;
                    }
            ;

read_stmt   : READ var ';' /*read-stmt → read variable ;*/
                    {
                        $$ = ASTCreateNode(READSTMT);
                        $$->s1 = $2;
                    }
            ;

write_stmt  : WRITE expression ';' /*write-stmt → write expression;*/
                    {
                        $$ = ASTCreateNode(WRITESTMT);
                        $$->s1 = $2;
                    }
            ;

assignment_stmt : var '=' simple_expression ';' /*assignment-stmt → var = simple-expression ;*/
                    {
                        $$ = ASTCreateNode(ASSIGNSTMT);
                        $$->s1 = $1;
                        $$->s2 = $3;
                    }
                ;
                
expression  : simple_expression /*expression → simple-expression*/
                    {
                        // pass up the pointer
                        $$ = $1;
                    }
            ;
            
var : ID  /*var → ID [ [ expression ] ] +*/
        {
            // a single identifier
            $$ = ASTCreateNode(IDENT);
            $$->name = $1;
            $$->value = 1;
        } // end  ID
        
    | ID '['expression']' 
        {
            // an array
            $$ = ASTCreateNode(IDENT);
            $$->name = $1;
            
            // fake number to help identify that this is accessed as an array
            $$->value = 2;
            $$->s1 = $3;
        } // end ID []
    ;

simple_expression   : additive_expression /*simple-expression → additive-expression [ relop additive-expression ] + (left-associative)*/
                        {
                            // pass up the pointer
                            $$ = $1;
                        }
                    | simple_expression relop additive_expression
                        {
                            // create new node
                            $$ = ASTCreateNode(EXPR);
                            
                            // simple_expression
                            $$->s1 = $1;
                            
                            // operator
                            $$->operator = $2;
                            
                            // additive_expression
                            $$->s2 = $3;
                        }
                    ;
                    
relop   : '<' /*relop → <= | < | > | >= | == | !=*/
            {
                // less than
                $$ = LESS;
            }
        | '>'
            {
                // greater than
                $$ = GREAT;
            }
        | LE
            {
                // less equal than
                $$ = LESSE;
            }
        | GE
            {
                // greater equal than
                $$ = GREATE;
            }
        | EQ
            {
                // equal
                $$ = EQUAL;
            }
        | NE
            {
                // not equal
                $$ = NEQUAL;
            }
        ;

additive_expression : term /*additive-expression → term { addop term } (left-associative)*/
                        {
                            $$ = $1;
                        }
                    | additive_expression addop term
                        {
                            // create new node
                            $$ = ASTCreateNode(EXPR);
                            
                            // additive expression
                            $$->s1 = $1;
                            
                            // opeartor
                            $$->operator = $2;
                            
                            // term
                            $$->s2 = $3;
                        }
                    ;

addop   : '+' /*addop → + | -*/
            {
                $$ = PLUS;
            }
        | '-'
            {
                $$ = MINUS;
            }
        ;

term    : factor /*term → factor { multop factor } (left-associative)*/
            {
                $$ = $1;
            }
        | term multop factor   
            {
                // new node
                $$ = ASTCreateNode(EXPR);
                
                // term
                $$->s1 = $1;
                
                // operator
                $$->operator = $2;
                
                // factor
                $$->s2 = $3;
            }
        ;

multop  : '*' /*multop → * | / | and | or*/
            {
                // multiplication
                $$ = TIMES;
            }
        | '/'
            {
                // division
                $$ = DIV;
            }
        | AND
            {
                // and bitwise
                $$ = ANDBW;
            }
        | OR
            {
                // or bitwise
                $$ = ORBW;
            }
        ;

factor  : '(' expression ')' /*factor → ( expression ) | NUM | var | call | true | false | not factor*/
            {
                // pass up the expression
                $$ = $2;
            }
        | NUM
            {
                // create new node for number
               $$ = ASTCreateNode(NUMBER);
               
               // set it value
               $$->value = $1;
               
            } // end NUM
            
        | var
            {
                // pass up the value
                $$ = $1;
            }
        | call
            {
                // pass up the value
                $$ = $1;
            }
        | TRUE
            {
                $$ = ASTCreateNode(NUMBER);
                $$->value = 1;
            }
        | FALSE
            {
                $$ = ASTCreateNode(NUMBER);
                $$->value = 0;
            }
        | NOT factor
            {
                $$ = ASTCreateNode(EXPR);
                $$->operator = NOTOP;
                $$->s1 = $2;
            }
        ;

call    : ID '(' args ')' /*call → ID ( args )*/
            {
               $$ = ASTCreateNode(FUNCALL);
               $$->name = $1;
               $$->s1 = $3;
            }
        ;

args    : /*empty*/ /*args → arg-list | empty*/
            {
                // no arguments
                $$ = NULL;
            }
        | arg_list
            {
                // argument list
                $$ = $1;
            }
        ;
        
arg_list    : expression /*arg-list → expression { , expression }*/
                {
                    // pass up the value
                    $$ = $1;
                }
            | expression ',' arg_list
                {
                    // argument list
                    $$ = $1;
                    $$->next = $3;
                }
            ;

                
%%

int main() {
    if (!yyparse())
        fprintf(stderr, "The program is syntactically correct\n");
        
    // print out the syntas tree
    ASTprint(gp, 0);

} // end main
