/*
    File Name: lab6.y
    Description: This yacc routine will parse the input and checks if the program matches the syntax of the ALGOL_C. It will print out any possible syntax error with the line on which the error is.
    Author: Long Tran
    Date: March 28th, 2020
    Input: strings
    Output: If the program is syntactically correct, it will print "The program is syntactically correct"
    Changes: 
    + Add AST.h
    + Remove yacc_debug_statement
    + Add a global pointer to hold the root of the ast
    + Add semantic actions in the production rules to produce node for abstract syntax tree
    + Print out the tree after parsing. 
*/

%{
// stdio.h for fprintf
#include <stdio.h>

// include to access the nodes types
#include "AST.h"

// linecount is  by lex
extern int linecount;

// called yyparase on syntax error
void yyerror(char const * s) {
    fprintf(stderr, "%s on line %d\n", s, linecount);
} // end yyerror

// prototype to avoid having to include yy.lex.c
int yylex();

// the global pointer to the root of the abstract syntax tree of the entire program.
ASTNode * gp;

%}
%start program
// union
%union {
    // a number
    int value;

    // a pointer to a string
    char * string;

    // a pointer to a node
    struct ASTNode * node;

    // math operators, data type. 
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
                        // pass up the list of declarations
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
                        // set the type of variable declaration
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
                    // Vardec node for normal variable
                    $$ = ASTCreateNode(VARDEC);

                    // name of the variable
                    $$->name = $1;

                    // the size of the variable
                    $$->value = 1;
                } // end ID
                
            |   ID '[' NUM ']' 
                {
                    // Vardec node for array variable
                    $$ = ASTCreateNode(VARDEC);
                    
                    // name of the variable
                    $$->name = $1;

                    // the size of the variable
                    $$->value = $3;
                } // end ID [NUM]
                
            |   ID  ',' var_list 
                {
                    // Vardec node for normal variable
                   $$ = ASTCreateNode(VARDEC);

                   // name of the variable
                   $$->name = $1;

                   // the size of the variable 
                   $$->value = 1;

                   // connect to the next declaration
                   $$->s1 = $3;
                } // end ID , var_list
                
            |   ID '[' NUM ']' ',' var_list 
                {
                    // Vardec node for array variable
                   $$ = ASTCreateNode(VARDEC);
                   
                    // name of the variable
                   $$->name = $1;

                   // the size of the variable
                   $$->value = $3;

                   // connect to the next declaration
                   $$->s1 = $6;
                } // end ID [NUM] , var_list
            ;

type_specifier  : INT /*type-specifier → int | void | boolean*/
                    {
                        // integer type
                        $$ = INTTYPE;
                    }
                | VOID 
                    {
                        // void type
                        $$ = VOIDTYPE;
                    }
                | BOOLEAN 
                    {
                        // boolean type
                        $$ = BOOLTYPE;
                    }
                ;

fun_declaration : type_specifier ID '(' params ')' compound_stmt /*fun-declaration →type-specifier ID ( params ) compound-stmt*/
                    {
                        // create node for fun declaration
                        $$ = ASTCreateNode(FUNDEC);

                        // name
                        $$->name = $2;

                        // return type
                        $$->operator = $1;

                        // parameters
                        $$->s1 = $4;

                        // compound statement
                        $$->s2 = $6;
                    }  // end type_specifier
                ;

params  : VOID /*params → void | param-list*/
            {
                $$ = NULL;
            }
        | param_list 
            {
                // pass up the param_list
                $$ = $1;
            }
            
        ;
        
param_list  : param /*param-list → param { , param }*/
                {
                    // pass up the pointer
                    $$ = $1;
                }
            | param ',' param_list 
                {
                    // pass up the pointer
                    $$ = $1;

                    // connect the current node to the next node of param
                    $$->next = $3;
                }
            ;
            
param   : type_specifier ID /*param → type-specifier ID [ [] ]*/
            {
                // Create new node for a non-array parameter
                $$ = ASTCreateNode(PARAM);

                // name of the param
                $$->name = $2;

                // not an array, size is 1
                $$->value = 1;

                // type of the param
                $$->operator = $1;
            } // end type_specifier ID
            
        | type_specifier ID '[' ']' 
            {
                // Create new node for an array parameter
                $$ = ASTCreateNode(PARAM);

                // name of the param
                $$->name = $2;

                // an array, size is 2
                $$->value = 2;

                // type of the param
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
                        // pass up the pointer
                        $$ = $1;

                        // connect statement with other statement in statement list
                        // we need to check if null because statement could be made null for debug reasons.
                        if ($$ != NULL) 
                            $$->next = $2;
                    } // end statement statement_list
                ;
                
statement   : expression_stmt /*statement → expression-stmt | compound-stmt | selection-stmt |iteration-stmt | assignment-stmt | return-stmt | read-stmt | write-stmt*/
                {
                    // pass up the pointer
                    $$ = $1;
                }
            | compound_stmt 
                {
                    // pass up the pointer
                    $$ = $1;
                }
            | selection_stmt    
                {
                    // pass up the pointer
                    $$ = $1;
                }
            | iteration_stmt    
                {
                    // pass up the pointer
                    $$ = $1;
                }
            | assignment_stmt 
                {
                    // pass up the pointer
                    $$ = $1;
                }
            | return_stmt   
                {
                    // pass up the pointer
                    $$ = $1;
                }
            | read_stmt 
                {
                    // pass up the pointer
                    $$ = $1;
                }
            | write_stmt    
                {
                    // pass up the pointer
                    $$ = $1;
                }
            ;
                
compound_stmt   : MYBEGIN local_declaration statement_list END /*compound-stmt → begin local-declarations statement-list end*/
                    {
                        // create new node for compound statement
                        $$ = ASTCreateNode(COMPSTMT);

                        // local declarations
                        $$->s1 = $2;

                        // statements
                        $$->s2 = $3;
                    }
                ;
                
local_declaration   : /*empty*/ /*local-declarations → { var-declarations }*/
                        {
                            // null node if there are no variable declarations
                            $$ = NULL;
                        }
                    | var_declaration local_declaration
                        {
                            // pass up the pointer
                            $$ =  $1;

                            //if ($$ != NULL) is not needed because var_declaration is never null
                            
                            // connect this node to the other local declaration
                            $$->next = $2;
                        }
                    ;

expression_stmt : expression ';' /*expression-stmt → expression ; | ;*/
                        {
                            // Create a node for expression statement
                            $$ = ASTCreateNode(EXPRSTMT);

                            // the expression of statement
                            $$->s1 = $1;
                        }
                | ';'
                        {
                            // Create a node for expression statement
                            $$ = ASTCreateNode(EXPRSTMT);

                            // no expression, so s1 is null
                        }
                ;

selection_stmt  : IF expression THEN statement /*selection-stmt → if expression then statement [ else statement ] +*/
                    {
                        // Create a node for the expression of the if statement
                        $$ = ASTCreateNode(IFSTMT);

                        // the expression
                        $$->s1 = $2;
                        
                        // connects to the node containing the statement of then
                        $$->s2 = ASTCreateNode(IFSTMT1);

                        // connect that node to the statement of then
                        $$->s2->s1 = $4;
                    }
                | IF expression THEN statement ELSE statement
                    {
                        // Create a node for the expression of the if statement
                        $$ = ASTCreateNode(IFSTMT);

                        // the expression
                        $$->s1 = $2;

                        // connects to the node containing the statement of then and the statement of else
                        $$->s2 = ASTCreateNode(IFSTMT1);

                        // connects that node to the statement of then 
                        $$->s2->s1 = $4;

                        // and the statement of else
                        $$->s2->s2 = $6;
                    }
                ;

iteration_stmt  : WHILE expression DO statement /*iteration-stmt → while expression do statement*/
                    {
                        // Create a node for iteration statement
                        $$ = ASTCreateNode(ITERSTMT);

                        // expression
                        $$->s1 = $2;

                        // statement
                        $$->s2 = $4;
                    }
                ;

return_stmt : RETURN ';' /*return-stmt → return [ expression ] + ;*/
                    {
                        // Create a node for return statement
                        $$ = ASTCreateNode(RETURNSTMT);

                        // does not return any value, s1 is null
                    }
            | RETURN expression ';'
                    {
                        // Create a node for return statement
                        $$ = ASTCreateNode(RETURNSTMT);

                        // the return expression
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
                        // Create a node for write statement
                        $$ = ASTCreateNode(WRITESTMT);

                        // the expression
                        $$->s1 = $2;
                    }
            ;

assignment_stmt : var '=' simple_expression ';' /*assignment-stmt → var = simple-expression ;*/
                    {
                        // Create a node for the assignment statement
                        $$ = ASTCreateNode(ASSIGNSTMT);

                        // the variable
                        $$->s1 = $1;

                        // the expression
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

            // the name of the identifier
            $$->name = $1;

            // a single identifier, so the size is 1
            $$->value = 1;
        } // end  ID
        
    | ID '['expression']' 
        {
            // an array
            $$ = ASTCreateNode(IDENT);

            // the name of the identifier
            $$->name = $1;
            
            // fake number to help identify that this is accessed as an array
            $$->value = 2;

            // the expression
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
                            
                            // relop operator
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
                            // pass up the pointer
                            $$ = $1;
                        }
                    | additive_expression addop term
                        {
                            // create new node
                            $$ = ASTCreateNode(EXPR);
                            
                            // additive expression
                            $$->s1 = $1;
                            
                            // addop opeartor
                            $$->operator = $2;
                            
                            // term
                            $$->s2 = $3;
                        }
                    ;

addop   : '+' /*addop → + | -*/
            {
                // plus operator
                $$ = PLUS;
            }
        | '-'
            {
                // minus operator
                $$ = MINUS;
            }
        ;

term    : factor /*term → factor { multop factor } (left-associative)*/
            {
                // pass up the pointer
                $$ = $1;
            }
        | term multop factor   
            {
                // new node
                $$ = ASTCreateNode(EXPR);
                
                // term
                $$->s1 = $1;
                
                // multop operator
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
               
               // set the value of NUM
               $$->value = $1;
               
            } // end NUM
            
        | var
            {
                // pass up the pointer
                $$ = $1;
            }
        | call
            {
                // pass up the pointer
                $$ = $1;
            }
        | TRUE
            {
                // Create new node for NUMBER
                $$ = ASTCreateNode(NUMBER);

                // True will be 1
                $$->value = 1;
            }
        | FALSE
            {
                // Create new node for NUMBER
                $$ = ASTCreateNode(NUMBER);

                // False will be 0
                $$->value = 0;
            }
        | NOT factor
            {
                // Create a node for expression statement
                $$ = ASTCreateNode(EXPR);

                // operator
                $$->operator = NOTOP;

                // factor
                $$->s1 = $2;
            }
        ;

call    : ID '(' args ')' /*call → ID ( args )*/
            {
                // Create a node for call statement
               $$ = ASTCreateNode(FUNCALL);

               // the name of the function called
               $$->name = $1;

               // the arguments
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

                    // pass up the pointer
                    $$ = $1;

                    // connect to the next expression  
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
