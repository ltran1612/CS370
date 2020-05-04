/*
    emit.c 
    Define functions to emit asm codes for the ALGOL-C language.
    Author: Long Tran
    Date: May 8th, 2020
*/

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "AST.h"
#include "emit.h"

// label for genlabel
static int GLABEL = 0;

// the current function that is being observed
char * CURR_FUNCTION;

// functions prototypes
void emit(FILE * file, char * label, char * command, char * comment);
void emit_function_return(ASTNode * value, FILE * file);
void emit_function_head(ASTNode * p, FILE * file);
void emit_expr(ASTNode * p, FILE * file);
void emit_write(ASTNode * p, FILE * file);
void emit_read(ASTNode * p, FILE * file);
void emit_identifier(ASTNode * p, FILE * file);
void emit_assignment(ASTNode * p, FILE * file);
void emit_iter(ASTNode * p, FILE * file);
void emit_compound(ASTNode * p, FILE * file);
void emit_selection(ASTNode * p, FILE * file);
void emit_call(ASTNode * p, FILE * file);

// Method to genearte asm code for strings used in the code
// Pre: A pointer to the root of the AST Node tree after parsing
// Post: Print out the asm code that define a string in the .data section
void EMITSTRINGS(ASTNode * p, FILE * file)
{
    // error cases
    if (file == NULL) {
        fprintf(stderr, "EMITSTRINGS file is null\n");
        return;
    } // end if

    // base case;
    if (p == NULL) return;

   // if there is a write statement that use strings, put it in data
    if ((p->type == WRITESTMT) && (p->name != NULL)) {
        char command[100];
        sprintf(command, ".asciiz\t%s", p->name);
        emit(file, p->label, command, "# global string");
    } // end if

    // go to other parts of the tree
    EMITSTRINGS(p->next, file);
    EMITSTRINGS(p->s1, file);
    EMITSTRINGS(p->s2, file);
} // end EMITSTRINGS

// Method to genearte asm code for global variables used in the code
// Pre: A pointer to the root of the AST Node tree after parsing
// Post: Print out the asm code that define global variables in the .data section
void EMITGLOBAL(ASTNode * p, FILE * file) {
    // error case
    if (file == NULL) {
        fprintf(stderr, "EMITGLOBAL file is null\n");
        return;
    } // end if

    // base case
    if (p == NULL) return;

    // p is not null and file is not null
    char s[100];
    // if it is a vardec and it is a global variable
    if (p->type == VARDEC && p->symbol->level == 0) {
        sprintf(s, ".space %d", p->value * WSIZE);
        emit(file, p->name, s, "# define a global variable");
    } // end if

    // go to other node
    EMITGLOBAL(p->next, file);
    EMITGLOBAL(p->s1, file);
    EMITGLOBAL(p->s2, file);
} // end EMITGLOBAL

// the function will generate a label with increasing number
char * genlabel()
{
    char s[100];
    char * s1;
    sprintf(s, "_L%d", GLABEL++);
    s1 = strdup(s); // want to transfer the string to heap
    return s1;
} // end genlabel

// EMIT asm code for statements and functions declaration in ALGOL-C
// PRE: a pointer to a node of a statement
// POST: asm code for statements
void EMITAST(ASTNode *p, FILE * file) {
    // NULL we will not print anything because it is emy 
    if (p == NULL) return;
    if (file == NULL) return;
       
    // for each type of node type, print its content
    switch (p->type) {
        // var dec - not important - because it does nothing.
        case VARDEC:
            // pass by var dec because var dec has already been defined in EMITGLOBAL
            break;
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
            // emit compound statement
            emit_compound(p, file); 
            break; // of COMPSTMT
        } // end compound statement
        
        // iteration statement
        case ITERSTMT:
        {
            // emit iteration statement
            emit_iter(p, file);   
            break; // of ITRSTMT
        } // end iteration statement
            
        // selection statement
        // the expression of if statement
        case IFSTMT: // if /
        {   
            // emit if or if-else statement
            emit_selection(p, file);
            break;  // of IFSTMT
        } // end if 
        
        // then and/or else statement
        // assign statement
        case ASSIGNSTMT:
        {
            // emit assignment statement
            emit_assignment(p, file);
            break; // of ASSIGNSTMT
        } // end assignment statement
            
        // return statement
        case RETURNSTMT:
        {
            // emit return statement
			emit_function_return(p, file);
            break; // of RETURNSTMT
        } // end return statement
        
        // read statement
        case READSTMT:
        {    
            // emit read statement
            emit_read(p, file);
            break; // of READSTMT
        } // end read statement
            
        // write statement
        case WRITESTMT:
        {
            // emit write statement   
            emit_write(p, file);
            break; // of WRITESTMT
        } // end write statement
			
		case EXPRSTMT:
        {   
            // emit expression statement
            emit_expr(p->s1, file);
			break; // of EXPRSTMT
        } // end expression statement
		
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

// check if the program has a main function
// pre: a node to a AST tree
// post: return 1 if there is a main function, else 0.
int findMain(ASTNode * p) {
    // base case
    if (p == NULL) return 0;
    // base case - found main
    if (p->type == FUNDEC && strcmp(p->name, "main") == 0) return 1;
    
    // check the next one
    return findMain(p->next);
} // end findMain


// helper functions to make clean MIPS code
// Take in 4 params, and print them out pretty
// Pre: given 3 strings, print them out in Assembling formatting
// in FP
// example emit(fp, "L1", "ldi R13, 15", "#Load a number")
void emit(FILE * file, char * label, char * command, char * comment) {

    // error case
    if (file == NULL) { 
        fprintf(stderr, "NULL file\n");
        return;
    }// end if


    // if this guys has a label
    if (label == NULL || strcmp(label, "") == 0) {
        fprintf(file, "\t\t%s\t\t%s\n", command, comment);
    } // end if
    else { // does not have a label
        fprintf(file, "%s:\t\t%s\t\t%s\n", label, command, comment);
    } // end else
} // end emit

// emit the initialization of a function
// pre: ptr to fundec
// post header code in MIPS written to file
void emit_function_head(ASTNode * p, FILE * file) 
{
    // erro cases
    if (p == NULL) return;
    if (file == NULL) return;


    char s[100];
    emit(file, p->name, "", "# start of FUNCTION");

    // set the global function variable
    CURR_FUNCTION = p->name;

    // build the start pointer movement
    sprintf(s, "subu $a0, $sp, %d", (p->symbol->size) * WSIZE);
    emit(file, "", s, "# adjust the stack for function set up");
    emit(file, "", "sw $sp, ($a0)", "# store the stack pointer");
    emit(file, "", "sw $ra, 4($a0)", "# store the return address");
    emit(file, "", "move $sp, $a0", "# adjust the stack pointer");
    emit(file, "", "", ""); // make a space
} // end emit_function_head

// method to handle explicit and implicit function returns;
// pre pointer to RETURN or NULL
// POST RETURN CODE in MIPS printed in fp the return value is in $a0
void emit_function_return(ASTNode * p, FILE * file){
    // error case
    if (file == NULL) return;

   
    // if this is an explicit return statement
    if (p != NULL)
    {
        emit(file, "", "", "# return statement");
        // we need to evaluate the expression
        emit_expr(p->s1, file); // this leaves $a0 the result
    } // end if

    // if it is null we do nothing with $a0
    
    // we have to do thing differently if it is main
    if (strcmp(CURR_FUNCTION, "main") == 0) {
        // restore RA and SP
        emit(file, "", "", ""); // make space
        emit(file, "", "lw $ra, 4($sp)", "# Restore RA");
        emit(file, "", "lw $sp, ($sp)", "# Restore SP");
        emit(file, "", "", ""); // make space

        // handle main return
        emit(file, "", "li $v0, 10", "# leave main program");
        emit(file, "", "syscall", "# leave main");
    } // end if
    else {
        // restore RA and SP
        emit(file, "", "", ""); // make space
        emit(file, "", "lw $ra, 4($sp)", "# Restore RA");
        emit(file, "", "lw $sp, ($sp)", "# Restore SP");

        // jump back to the caller
        emit(file, "", "jr $ra", "# Jump back to the caller");
        emit(file, "", "", ""); // make space
    } // end else
} // end emit_function_return

// method do write statement
// pre: pointer to WRITESTMT
// POST return code to print string or print expression
void emit_write(ASTNode * p, FILE * file) {
    // error cases
    if (p == NULL) return;
    if (file == NULL) return;
    
    emit(file, "", "", "# write statement");
    // check if the write statement is for string
    if (p->name != NULL) {
        // set the mode for printing string
        emit(file, "", "li $v0, 4", "#print a string");

        // get the locaiton of string
        char command[100];
        sprintf(command, "la $a0, %s", p->label);
        emit(file, "", command, "# fetch string location");
    } // end if
    else {
        // calculate the expression of write statement
        emit_expr(p->s1, file);
        // set the mode for printing number
        emit(file, "", "li $v0, 1", "# print a number");
    } // end else

    // start syscall
    emit(file, "", "syscall", "");

    // print new line
    emit(file, "", "li $v0, 4", "#print a newline");
    emit(file, "", "la $a0, _NL", "");
    emit(file, "", "syscall", "");
} // end emit_write

/*
    emit_expr
    PRE: a pointer to an expression as defined in YACC language
    POST: MIPS code that sets $a0 to the value of expr
*/
void emit_expr(ASTNode * p, FILE * file) {
    // error cases
    if (p == NULL) return;
    if (file == NULL) return;

    char s[100];
    // base cases
    switch(p->type) {
        case EXPR:
            // if it an expression, do nothing because it will be handled later after the switch
            break;
        case NUMBER:
            // if it is an integer 
            // else it is a boolean
            if (p->sem_type == INTTYPE) {
                // get the value of NUMBER
                sprintf(s, "li $a0, %d", p->value);
                emit(file, "", s, "# expression is a NUMBER");
            } // end if
            else if (p->value) { // if boolean value is 1, it is true
                emit(file, "", "li $a0, 1", "# expression is a TRUE");
            }  // end else if 
            else { // if boolean value is 0, it is false
                 emit(file, "", "li $a0, 0", "# expression is a FALSE");
            } // end else

            return;
            break;
        case IDENT:
            // get the address of the identifier
            emit_identifier(p, file);

            // if it is the address of an array, exit cause that's all we need.
            if (checkPointer(p)) return;

            // if it is a scalar, or an array with index, we get the value stored in $a0
            emit(file, "", "lw $a0, ($a0)", "#fetch value from the location stored at $a0");

            return;
            break;
        case FUNCALL:
            // emit function call
            emit_call(p, file);
            return;
            break;
        default:
            return;
            break;
    } // end switch

    // with two operands expression
    // $a0 will store left hand side, $a1 will store the result of right hand side.
    // with one operand expression
    // $a0 will be the operand

    // evaluate the left hand side
    emit_expr(p->s1, file);

    // if it is an expression with two operands
    if (p->symbol != NULL) {
        // store the result in a temporary of expression in p->symbol->offset
        sprintf(s, "sw $a0, %d($sp)", p->symbol->offset * WSIZE);
        emit(file, "", s, "# store the value of left hand side");

        // evaluate the right hand side
        emit_expr(p->s2, file);
        // store the result in a1 for later use
        emit(file, "", "move $a1, $a0", "# store the value of right hand side");

        // retrieve the result of the left hand side
        sprintf(s, "lw $a0, %d($sp)", p->symbol->offset * WSIZE);
        emit(file, "", s, "# retrieve the result of left hand side");
    } // end if

    // perform calculations of the expression
    switch(p->operator) {
        case PLUS:
            emit(file, "", "add $a0, $a0, $a1", "# LHS + RHS");
            break;
        case MINUS:
            emit(file, "", "sub $a0, $a0, $a1", "# LHS - RHS");
            break;
        case TIMES:
            emit(file, "", "mult $a0, $a1", "# LHS * RHS");
            emit(file, "", "mflo $a0", "# retrieve the result of multiplication");
            break;
        case DIV:
            emit(file, "", "div $a0, $a1", "# LHS / RHS");
            emit(file, "", "mflo $a0", "# retrieve the quotient of the division");
            break;
        case ANDBW:
            emit(file, "", "and $a0, $a0, $a1", "# LHS and RHS");
            break;
        case ORBW:
            emit(file, "", "or $a0, $a0, $a1", "# LHS or RHS");
            break;
        case LESS:
            emit(file, "", "slt $a0, $a0, $a1", "# LHS < RHS");
            break;
        case LESSE:
            // check less than
            emit(file, "", "slt $t0, $a0, $a1", "# LHS <= RHS");

            // check equal
            emit(file, "", "seq $t1, $a0, $a1", "# check if the two operands are equal");

            // either less than or equal is good
            emit(file, "", "or $a0, $t0, $t1", "# either less than or equal");
            break;
        case GREAT:
            emit(file, "", "slt $a0, $a1, $a0", "# LHS > RHS");
            break;
        case GREATE:
            // check greater than
            emit(file, "", "slt $t0, $a1, $a0", "# LHS > RHS");

            // check equal
            emit(file, "", "seq $t1, $a0, $a1", "# check if the two operands are equal");

            // either greater than or equal is good
            emit(file, "", "or $a0, $t0, $t1", "# either greater than or equal");
            break;
        case EQUAL:
            // set if equal
            emit(file, "", "seq $a0, $a0, $a1", "# check if the two operands are equal");
            break;
        case NEQUAL:
            // set if it is not equal
            emit(file, "", "sne $a0, $a0, $a1", "# check if the two operands are not equal");
            break;
        case NOTOP:
            emit(file, "", "sltiu $a0, $a0, 1", "# check if the expression is 0 -> set to 1. else -> set to 0");
            break;
        default:
            break;
    } // end switch
} // end emit_expr

// emit_identifier
// PRE: p is a PTR to a identifier node
// POST: MIPS code such that $ao is the ADDRESS of where IDENT is in memory
void emit_identifier(ASTNode * p, FILE * file) {
    // error cases
    if (file == NULL) return;
    if (p == NULL) return;
    if (p->type != IDENT) return;

    char s[100];
    // check if the identifier is global identifier
    if (p->symbol->level == 0) {

        // check if the identifier is an array but not an array address.
        if (p->symbol->isFunc == 2 && p->value != 3) {
            // global array
            // get the index
            emit_expr(p->s1, file);
            // times the word size
            sprintf(s, "sll $a0, $a0, %d", WSIZE / 2);
            emit(file, "", s, "# times the word size");
            
            // load the address of the global array
            sprintf(s, "la $a1, %s", p->name);
            emit(file, "", s, "# load the address of the GLOBAL ARRAY");

            // add in the index
            emit(file, "", "add $a0, $a0, $a1", "# add the index in the address of GLOBAL ARRAY");
            return;
        } // end if
        
        // global scalar
        // get the address of the identifier
        sprintf(s, "la $a0, %s", p->name);
        emit(file, "", s, "# load the address of GLOBAL VAR");
        return;
    } // end if
    
    // the identifier is local
    // check if the identifier is a local array but not an array pointer
    if (p->symbol->isFunc != 0 && p->value != 3) {
        // local array
        // calculate the index
        emit_expr(p->s1, file);
        // times the word size
        sprintf(s, "sll $a0, $a0, %d", WSIZE / 2);
        emit(file, "", s, "# times the word size");

        // check if the identifier is a array parameter
        if (p->symbol->isFunc == 3) {
            // get the address of the array parameter
            sprintf(s, "add $a1, $sp, %d", p->symbol->offset * WSIZE);
            emit(file, "", s, "# get the address of ARRAY PARAMETER");

            // load the true address of the arary passed to this paramter
            emit(file, "", "lw $a1, ($a1)", "# get the address of the array passed to this ARRAY PARAMETER");
            
            // add in the index
            emit(file, "", "add $a0, $a1, $a0", "# add in the index to the address of teh array");
        } // end if
        else { // this is a normal local array
            // calculate the sum of the offset from the stack pointer of the current activation record and the index 
            sprintf(s, "add $a0, $a0, %d", p->symbol->offset * WSIZE);
            emit(file, "", s, "# add the offset from sp with the index of the array");

            // find the address in the activation record from the calculated sum
            emit(file, "", "add $a0, $sp, $a0", "# get the address with index of LOCAL ARRAY");
        } // end else

        return;
    } // end if

    // local scalar or an array address
    // find the address of the local scalar
    sprintf(s, "add $a0, $sp, %d", p->symbol->offset * WSIZE);
    emit(file, "", s, "# get the address of LOCAL VAR");

    // check if we are looking for the true address passed to an array parameter.
    if (p->symbol->isFunc == 3) {
        // fetch the true value from the paratmer. 
        emit(file, "", "lw $a0, ($a0)", "# get the address of array passed to ARRAY PARAMETER");
    } // end if
} // end emit_identifier

// method handle read statement
// pre: a pointer to READSTMT
// post: MIPS code for read statement
void emit_read(ASTNode * p, FILE * file) {
    emit(file, "", "", "# read statement");
    // find the address of the identifer
    emit_identifier(p->s1, file); 

    // prompting for input.
    emit(file, "", "li $v0, 5", "# read a number from input");
    emit(file, "", "syscall", "# reading a number from input");

    // storing the input to the identifier.
    // we know $v0 has the value read in
    emit(file, "", "sw $v0, ($a0)", "# store the read value into a mem location");
} // end emit_read

// method to handle assignment statement
//pre: a pointer to ASSIGNSTMT node
//post: MIPS code for assignment statement
void emit_assignment(ASTNode * p, FILE * file) {
    // error cases
    if (p == NULL) return;
    if (file == NULL) return;
    if (p->symbol == NULL) return;
    if (p->type != ASSIGNSTMT) return;;

    emit(file, "", "", "# assignment statement");
    char s[100];
    // getting the address of the left hand side in $a0
    emit_identifier(p->s1, file);

    // storing the address to the temporary space
    sprintf(s, "sw $a0, %d($sp)", p->symbol->offset * WSIZE);
    emit(file, "", s, "# storing the address of LHS to temporary space");

    // calculate right hand side
    emit_expr(p->s2, file);

    // storing the result to the $a1
    emit(file, "", "move $a1, $a0", "# store the value of RHS to $a1");

    // move the address of LHS back to $a0
    sprintf(s, "lw $a0, %d($sp)", p->symbol->offset * WSIZE);
    emit(file, "", s, "# retrieve the value of LHS back to LHS");

    // assigning the result from the RHS to the address in the left hand side.
    emit(file, "", "sw $a1, ($a0)", "# assign the RHS to LHS");
} // end emit_arguments

// method to handle function call
// pre: a pointer to FUNCALL.
// post: MIPS code to call function
void emit_call(ASTNode * p, FILE * file) {
    // error cases
    if (p == NULL) return;
    if (file == NULL) return;

    emit(file, "", "", "# fun call");
    char s[100];
    // calculate the arguments, store it in temporary space
    ASTNode * arg;
    for (arg = p->s1; arg != NULL; arg = arg->next)
    {   
        // find the expression
        emit_expr(arg->s1, file);

        if (p->symbol == NULL) {
            fprintf(stderr, "argument does not have a temporary space\n");
            exit(1);
        } // end if
        
        // store it in temporary space
        sprintf(s, "sw $a0, %d($sp)", arg->symbol->offset * WSIZE);
        emit(file, "", s, "# store the calculated argument value in temporary space");
    } // end for arg

    // store the argument into real location
    int offset;
    // get the future stack pointer of the about-to-be-called function
    sprintf(s, "subu $t5, $sp, %d", p->symbol->size * WSIZE);
    emit(file, "", s, "# calculate the future stack pointer after we call the function");

    // store the arguments from temporary space to real location
    for (arg = p->s1, offset = 2; arg != NULL; arg = arg->next, offset++)
    {   
        // load it back from the temporary space
        sprintf(s, "lw $a0, %d($sp)", arg->symbol->offset * WSIZE);
        emit(file, "", s, "# load the argument value back from the temporary space");

        // store it in the wanted location
        sprintf(s, "sw $a0, %d($t5)", offset * WSIZE);
        emit(file, "", s, "# store it in the wanted location of the calling function");
    } // end for arg

    // call the function
    sprintf(s, "jal %s", p->name);
    emit(file, "", s, "# call the function");
} // end emit_call

// method to handle iteration statement
// pre: a pointer to ITERSTMT
// post: MIPS code to do while statement
void emit_iter(ASTNode * p, FILE * file) {
    // error cases
    if (p == NULL) return;
    if (file == NULL) return;
    if (p->type != ITERSTMT) return;

    emit(file, "", "", "# iteration statement");
    char s[100];
    // generate two labels for two labels of the start and end of the while statement
    char * start = genlabel();
    char * end = genlabel();

    // the label at the start of the while statement
    emit(file, start, "", "#WHILE TOP TARGET");

    // checking the condition
    // calcualte the expression
    emit_expr(p->s1, file);
    // check the expression, if it is 0 -> false -> exit.
    emit(file, "", "li $t6, 0", "# load zero value for comparison");
    sprintf(s, "beq $a0, $t6, %s", end);
    emit(file, "", s, "# checking the condition of while statement, exit if the expression is 0 (false)");

    // emit the statement of the while statement
    EMITAST(p->s2, file);

    // jump back to the beginning of the while statement
    sprintf(s, "j %s", start);
    emit(file, "", s, "# jump back to the top target of while statement");

    // the end of the while statement
    emit(file, end, "", "#WHILE BOTTOM TARGET");
} // end emit iter

// method to handle compound statement
// pre: a pointer to COMPSTMT
// post: MIPS code to do compound statement
void emit_compound(ASTNode * p, FILE * file) {
    // error cases
    if (p == NULL) return;
    if (file == NULL) return;
    if (p->type != COMPSTMT) return;

    emit(file, "", "", "# compound statement");
    // we don't need to emit declaration because it is done at the initialization of the function
    // emit the statemnets in the compound statement
    EMITAST(p->s2, file);
} // end emit_compound

// method to handle selection statement
// pre: a pointer to IFSTMT node
// post: MIPS code to do if else statement
void emit_selection(ASTNode * p, FILE * file) {
     // error cases
    if (p == NULL) return;
    if (file == NULL) return;
    if (p->type != IFSTMT) return;

    emit(file, "", "", "# selection statement");

    char s[100];
    // ending label or the else label
    char * else_part = genlabel();
    char * end = genlabel();

    // calcualte the expression
    emit_expr(p->s1, file);

    // checking the condition
    // if the expression is 0 -> false -> else part (or end part if it does not have end)
    emit(file, "", "li $t6, 0", "# load temporary value for comparison");
    sprintf(s, "beq $a0, $t6, %s", else_part);
    emit(file, "", s, "# go to else part when the if condition is false (0)");
    // emit the statement of if
    EMITAST(p->s2->s1, file);
    // exit the if section when finished
    sprintf(s, "j %s", end);
    emit(file, "", s, "# exit statement when finished");

    // print the label of else section
    emit(file, else_part, "", "# else label");
    // emit the statements of else section   
    EMITAST(p->s2->s2, file);

    // print the lable of the ending of the if statement
    emit(file, end, "", "# end of selection statement");
} // end emit_selection