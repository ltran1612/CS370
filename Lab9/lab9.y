/*
    File Name: lab7.y
    Description: This yacc routine will parse the input and checks if the program matches the syntax of the ALGOL_C. It will print out any possible syntax error with the line on which the error is.
    Author: Long Tran
    Date: April 17th, 2020
    Input: strings
    Output: If the program is syntactically correct, it will print "The program is syntactically correct"
    Changes: 
    + Create a ARG node and s1 to the expression instead of just passing up expression
    + Add check for declaration in var_list, and if it has not been decalred, add it in the symbol table.
    + In func dec, save the offset to global offest, and set the offset to 2 (2 because of the 2 spaces needed for machine). Also, assign the param for
    for funcdec after param. Finally, set the size of the function to be the largest offset that the function body would need.
    + In param, the normal scalar var and the array reference will have size of 1 in the symbol table. However, array reference will have isFunc = 2
    + In compound, set the greatest offset and delete all var declarations instide that compound statement (level).
    + In var, make sure that the id is a variable, if a function -> barf. In Var[expression], make sure that id is an array, else barf
    + In all of the epxressions rule (simple, addition, and term), check if the two operands have the same type, else barf
    + In function call, check if the id has been defined, if not -> barf. Then, check if the id is for a function, if not -> barf. Then check if 
    the arguments passed match the parameter list of the function, if not -> barf.
    + Num will have type int
    + True/False will have type boolean
*/

%{
// stdio.h for fprintf
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
// include access to symbol table
#include "symtable.h"
// include to access the nodes types
#include "AST.h"
//
#include "emit.h"

// the offset where function will start
#define FUNC_START_OFFSET 2

// linecount is  by lex
extern int linecount;
// prototype to avoid having to include yy.lex.c
// the global pointer to the root of the abstract syntax tree of the entire program.
ASTNode * gp;
// level variable
int level = 0;
// offset
// current offset at the global level or in a function
// offset is measured in words.
int offset = 0; 
int GOFFSET; // holds the global offset
int MAXOFFSET; // the maximum amount of memory needed for the current function

extern int debug;

// functions
int yylex();
// called yyparase on syntax error
void yyerror(char const * s) {
    fprintf(stderr, "%s on line %d\n", s, linecount);
    exit(1);
} // end yyerror

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
%token <string> STRING

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
                            
                            // assign the symbol entry of this variable to the symbol field
                            p->symbol = Search(p->name, level, 0);

                            // the type of the symbol table entry is the type of the variable.
                            p->symbol->type = $1;
                        } // end for p
                        
                        // pass up the pointer
                        $$ = $2;

                        // // show the table inserted
                        // Display();
                    } // end type_specifier var_list
                ; 

var_list    :   ID /*var-list → ID | ID [ NUM ] | ID , var-list | ID [ NUM ] , var-list*/
                {
                    // if duplicate
                    if (Search($1, level, 0) != NULL) {
                        char * s = $1;
                        s = strcat(s, " has already been declared");
                        yyerror(s);
                    } // end if

                    // not duplicate
                    // Vardec node for normal variable
                    $$ = ASTCreateNode(VARDEC);
                    // name of the variable
                    $$->name = $1;
                    // the size of the variable
                    $$->value = 1;

                    // Insert the var dec into the table
                    Insert($$->name, -1, 0, level, 1, offset, NULL);
                    // increment the offset
                    offset += 1; 
                } // end ID
                
            |   ID '[' NUM ']' 
                {
                    // duplicate variable
                    if (Search($1, level, 0) != NULL) {
                        char * s = $1;
                        s = strcat(s, " has already been declared");
                        yyerror(s);
                    } // end if

                    // Vardec node for array variable
                    $$ = ASTCreateNode(VARDEC);
                    // name of the variable
                    $$->name = $1;
                    // the size of the variable
                    $$->value = $3;
                    
                    // Insert the var dec into the table
                    Insert($$->name, -1, 2, level, $3, offset, NULL);
                    // increase the offset
                    offset += $3;
                } // end ID [NUM]
                
            |   ID  ',' var_list 
                {
                    // duplicate variable
                    if (Search($1, level, 0) != NULL) {
                        char * s = $1;
                        s = strcat(s, " has already been declared");
                        yyerror(s);
                    } // end if

                    // Vardec node for normal variable
                    $$ = ASTCreateNode(VARDEC);
                    // name of the variable
                    $$->name = $1;
                    // the size of the variable 
                    $$->value = 1;
                    // connect to the next declaration
                    $$->s1 = $3;

                    // Insert the var dec into the table
                    Insert($$->name, -1, 0, level, 1, offset, NULL);
                    // increment the offset
                    offset += 1;
                } // end ID , var_list
                
            |   ID '[' NUM ']' ',' var_list 
                {
                    // duplicate variable
                    if (Search($1, level, 0) != NULL) {
                        char * s = $1;
                        s = strcat(s, " has already been declared");
                        yyerror(s);
                    } // end if

                    // Vardec node for array variable
                    $$ = ASTCreateNode(VARDEC);
                    // name of the variable
                    $$->name = $1;
                    // the size of the variable
                    $$->value = $3;
                    // connect to the next declaration
                    $$->s1 = $6;

                    // Insert the var dec into the table
                    Insert($$->name, -1, 2, level, $3, offset, NULL);
                    // increase the offset
                    offset += $3;
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

fun_declaration : type_specifier ID '(' 
                    {
                        // duplicate declaration of the same name
                        if (Search($2, level, 0) != NULL) {
                            yyerror("Duplicate func dec");
                        } // end if

                        // insert the definition of the variable
                        Insert($2, $1, 1, level, 0, 0, NULL);
                                
                        // save the offset
                        GOFFSET = offset;
                        // reset offset leave two for the old stack pointer and base pointer.
                        offset = FUNC_START_OFFSET;
                        // initialize MAXOFFSET
                        MAXOFFSET = offset;
                    }          
                    params ')' 
                    {
                        // I know search will work
                        // This updates the formal parameter link
                        // in my symbol table.         
                        Search($2, level, 0)->fparms = $5;
                    }
                    compound_stmt /*fun-declaration →type-specifier ID ( params ) compound-stmt*/
                    {
                        // we assume MAXOFFSET is the maximum memory needed
                        // create node for fun declaration
                        $$ = ASTCreateNode(FUNDEC);
                        // name
                        $$->name = $2;
                        // return type
                        $$->operator = $1;
                        // parameters
                        $$->s1 = $5;
                        // compound statement
                        $$->s2 = $8;

                        // set the size of the function to be MAXOFFSET
                        $$->symbol = Search($2, 0, 0);
                        $$->symbol->size = MAXOFFSET;

                        // on funcdec exit, reset offset to saved global offset
                        offset = GOFFSET;
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
                // duplicate variable declaration
                if (Search($2, level + 1, 0) != NULL) {
                    yyerror("Duplicate Variable");
                } // end if

                // Create new node for a non-array parameter
                $$ = ASTCreateNode(PARAM);
                // name of the param
                $$->name = $2;
                // not an array, size is 1
                $$->value = 1;
                // type of the param
                $$->operator = $1;
                /// set the semantic type of param
                $$->sem_type = $1;

                // insert
                $$->symbol = Insert($$->name, $1, 0, level + 1, 1, offset, NULL);;
                // increment offset
                offset += 1;
            } // end type_specifier ID
            
        | type_specifier ID '[' ']' 
            {
                // duplicate variable
                if (Search($2, level + 1, 0) != NULL) {
                    yyerror("Duplicate Variable");
                } // end if

                // Create new node for an array parameter
                $$ = ASTCreateNode(PARAM);
                // name of the param
                $$->name = $2;
                // an array, size is 1
                $$->value = 1;
                // type of the param
                $$->operator = $1;
                // set the semantic type for param
                $$->sem_type = $1;

                // insert
                $$->symbol = Insert($$->name, $1, 3, level + 1, 1, offset, NULL);
                // increment offset, 1 because it is a poitner
                offset += 1;
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
                
compound_stmt   : MYBEGIN   
                    { 
                        level++; /*enter compound, increment level*/
                    }
                    local_declaration statement_list END /*compound-stmt → begin local-declarations statement-list end*/
                    {
                        // create new node for compound statement
                        $$ = ASTCreateNode(COMPSTMT);
                        // changed to $3 because it is shifted
                        // local declarations
                        $$->s1 = $3;
                        // statements 
                        $$->s2 = $4;

                        // set up the MAXOFFSET
                        if (offset > MAXOFFSET)
                            MAXOFFSET = offset;

                        // exit compound
                        Display();
                        offset -= Delete(level);  /* decrease the offset count by the size of values allocated at level */

                        // also, decrement level
                        level--;   
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
                            if (checkPointer($1))     
                                yyerror("Array does not have an index");

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
                        if (checkPointer($2))
                            yyerror("Array does not have an index");
                    
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
                        if (checkPointer($2))
                            yyerror("Array does not have an index");

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
                        if (checkPointer($2))
                            yyerror("Array does not have an index");
                        
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
                        if (checkPointer($2))
                            yyerror("Array does not have an index");
                            
                        // Create a node for return statement
                        $$ = ASTCreateNode(RETURNSTMT);

                        // the return expression
                        $$->s1 = $2;
                    }
            ;

read_stmt   : READ var ';' /*read-stmt → read variable ;*/
                    {
                       if (checkPointer($2))
                            yyerror("Array does not have an index");

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
            | WRITE STRING ';'
                    {
                        // Create a node for write STRING
                        $$ = ASTCreateNode(WRITESTMT);
                        $$->name = $2;
                        $$->label = genlabel();

                    }
            ;

assignment_stmt : var '=' simple_expression ';' /*assignment-stmt → var = simple-expression ;*/
                    {
                        if (checkPointer($1) || checkPointer($3))
                            yyerror("Array does not have an index");

                        // check if the type on both size of the assignment statement matched.
                       if ($1->sem_type != $3->sem_type) {
                           yyerror("Type mismatch on assignment");
                       } // end if

                        // Create a node for the assignment statement
                        $$ = ASTCreateNode(ASSIGNSTMT);

                        // the variable
                        $$->s1 = $1;

                        // the expression
                        $$->s2 = $3;

                        $$->name = CreateTemp();
                        $$->symbol = Insert($$->name, $1->sem_type, 0, level, 1, offset, NULL);
                        offset++;
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
            /*
                isFunc
                0 - variable
                1 - function
                2 - array
                3 - array parameter
            */
            // variable not defined
            struct SymbTab * instance = Search($1, level, 1);
            if (instance == NULL) {
                char * s = $1;
                s = strcat(s, " has not been declared");
                yyerror(s);
            } // end if

            // not a normal variable
            if (instance->isFunc == 1) {
                yyerror("needs to be a scalar");
            } // end if

            // a single identifier
            $$ = ASTCreateNode(IDENT);
            // the name of the identifier
            $$->name = $1;
            // a single identifier, so the size is 1
            $$->value = 1;
            // set the semantic type for the variable
            $$->sem_type = instance->type;
            // store the symbol table pointer
            $$->symbol = instance; 

            // if it is the identifier of an array, set value to 3 to distinguish
            if (instance->isFunc != 0) {
                $$->value = 3;
            }
        } // end  ID
        
    | ID '['expression']' 
        {
            // variable not defined
            struct SymbTab * instance = Search($1, level, 1);
            if (instance == NULL) {
                char * s = $1;
                s = strcat(s, " has not been declared");
                yyerror(s);
            } // end if

            // not an array
            if (instance->isFunc != 2 && instance->isFunc != 3) {
                yyerror("Needs to be an array");
            } // end if
            
            // an array
            $$ = ASTCreateNode(IDENT);
            // the name of the identifier
            $$->name = $1;
            // fake number to help identify that this is accessed as an array
            $$->value = 2;
            // the expression
            $$->s1 = $3;
            // set up the semantic type for the variable
            $$->sem_type = instance->type;
            // store the symbol table pointer
            $$->symbol = instance; 
        } // end ID []
    ;

simple_expression   : additive_expression /*simple-expression → additive-expression [ relop additive-expression ] + (left-associative)*/
                        {
                            // pass up the pointer
                            $$ = $1;
                        }
                    | simple_expression relop additive_expression
                        {
                            // check if the type of the operands are the same
                            if  ($1->sem_type != $3->sem_type) {
                                yyerror("Type mismatch");
                            } // end if

                            if (checkPointer($1) || checkPointer($3))
                                yyerror("Array does not have an index");
                                
                            // create new node
                            $$ = ASTCreateNode(EXPR);
                            // simple_expression
                            $$->s1 = $1;
                            // relop operator
                            $$->operator = $2;
                            // additive_expression
                            $$->s2 = $3;
                            // set the semantic type of the expression
                            $$->sem_type = $1->sem_type;

                            $$->name = CreateTemp();
                            $$->symbol = Insert($$->name, $1->sem_type, 0, level, 1, offset, NULL);
                            offset++;
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
                            // check if the type of the operands are the same
                            if  ($1->sem_type != $3->sem_type) {
                                yyerror("Type mismatch");
                            } // end if

                            if (checkPointer($1) || checkPointer($3))
                                yyerror("Array does not have an index");

                            // create new node
                            $$ = ASTCreateNode(EXPR);
                            // additive expression
                            $$->s1 = $1;
                            // addop opeartor
                            $$->operator = $2;
                            // term
                            $$->s2 = $3;
                            // set the semantic type of the expression
                            $$->sem_type = $1->sem_type;

                            $$->name = CreateTemp();
                            $$->symbol = Insert($$->name, $1->sem_type, 0, level, 1, offset, NULL);
                            offset++;
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
                // check if the types of the operands are the same
                if  ($1->sem_type != $3->sem_type) {
                    yyerror("Type mismatch");
                } // end if

               if (checkPointer($1) || checkPointer($3))
                    yyerror("Array does not have an index");

                // new node
                $$ = ASTCreateNode(EXPR);
                // term
                $$->s1 = $1;
                // multop operator
                $$->operator = $2;
                // factor
                $$->s2 = $3;
                // set the semantic type of the expression
                $$->sem_type = $1->sem_type;

                $$->name = CreateTemp();
                $$->symbol = Insert($$->name, $1->sem_type, 0, level, 1, offset, NULL);
                offset++;
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
                // and
                $$ = ANDBW;
            }
        | OR
            {
                // or
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
                // set the semantic type of number
               $$->sem_type = INTTYPE;
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
                // set the semantic type of BOOLEAN value True
                $$->sem_type = BOOLTYPE;
               
            }
        | FALSE
            {
                // Create new node for NUMBER
                $$ = ASTCreateNode(NUMBER);

                // False will be 0
                $$->value = 0;
                 // set the semantic type of BOOLEAN value False
                $$->sem_type = BOOLTYPE;

            }
        | NOT factor
            {
                // check if factor is ok.
                if ($2->sem_type != BOOLTYPE) {
                    yyerror("Needs to be a boolean");
                } // end if

                // Create a node for expression statement
                $$ = ASTCreateNode(EXPR);
                // operator
                $$->operator = NOTOP;
                // factor
                $$->s1 = $2;
                // set the semantic type of this expression
                $$->sem_type = $2->sem_type;

                $$->name = CreateTemp();
                $$->symbol = Insert($2->name, $2->sem_type, 0, level, 1, offset, NULL);
                offset++;
            }
        ;

call    : ID '(' args ')' /*call → ID ( args )*/
            {
                struct SymbTab * instance = Search($1, 0, 0);
                if (instance == NULL) {
                    char * s = $1;
                    s = strcat(s, " (function) has not been declared");
                    yyerror(s);
                } // end if

                if (instance->isFunc != 1) {
                    yyerror("Needs to be a function");
                } // end if

               if (check_parameters(instance->fparms, $3) != 1) {
                    yyerror("Function actual and formal parameter mismatch");
               } // end if

                // Create a node for call statement
                $$ = ASTCreateNode(FUNCALL);

                // the name of the function called
                $$->name = $1;

                // the arguments
                $$->s1 = $3;

                $$->sem_type = instance->type;

                $$->symbol = instance;
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
                    // Create new argument node
                    $$ = ASTCreateNode(ARG);
                    $$->s1 = $1; 
                    $$->sem_type = $1->sem_type;

                    $$->name = CreateTemp();
                    $$->symbol = Insert($$->name, $1->sem_type, 0, level, 1, offset, NULL);
                    offset++;
                }
            | expression ',' arg_list
                {
                    // argument list

                    // Create new argument node
                    $$ = ASTCreateNode(ARG);
                    $$->s1 = $1; 

                    // connect to the next expression  
                    $$->next = $3;

                    $$->sem_type = $1->sem_type;

                    $$->name = CreateTemp();
                    $$->symbol = Insert($$->name, $1->sem_type, 0, level, 1, offset, NULL);
                    offset++;
                }
            ;
         
%%

int main(int argc, char * argv[]) {
    char filename[100];
    int i;
    FILE * outfile = NULL;
    for (i = 0; i < argc;) {
        // process our argument list
        if (strcmp(argv[i], "-d") == 0) {
            // set debug flag
            debug = 1;

            // move to the next arg
            i++;
        } // end if
        else if (strcmp(argv[i], "-o") == 0) {
            // We assume argv[i+1] is the file we want to open
            if (i + 1 >= argc) {
                fprintf(stderr, "No filename was given\n");
                exit(1);
            } // end if
            
            // attatch the .asm to the filename taken from the argument after -o flag
            sprintf(filename, "%s.asm", argv[i+1]);

            /* we want to use a file descriptor and want to save the result in that file*/
           outfile = fopen(filename, "w");
            if (outfile == NULL) {
                printf("Cannot create file %s\n", filename);
                exit(1);
            } // end if

            // move pass the argument
            i = i + 2;
        } // end else if
        else i++;
    } // end for i

    if (outfile != NULL) {
        // write the content of the compilation into the file
        yyparse();
        fprintf(outfile, ".data\n\n");

        // all strings
        EMITSTRINGS(gp, outfile);
        fprintf(outfile, "_NL:\t.asciiz\t\"\\n\"\n");
        fprintf(outfile, ".align 2 # start all of global variable aligned\n\n");

        // all global variable
        EMITGLOBAL(gp, outfile);

        // instruction section
        fprintf(outfile, "\n.text\n\n");
        fprintf(outfile, "j main\n\n");
        EMITAST(gp, outfile);
        ASTprint(gp, 0);
    } // end if
    else {
        fprintf(stderr, "No output file name was given\n");
        exit(1);
    } // end else

    // print out the syntas tree
    //ASTprint(gp, 0);
} // end main

