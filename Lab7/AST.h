/* Abstract syntax tree code
 * Taken from Shaun Cooper, 2019
 */

/*
    Filename: AST.h
    Description: a header file to contain the enum of operators and node types
    Modified by Long Tran
    Date: April 17th, 2020

    Changes:
    + Added NodeType arg. 
    + Add a new field in ASTNode symbol of type SymbTab
    + Add prototype for check_parameters
 */

// preprocessors wrapper
#ifndef AST_H
#define AST_H

// operators and basic data type
enum OPERATORS {
    // math operators
    // +
    PLUS,
    MINUS,
    // -
    TIMES,
    // /
    DIV,
    // and
    ANDBW,
    // or
    ORBW,
    
    // comparison operators
    // <
    LESS,
    // <=
    LESSE,
    // >
    GREAT,
    // >=
    GREATE,
    // ==
    EQUAL,
    // !=
    NEQUAL,
    // not
    NOTOP,
   
    // types
    INTTYPE,
    BOOLTYPE,
    VOIDTYPE
   
}; // end of OPERATORS

// the type of the node in the abstract syntax tree
enum NodeType {
// declarations
    // variable declaration
    VARDEC,
    
    // function declaration
    FUNDEC,
    
    // parameter
    PARAM,
    
// statements
    // compound statement
    COMPSTMT,
    // expression statement
    EXPRSTMT,
    // selection statement
    IFSTMT, // if
    IFSTMT1, // then and/or else
    // iteration statement
    ITERSTMT,
    // assignment statement
    ASSIGNSTMT,
    // return statement
    RETURNSTMT,
    // read statement
    READSTMT,
    // write statement
    WRITESTMT,
    
// call
    FUNCALL,

    ARG,

// Variable
    VAR,

// expression
    // expression
    EXPR,
    
// identifier and number
    IDENT,
    NUMBER,
}; // end ASTtype

// the struct data type for the tree node in the abstract syntax tree
typedef struct ASTNode {
    // the type of the node
    enum NodeType type;

    // used both for data type of variables (int, boolean, void), math operators like plus, and minus
    // and comparison operators
    enum OPERATORS operator;

    // data type
    enum OPERATORS sem_type; // this may be is DATATYPE

    // use for the name of nodes like variable, and functions
    char * name;
    
    // used for size of a variable declaraion, variable and the value of token like NUM. 
    int value;

    // a pointer to a tab in symbol table
    struct SymbTab * symbol;
    
    // links to the next statement or declaration
    struct ASTNode *next;
    
    // usually linked to operands 
    struct ASTNode *s1, *s2;
} ASTNode; // end struct AST

// functions declaration
// create new ASTNode with a specified AST type
ASTNode * ASTCreateNode(enum NodeType type);

// print as many spaces as the parameter
void PT(int howmany);

// Print out the abstract syntax tree
void ASTprint(ASTNode *p, int level);

// print the type of operator from the given enum OPERATORS
void printOperator(enum OPERATORS op);

// check if the parameters are the same as the argumentes
// 1 if Okay, 0 if not okay
int check_parameters(struct ASTNode * fparam, struct ASTNode * aparam);
#endif  // of AST_H
