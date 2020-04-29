/*
    File Name: AST.c
    Description: Contain the ASTprint function that will help print the AST tree.
    Author: Long Tran
    Date: April 17th, 2020

    Changes:
    + Comments
    + Add check parameters to check if the arguments of a function matches the parameters of a function.
    + Add a argument case in printASTNode to print ARGUMENT then the expression.
*/
#include <stdio.h>
#include <stdlib.h>
// comment out malloc.h because on mac, it warns that malloc is not found, malloc is included in stdlib
//#include <malloc.h>
#include "AST.h" // have access to ASTNode
#include "symtable.h"

// the spacing level
#define level1 1
#define level2 2
#define level3 3

// create new ASTNode with a specified AST type
ASTNode * ASTCreateNode(enum NodeType type) {
    // Dynamically create a new node
    ASTNode * p = (ASTNode *) malloc(sizeof(struct ASTNode));

	// set the node type
    p->type = type;
	
	// set s1, s2, and next to null
    p->name = NULL;
    p->label = NULL;
    p->s1 = NULL;
    p->s2 = NULL;
    p->next = NULL;
    p->symbol = NULL;

	// return a pointer to that newly created node
    return p;
} // end ASTCreateNode

// print as many space as the parameter given to the function
void PT(int howmany) {
    int i;
    for (i = 0; i < howmany; ++i)
        fprintf(stderr, " ");
} // end PT

// Print out the abstract syntax tree with some level of indentation given in the parameter
// if the type of the node given is not defined, the function will print out an error message.
void ASTprint(ASTNode *p, int level) {
    // NULL we will not print anything because it is empty 
    if (p == NULL) return;
       
    // for each type of node type, print its content
    switch (p->type) {
        // var-declaration
        case VARDEC: // variable declaration
        {
            // print the spacing
            PT(level);
            
            // print Variable
            fprintf(stderr, "Variable ");
            
            // print its type 
            printOperator(p->operator);
            
            // print the name of the variable
            fprintf(stderr, "  %s", p->name);
            
            // if the value is greater than 1, then it is an array
            // else it is not
            if (p->value > 1)
                fprintf(stderr, "[%d]", p->value);
            
            // has offset
            fprintf(stderr, " has offset %d", p->symbol->offset);

            // print new line
            fprintf(stderr, "\n");

            // print the next declaration on the same line if any.
            ASTprint(p->s1, level);
            
            break; // of VARDEC
        }
            
        // fun-declaration
        case FUNDEC:
        {
            // print the spaces
            PT(level);
            
            // print return type
            printOperator(p->operator);
            
            // print FUNCTION
            fprintf(stderr, " FUNCTION ");
            
            // print function name
            fprintf(stderr, "%s", p->name);

            // print has size
            fprintf(stderr, " has size %d\n", p->symbol->size);
            
            // print parameters
			// if s1 is null, meaning no parameter, print VOID
			// else print the list of parameters 
            if (p->s1 == NULL) {
                PT(level + level3);
                fprintf(stderr, "(");
                fprintf(stderr, "VOID");
                fprintf(stderr, ")\n");
            } // end if
            else {
                // print some spacing for the left paranthese
                PT(level + level2);
                // print left paranthese
                fprintf(stderr, "(\n");

                // print the parameters
                ASTprint(p->s1, level+ level2);

                // print the spacing for the right paranthese
                PT(level + level2);
                fprintf(stderr, ")\n");
            } // end else
            
            // print the compound statement
            ASTprint(p->s2, level + level2);
            
            break; // of FUNDEC
        }
        
        // param
        case PARAM:
        {    
            // print spaces
            PT(level);
            
            // print PARAMETER
            fprintf(stderr, "PARAMETER ");
            
            // print type
            printOperator(p->operator);
            
            // print name
            fprintf(stderr, " %s", p->name);
            
            // if the value is greater than 1, it is an array, then print []
			// else it is not
            if (p->value > 1) 
                fprintf(stderr, "[]");

            // print has offset
            fprintf(stderr, " has offset %d", p->symbol->offset);

            // get to a new line
            fprintf(stderr, "\n");
            
            break; // of PARAM
        }
        
        // compound statement
        case COMPSTMT:
        {
            // print the spacing
            PT(level);
            
            // print BLOCK STATEMENT
            fprintf(stderr, "BLOCK STATEMENT\n");
            
            // print local declaration
            ASTprint(p->s1, level + level1);
            
            // print statement-list
            ASTprint(p->s2, level + level1);
            
            break; // of COMPSTMT
        } // end compound statement
        
        // iteration statement
        case ITERSTMT:
        {
            // print some spacing
            PT(level);
            
            // print WHILE STATEMENT
            fprintf(stderr, "WHILE STATEMENT\n");
            
            // print expression
            ASTprint(p->s1, level + level1);
            
            // print statement
            ASTprint(p->s2, level + level2);
            
            break; // of ITRSTMT
        } // end iteration statement
            
        // selection statement
        // the expression of if statement
        case IFSTMT: // if /
        {
            // print the spacing
            PT(level);
            
            // print IF
            fprintf(stderr, "IF STATEMENT\n");
            
            // print the expression
            ASTprint(p->s1, level+ level1);
            
            // print IFSTMT1
            ASTprint(p->s2, level + level1);
            
            break;  // of IFSTMT
        } // end if 
        
        // then and/or else statement
        case IFSTMT1: // then or then and else
        {
            // print the spacing
            PT(level);
            
            // print then
            fprintf(stderr, "THEN\n");
            ASTprint(p->s1, level+ level1);
            
            // print else
            if (p->s2 != NULL) {
                // print the spacing
                PT(level);

                // print ELSE
                fprintf(stderr, "ELSE\n");

                // print else
                ASTprint(p->s2, level+ level1);
            } // end if
            
            break; // of IFSTMT1
        } // end then or then and else
            
        // assign statement
        case ASSIGNSTMT:
        {
            // print spacing
            PT(level);
            
            // print the Assignment STATEMENT
            fprintf(stderr, "Assignment STATEMENT\n");
            
            // print the left side
            ASTprint(p->s1, level + level1);
            
            // print the right side
            ASTprint(p->s2, level + level1);
            
            break; // of ASSIGNSTMT
        } // end assignment statement
            
        // return statement
        case RETURNSTMT:
        {
			// print some spacing
			PT(level);

			// print Return
			fprintf(stderr, "RETURN STATEMENT\n");

			// ASTprint
			ASTprint(p->s1, level + level1);

            break; // of RETURNSTMT
        } // end return statement
        
        // read statement
        case READSTMT:
        {
            // print some spacing
            PT(level);
            
            // print READ STATEMENT
            fprintf(stderr, "READ STATEMENT\n");
            
            // print the var
            ASTprint(p->s1, level + level1);
            
            break; // of READSTMT
        } // end read statement
            
        // write statement
        case WRITESTMT:
        {
            // print some spacing
            PT(level);
            
            // print WRITE STATEMENT
            fprintf(stderr, "WRITE STATEMENT\n");
            
            if (p->name != NULL) {
                PT(level + level1);
                fprintf(stderr, "%s\n", p->name);
            } // end if
            else {
                // print the expression
                ASTprint(p->s1, level + level1);
            } // end else
            
            break; // of WRITESTMT
        } // end write statement
			
		case EXPRSTMT:
        {   
            // print the spacing
            PT(level);
            
            // print EXPRSTMT
            fprintf(stderr, "EXPRSTMT\n");
            
            // print the expression
            ASTprint(p->s1, level + level1);
            
			break; // of EXPRSTMT
        } // end expression statement
			
		case EXPR:
        {
		 	// print the spacing
			PT(level);
            
			// print EXPR
            fprintf(stderr, "EXPR  ");
            
			// print the operator
            printOperator(p->operator);
            
            // new line
            fprintf(stderr, "\n");
            
            // print the left operand
            ASTprint(p->s1, level + level1);
            
            // print the right operand
            ASTprint(p->s2, level + level1);
            
			break; // of EXPR
        } // end expression
        
        case IDENT:
        {
            // print the spacing
            PT(level);
        
            // a single variable, not an array
            // print IDENTIFIER
            fprintf(stderr, "IDENTIFIER ");
            
            // print the its name
            fprintf(stderr, "%s\n", p->name);
            
			// if the value is greater than 1, it is an arary, print it as an array
            if (p->value > 1)
            {
                // some spacing
                PT(level);
                
                // an array
                // print Array Reference [ newline
                fprintf(stderr, "Array Reference [\n");
                
                // print the expression in the array
                ASTprint(p->s1, level + level1);
                
                // print ] and end array
                PT(level);
                fprintf(stderr, "] end array\n");
                
            } // end if
            
            break; // of IDENT
        } // end identifier
        
        case NUMBER:
        {
            // print the spacing
            PT(level);
            
            // print NUMBER
            fprintf(stderr, "NUMBER with value ");
            
            // print its value
            fprintf(stderr, "%d\n", p->value);
            
            break; // of NUMBER
        } // end number
        
        // function call
        case FUNCALL:
        {
            // print the spacing
            PT(level);
            
            // print FUNCTION CALL
            fprintf(stderr, "CALL %s\n", p->name);
            
            // print the arguments
            // if null, then there are no arguments, print empty ()
            // else print the arguments inside the parantheses
            if (p->s1 == NULL) {
                PT(level + level3);
                fprintf(stderr, "()\n");
            } // end if
            else {
                // print the spacing for left paranthese
                PT(level + level2);
                // print left paranthese
                fprintf(stderr, "(\n");

                // print the arguments
                ASTprint(p->s1, level+ level2);

                // print the spacing for the right paranthese
                PT(level + level2);
                // print right paranthese
                fprintf(stderr, ")\n");
            } // end else
            break; // of FUNCALL
        } // end funcall

        case ARG:
        {
            // print the level
            PT(level);
            
            // print ARGUMENT
            fprintf(stderr, "ARGUEMENT\n");
            
            // print the expression of the argument
            ASTprint(p->s1, level + level1);
            break; // of ARG
        } // end ARG
		
        // default type when a new type of node is found
        default: 
            fprintf(stderr, "UNKNOWN type in ASTprint\n");
            break;

    } // end switch

    // print out the node this node is connected to in the same level
	ASTprint(p->next, level);

} // end ASTprint

// print the types of the operator given in the parameter
// if it contains an undefined type, it will print a message to it
void printOperator(enum OPERATORS op) {
    switch (op) {
        // variable types
        case INTTYPE:
            fprintf(stderr, "INT");
            break;
        case BOOLTYPE:
            fprintf(stderr, "BOOLEAN");
            break;
        case VOIDTYPE:
            fprintf(stderr, "VOID");
            break;
        
        // math operators
        case PLUS:
            fprintf(stderr, "+");
            break;
        case MINUS:
            fprintf(stderr, "-");
            break;
        case TIMES:
            fprintf(stderr, "*");
            break;
        case DIV:
            fprintf(stderr, "/");
            break;

        // not sure what is this yet
        case ANDBW:
            fprintf(stderr, "AND");
            break;
        case ORBW:
            fprintf(stderr, "OR");
            break;
    
        // comparison operators
        case LESS:
            fprintf(stderr, "<");
            break;
        case LESSE:
            fprintf(stderr, "<=");
            break;
        case GREAT:
            fprintf(stderr, ">");
            break;
        case GREATE:
            fprintf(stderr, ">=");
            break;
        case EQUAL:
            fprintf(stderr, "==");
            break;
        case NEQUAL:
            fprintf(stderr, "!=");
            break;
        case NOTOP:
            fprintf(stderr, "NOT");
            break;
        
        // undefined type
        default:
            fprintf(stderr, "Undefined type\n");
    } // end switch
} // end printOperator

// check if the parameters are the same as the argumentes
// 1 if Okay, 0 if not okay
int check_parameters(struct ASTNode * fparam, struct ASTNode * aparam) {
    // base cases
    if (fparam == NULL && aparam == NULL) return 1; // no arg and no parm -> true
    if (fparam == NULL || aparam == NULL) return 0; // param length and arg length does not match -> false

    // fparam and aparam is not null, check if they have the same type
    if (fparam->sem_type != aparam->sem_type) return 0; // not the same type -> false

    // check if the argument is an array if the parameter expects an array reference
    if (fparam->symbol->isFunc == 3 && !(checkPointer(aparam->s1))) return 0;

    return check_parameters(fparam->next, aparam->next);
} // end if

int checkPointer(ASTNode * p) {
    if (p->type != IDENT) return 0;
    
    // an array address
    if (p->value == 3) return 1; 
    
    return 0;
} // end checkPointer
