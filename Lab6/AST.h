/* Abstract syntax tree code
 * Taken from Shaun Cooper, 2019
 */

/* Description:
 * Modified by Long Tran
 * Date:
 */

#ifndef AST_H
#define AST_H

// operators and type
enum OPERATORS {
    // math operators
    PLUS,
    MINUS,
    TIMES,
    DIV,
    ANDBW,
    ORBW,
    
    // comparison operators
    LESS,
    LESSE,
    GREAT,
    GREATE,
    EQUAL,
    NEQUAL,
    NOTOP,
   
    // types
    INTTYPE,
    BOOLTYPE,
    VOIDTYPE
   
}; // end of OPERATORS

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
    IFSTMT, // if then
    IFSTMT1, // if else
    // iteration
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
    
// argument
    ARG,

// Variable
    VAR,

// expression
    // expression
    EXPR,
    
// identifier and number
    IDENT,
    NUMBER,
    
// other
}; // end ASTtype

typedef struct ASTNode {
    enum NodeType type;
    // used both for data type and math operators like plus, and minus
    enum OPERATORS operator;
    char * name;
    
    // used for size of a variable declaraion, variable and the value of token like NUM. 
    int value;
    
    // links to the next statement or declaration
    struct ASTNode *next;
    
    // links to operands 
    struct ASTNode *s1, *s2;
    
    // more
} ASTNode; // end struct AST

// functions declaration
// create new ASTNode with a specified AST type
ASTNode * ASTCreateNode(enum NodeType type);

// attach the two AST list given in the parameters with next
void ASTattachnext(ASTNode *p, ASTNode *q);

// print the space
void PT(int howmany);

// Print out the abstract syntax tree
void ASTprint(ASTNode *p, int level);

void printOperator(enum OPERATORS op);


#endif  // of AST_H
