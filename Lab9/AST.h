/* Abstract syntax tree code
 * Taken from Shaun Cooper, 2019
 */

/*
    Filename: AST.h
    Description: a header file to contain the enum of operators and node types
    Modified by Long Tran
    Date: May 8th, 2020

    Changes:
    + Add function prototype checkPointer
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

    // use for storing the label of this type of node, if any
    char * label;
    
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
// pre: an enum node type in NodeType
// post a ASTtree node with the input type, s1, s2, and next is set to null
ASTNode * ASTCreateNode(enum NodeType type);

// print as many space as the parameter given to the function
// pre: a number of how many spaces to make
// post: printing out in the screen the number of spaces.
void PT(int howmany);

// Print out the abstract syntax tree with some level of indentation given in the parameter
// if the type of the node given is not defined, the function will print out an error message.
// pre: an ASTtree node, and the spacing level
// post: print out the structure of that node with appropriate spacing level.
void ASTprint(ASTNode *p, int level);

// print the types of the operator given in the parameter
// if it contains an undefined type, it will print a message to it
// pre: a pointer to an OPERATORS op
// post: print out on screen the type of that operator
void printOperator(enum OPERATORS op);

// check if the parameters are the same as the argumentes
// 1 if Okay, 0 if not okay
// pre: a pointer to the ASTnode of param and a pointer to the ASTnode of the argument
// post: return 1 if the argument matches the param. else 0.
int check_parameters(struct ASTNode * fparam, struct ASTNode * aparam);

// check if the node is an array reference
// pre: a AST node
// post: return 1 if the node has type IDENT, and it is a array reference (p->value = 3). else return 0.
int checkPointer(ASTNode * p);
#endif  // of AST_H
