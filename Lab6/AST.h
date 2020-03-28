/* Abstract syntax tree code
 * Taken from Shaun Cooper, 2019
 */

/* Description: a header file to contain the enum of operators and node types
 * Modified by Long Tran
 * Date: March 28th, 2020
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

    // use for the name of nodes like variable, and functions
    char * name;
    
    // used for size of a variable declaraion, variable and the value of token like NUM. 
    int value;
    
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
#endif  // of AST_H
