#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "AST.h"
#include "emit.h"

static int GLABEL = 0;

char * CURR_FUNCTION;

void emit(FILE * file, char * label, char * command, char * comment);
void emit_function_return(ASTNode * value, FILE * file);
void emit_function_head(ASTNode * p, FILE * file);
void emit_expr(ASTNode * p, FILE * file);
void emit_write(ASTNode * p, FILE * file);
void emit_identifier(ASTNode * p, FILE * file);
void emit_read(ASTNode * p, FILE * file);
void emit_assignment(ASTNode * p, FILE * file);
void emit_arguments(ASTNode * fparam, ASTNode * p,FILE * file);
void emit_iter(ASTNode * p, FILE * file);
void emit_compound(ASTNode * p, FILE * file);
void emit_selection(ASTNode * p, FILE * file);

// Method to genearte asm code for strings used in the code
// Pre: A pointer to the root of the AST Node tree after parsing
// Post: Print out the asm code that define a string in the .data section
void EMITSTRINGS(ASTNode * p, FILE * file)
{
    if (file == NULL) {
        fprintf(stderr, "EMITSTRINGS file is null\n");
        return;
    }
    if (p == NULL) return;

   
    if ((p->type == WRITESTMT) && (p->name != NULL)) {
        char command[100];
        sprintf(command, ".asciiz\t%s", p->name);
        emit(file, p->label, command, "# global string");
    }

    EMITSTRINGS(p->next, file);
    EMITSTRINGS(p->s1, file);
    EMITSTRINGS(p->s2, file);

}   

// Method to genearte asm code for global variables used in the code
// Pre: A pointer to the root of the AST Node tree after parsing
// Post: Print out the asm code that define global variables in the .data section
void EMITGLOBAL(ASTNode * p, FILE * file) {
    if (file == NULL) {
        fprintf(stderr, "EMITGLOBAL file is null\n");
        return;
    }
    if (p == NULL) return;

    // p is not null and file is not null
    char s[100];
    if (p->type == VARDEC && p->symbol->level == 0) {
        sprintf(s, ".space %d", p->value * WSIZE);
        emit(file, p->name, s, "# define a global variable");
    } // end if

    // go to other node
    EMITGLOBAL(p->next, file);
    EMITGLOBAL(p->s1, file);
    EMITGLOBAL(p->s2, file);
}

char * genlabel()
{
    char s[100];
    char * s1;
    sprintf(s, "_L%d", GLABEL++);
    s1 = strdup(s); // want to transfer the string to heap
    return s1;
}

// // Print out the abstract syntax tree with some NULL of indentation given in the parameter
// // if the type of the node given is not defined, the function will print out an error message.
void EMITAST(ASTNode *p, FILE * file) {
    // NULL we will not print anything because it is emy 
    if (p == NULL) return;
       
    // for each type of node type, print its content
    switch (p->type) {
        // fun-declaration
        case FUNDEC:
        {
            emit_function_head(p, file); 
            EMITAST(p->s2, file);
            emit_function_return(NULL, file);
            break; // of FUNDEC
        }
        
        // compound statement
        case COMPSTMT:
        {
            emit_compound(p, file);
            
            break; // of COMPSTMT
        } // end compound statement
        
        // iteration statement
        case ITERSTMT:
        {
            emit_iter(p, file);
            
            break; // of ITRSTMT
        } // end iteration statement
            
        // selection statement
        // the expression of if statement
        case IFSTMT: // if /
        {   
            emit_selection(p, file);
            
            break;  // of IFSTMT
        } // end if 
        
        // then and/or else statement
            
        // assign statement
        case ASSIGNSTMT:
        {
            emit_assignment(p, file);
            
            break; // of ASSIGNSTMT
        } // end assignment statement
            
        // return statement
        case RETURNSTMT:
        {
			emit_function_return(p, file);
            break; // of RETURNSTMT
        } // end return statement
        
        // read statement
        case READSTMT:
        {    
            emit_read(p, file);
            
            break; // of READSTMT
        } // end read statement
            
        // write statement
        case WRITESTMT:
        {
            // print WRITE STATEMENT
            fprintf(stderr, "WRITE STATEMENT\n");
            
            emit_write(p, file);
            break; // of WRITESTMT
        } // end write statement
			
		case EXPRSTMT:
        {   
            emit_expr(p->s1, file);
			break; // of EXPRSTMT
        } // end expression statement

        case ARG:
        {
            // print ARGUMENT
            fprintf(stderr, "ARGUEMENT\n");
            
            // print the expression of the argument
            EMITAST(p->s1, file);
            break; // of ARG
        } // end ARG
		
        // default type when a new type of node is found
        default: 
            fprintf(stderr, "EMIT AST type has not been implemented\n");
            break;

    } // end switch

    // print new line
    emit(file, "", "", "");

    // print out the node this node is connected to in the same NULL
	EMITAST(p->next, file);

} // end EMITAST


// helper functions to make clean MIPS code
// Take in 4 params, and print them out pretty
// Pre: given 3 strings, print them out in Assembling formatting
// in FP
// example emit(fp, "L1", "ldi R13, 15", "#Load a number")
void emit(FILE * file, char * label, char * command, char * comment) {

    if (file == NULL) { 
        fprintf(stderr, "NULL file\n");
        return;
    }
    if (label == NULL || strcmp(label, "") == 0) {
        fprintf(file, "\t\t%s\t\t%s\n", command, comment);
    }
    else {    
        fprintf(file, "%s:\t\t%s\t\t%s\n", label, command, comment);
    }
}

// pre: ptr to fundec
// post header code in MIPS written to file
void emit_function_head(ASTNode * p, FILE * file) 
{
    char s[100];
    emit(file, p->name, "", "# start of FUNCTION");

    // set the global function variable
    CURR_FUNCTION = p->name;

    // build the start pointer movement
    sprintf(s, "subu $a0, $sp, %d", (p->symbol->size) * WSIZE);
    emit(file, "", s, "# adjust the stack for function set up");
    emit(file, "", "sw $sp, ($a0)", "");
    emit(file, "", "sw $ra, 4($a0)", "");
    emit(file, "", "move $sp, $a0", "# adjust the stack pointer");
    emit(file, "", "", "");
}

// method to handle explicit and implicit function returns;
// pre pointer to RETURN or NULL
// POST RETURN CODE in MIPS printed in fp the return value is in $a0
void emit_function_return(ASTNode * p, FILE * file){
    if (file == NULL) return;
    if (p != NULL)
    {
        // we need to evaluate the expression
        emit_expr(p->s1, file); // this leaves $a0 the result
    }

    // if it is null we do nothing with $a0

    // we have to do thing differently if it is main
    if (strcmp(CURR_FUNCTION, "main") == 0) {
        // restore RA and SP
        emit(file, "", "", "");
        emit(file, "", "lw $ra, 4($sp)", "# Restore RA");
        emit(file, "", "lw $sp, ($sp)", "# Restore SP");
        emit(file, "", "", "");

        // handle main return
        emit(file, "", "li $v0, 10", "# leave main program");
        emit(file, "", "syscall", "# leave main");
    }
    else {
        // every other functions TODO by you
        emit(file, "", "", "");
        emit(file, "", "lw $ra, 4($sp)", "# Restore RA");
        emit(file, "", "lw $sp, ($sp)", "# Restore SP");
        emit(file, "", "jr $ra", "");
        emit(file, "", "", "");
    }
} // end emit_function_return


// 
// pre: pointer to WRITESTMT
// POST return code to print string or print expression
void emit_write(ASTNode * p, FILE * file) {
    if (p->name != NULL) {
        emit(file, "", "li $v0, 4", "#print a string");

        char command[100];
        sprintf(command, "la $a0, %s", p->label);
        emit(file, "", command, "#print fetch string location");

    }
    else {
        emit(file, "", "li $v0, 1", "");
        // print the expression
        emit_expr(p->s1, file);
    }
    emit(file, "", "syscall", "");

    // print new line
    emit(file, "", "li $v0, 4", "#print a newline");
    emit(file, "", "la $a0, _NL", "");
    emit(file, "", "syscall", "");
}


/*
    emit_expr
    PRE: a pointer to an expression as defined in YACC language
    POST: MIPS code that sets $a0 to the value of expr
*/
void emit_expr(ASTNode * p, FILE * file) {
    if (p == NULL) return;
    if (file == NULL) return;

    char s[100];
    // base cases
    switch(p->type) {
        case EXPR:
            break;
        case NUMBER:
            if (p->sem_type == INTTYPE) {
                sprintf(s, "li $a0, %d", p->value);
                emit(file, "", s, "# expression is a NUMBER");
            } // end if
            else if (p->value) {
                emit(file, "li $a0, 1", s, "# expression is a TRUE");
            }  // end else if
            else {
                 emit(file, "li $a0, 0", s, "# expression is a FALSE");
            } // end else
            return;
            break;
        case IDENT:
            emit_identifier(p, file);
            emit(file, "", "lw $a0, ($a0)", "#fetch value from the location stored at $a0");
            return;
            break;
        case FUNCALL:
            sprintf(s, "subu $t5, $sp, %d", p->symbol->size * WSIZE);
            emit(file, "", s, "");

            emit_arguments(p->symbol->fparms, p->s1, file);

            sprintf(s, "jal %s", p->name);
            emit(file, "", s, "");
            return;
            break;
        default:
            return;
            break;
    } // end switch

    // evaluate the left hand side
    emit_expr(p->s1, file);
    // store s1 in p->symbol->offset
    sprintf(s, "sw $a0, %d($sp)", p->symbol->offset * WSIZE);
    emit(file, "", s, "");

    // evaluate s2
    emit_expr(p->s2, file);
    // move a0 to a1
    emit(file, "", "move $a1, $a0", "");

    // load a0 with p->symbol->offset
    sprintf(s, "lw $a0, %d($sp)", p->symbol->offset * WSIZE);
    emit(file, "", s, "");

    // perform calculation
    switch(p->operator) {
        case PLUS:
            emit(file, "", "add $a0, $a0, $a1", "");
            break;
        case MINUS:
            emit(file, "", "sub $a0, $a0, $a1", "");
            break;
        case TIMES:
            emit(file, "", "mult $a0, $a1", "");
            emit(file, "", "mflo $a0", "");
            break;
        case DIV:
            emit(file, "", "div $a0", "");
            emit(file, "", "mflo $a0", "");
            break;
        case ANDBW:
            emit(file, "", "and $a0, $a0, $a1", "");
            break;
        case ORBW:
            emit(file, "", "or $a0, $a0, $a1", "");
            break;
        case LESS:
            emit(file, "", "slt $a0, $a0, $a1", "");
            break;
        case LESSE:
            emit(file, "", "slt $t0, $a0, $a1", "");
            emit(file, "", "sub $t1, $a0, $a1", "");
            emit(file, "", "sltiu $t1, $t1, 1", "");
            emit(file, "", "or $a0, $t0, $t1", "");
            break;
        case GREAT:
            emit(file, "", "slt $a0, $a1, $a0", "");
            break;
        case GREATE:
            emit(file, "", "slt $t0, $a1, $a0", "");
            emit(file, "", "sub $t1, $a0, $a1", "");
            emit(file, "", "sltiu $t1, $t1, 1", "");
            emit(file, "", "or $a0, $t0, $t1", "");
            break;
        case EQUAL:
            emit(file, "", "sub $a0, $a0, $a1", "");
            emit(file, "", "sltiu $a0, $a0, 1", "");
            break;
        case NEQUAL:
            emit(file, "", "sub $a0, $a0, $a1", "");
            emit(file, "", "li $t1, 0", "");
            emit(file, "", "sltu $a0, $t2, $a0", "");
            break;
        case NOTOP:
            break;
        default:
            break;
    }
}

// emit_identifier
// PRE: p is a PTR to a identifier node
// POST: MIPS code such that $ao is the ADDRESS of where IDENT is in memory
void emit_identifier(ASTNode * p, FILE * file) {
    if (file == NULL) return;
    if (p == NULL) return;
    if (p->type != IDENT) return;

    char s[100];

    // check if the identifier is global
    if (p->symbol->level == 0) {
        fprintf(stderr, "global level\n");

        // check if it is scalar or array
        if (p->symbol->isFunc == 2) {
            // global array
            // get the index
            emit_expr(p->s1, file);
            // times the word size
            sprintf(s, "sll $a0, $a0, %d", WSIZE / 2);
            emit(file, "", s, "# times the word size");

            sprintf(s, "la $a1, %s", p->name);
            emit(file, "", s, "");
            emit(file, "", "add $a0, $a0, $a1", "");
            sprintf(s, "");
            return;
        } // end if
        
        // global scalar
        fprintf(stderr, "global scalar\n");
        sprintf(s, "la $a0, %s", p->name);
        emit(file, "", s, "#load gobal variable from data segment");
        return;
    } // end if
    
    // the identifier is local
    // check if it is scalar or array
    if (p->symbol->isFunc == 2) {
        // local array
        // get the address
        // get the array index
        emit_expr(p->s1, file);
        // times the word size
        sprintf(s, "sll $a0, $a0, %d", WSIZE / 2);
        emit(file, "", s, "# times the word size");

        // add the offset of the array
        sprintf(s, "add $a0, $a0, %d", p->symbol->offset * WSIZE);
        emit(file, "", s, "#");

        // add in the stack pointer
        emit(file, "", "add $a0, $sp, $a0", "#identifier is a LOCAL ARRAY");
        return;
    } // end if

    // local scalar
    fprintf(stderr, "%s: %d", p->name, p->symbol->offset);
    sprintf(s, "add $a0, $sp, %d", p->symbol->offset * WSIZE);
    emit(file, "", s, "# identifier is a LOCAL SCALAR");
}

//
// pre: a pointer to READSTMT
// post: MIPS code for read
void emit_read(ASTNode * p, FILE * file) {
    emit_identifier(p->s1, file); //$a0 is the address we want to store in
    emit(file, "", "li $v0, 5", "# read a number from input");
    emit(file, "", "syscall", "# reading a number from input");
    emit(file, "", "sw $v0, ($a0)", "#store the read value into a mem location");

    // we know $v0 has the value read in
    emit(file, "", "", "");
}

//pre: a pointer to ASSIGNSTMT node
void emit_assignment(ASTNode * p, FILE * file) {
    if (p == NULL) return;
    if (file == NULL) return;
    if (p->symbol == NULL) return;
    if (p->type != ASSIGNSTMT) return;;

    char s[100];
    // getting the address of the left hand side in $a0
    emit_identifier(p->s1, file);
    sprintf(s, "sw $a0, %d($sp)", p->symbol->offset * WSIZE);
    emit(file, "", s, "");

    // calculate right hand side
    emit_expr(p->s2, file);
    emit(file, "", "move $a1, $a0", "");

    // move the address of LHS back to $a0
    sprintf(s, "lw $a0, %d($sp)", p->symbol->offset * WSIZE);
    emit(file, "", s, "");

    // assigning
    emit(file, "", "sw $a1, ($a0)", "");
}

// pre: a pointer to ARGUE node, expect $sp to contain the value of the upcoming stack
// post: MIPS code to save the argument
void emit_arguments(ASTNode * fparam, ASTNode * p, FILE * file) {
    if (fparam == NULL) return;
    if (file == NULL) return;
    if (p == NULL) return;
    if (p->symbol == NULL) return;

    // is a arugement node and file is not null
    // save the argument
    emit_expr(p->s1, file);
    char s[100];
    fprintf(stderr, "Offset %d", p->symbol->offset);
    sprintf(s, "sw $a0, %d($t5)", fparam->symbol->offset * WSIZE);
    emit(file, "", s, "# Store the parameter to stack");

    emit_arguments(fparam->next, p->next, file);
}

 void emit_iter(ASTNode * p, FILE * file) {
    if (p == NULL) return;
    if (file == NULL) return;
    if (p->type != ITERSTMT) return;

    char s[100];
    char * start = genlabel();
    char * end = genlabel();
    emit(file, start, "", "#WHILE TOP TARGET");
    // checking the condition

    emit_expr(p->s1, file);

    sprintf(s, "beq $a0, 0, %s", end);
    emit(file, "", s, "");

    //
    emit_compound(p->s2, file);

    // jump back
    sprintf(s, "j %s", start);
    emit(file, "", s, "");
    emit(file, end, "", "#");
 }

 void emit_compound(ASTNode * p, FILE * file) {
    if (p == NULL) return;
    if (file == NULL) return;
    if (p->type != COMPSTMT) return;

    EMITAST(p->s2, file);
 }

 void emit_selection(ASTNode * p, FILE * file) {
    if (p == NULL) return;
    if (file == NULL) return;
    if (p->type != IFSTMT) return;

    char s[100];
    char * end = genlabel();

    // checking the condition
    emit_expr(p->s1, file);
    
    sprintf(s, "beq $a0, 0, %s", end);
    emit(file, "", s, "");
    EMITAST(p->s2->s1, file);

    if (p->s1->s2 != NULL) {
        char * end2 = genlabel();
        sprintf(s, "j %s", end2);
        emit(file, "", s, "");
        emit(file, end, "", "# exit");
        EMITAST(p->s2->s2, file);
        emit(file, end2, "", "");
    }
    else {
        emit(file, end, "", "# exit");
    }
 }