#include <stdio.h>
#include <malloc.h>
#include "AST.h"
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
    p->s1 = NULL;
    p->s2 = NULL;
    p->next = NULL;

	// return a pointer to that newly created node
    return p;
} // end ASTCreateNode

// attach the two AST list given in the parameters with next
void ASTattachnext(ASTNode *p, ASTNode *q) {
} // end ASTattachnext

// print as many space as the parameter given to the function
void PT(int howmany) {
    int i;
    for (i = 0; i < howmany; ++i)
        fprintf(stderr, " ");
} // end PT

// Print out the abstract syntax tree with some level of indentation given in the parameter
void ASTprint(ASTNode *p, int level) {
    // NULL we will not print anything because it is empty 
    if (p == NULL) return;
       
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
            fprintf(stderr, " %s", p->name);
            
            // if the value is greater than 1, then it is an array
            // else it is not
            if (p->value > 1)
                fprintf(stderr, "[%d]\n", p->value);
            
            // print the next declaration if any.
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
            fprintf(stderr, "%s\n", p->name);
            
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
                PT(level + level2);
                fprintf(stderr, "(");
                ASTprint(p->s1, level+ level2);
                fprintf(stderr, "\n");
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
            // get to a new line
            fprintf(stderr, "\n");
            
            // print spaces
            PT(level);
            
            // print PARAMETER
            fprintf(stderr, "PARAMETER ");
            
            // print type
            printOperator(p->operator);
            
            // print name
            fprintf(stderr, " %s", p->name);
            
            // if the value is greater than 1, it is an array
			// else it is not
            if (p->value > 1) 
                fprintf(stderr, "[]");
            
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
        // if statement
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
        
        // else statement
        case IFSTMT1: // then or then and else
        {
            // print the spacing
            PT(level);
            
            // print then
            fprintf(stderr, "THEN\n");
            ASTprint(p->s1, level+ level1);
            
            // print the spacing
            PT(level);
            
            // print else
            fprintf(stderr, "ELSE\n");
            ASTprint(p->s2, level+ level1);
            
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
            
            // print the expression
            ASTprint(p->s1, level + level1);
            
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
            fprintf(stderr, "EXPR ");
            
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
                
                // print the expression
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
            if (p->s1 == NULL) {
                PT(level + level3);
                fprintf(stderr, "()\n");
            } // end if
            else {
                PT(level + level2);
                fprintf(stderr, "(\n");
                ASTprint(p->s1, level+ level2);
                PT(level + level2);
                fprintf(stderr, ")\n");
            } // end else
            break; // of FUNCALL
        } // end funcall
			
        default: 
            fprintf(stderr, "UNKNOWN type in ASTprint\n");
            break;

    } // end switch
	ASTprint(p->next, level);

} // end ASTprint

// print the types of the operator given in the parameter
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
        
        default:
            fprintf(stderr, "Undefined type\n");
    } // end switch
} // end printOperator
