/*
    emit.h - header file for emit.c, containing functions that will be used in main in lab9.y like EMITSTRINGS and some important constatns like WSIZE
    Author: Long Tran
    Date: May 8th, 2020
*/

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#ifndef EMIT_H
#define EMIT_H

#include "AST.h"
#include "symtable.h"
#define WSIZE 4  // number of bytes in a word
#define LOGWSIZE 2  // number of shifts to get to WSIZE

// EMIT asm code for statements and functions declaration in ALGOL-C
// PRE: a pointer to a node of a statement
// POST: asm code for statements
void EMITAST(ASTNode * p, FILE * file);

// Method to genearte asm code for strings used in the code
// Pre: A pointer to the root of the AST Node tree after parsing
// Post: Print out the asm code that define a string in the .data section
void EMITSTRINGS(ASTNode * p, FILE * file);

// Method to genearte asm code for global variables used in the code
// Pre: A pointer to the root of the AST Node tree after parsing
// Post: Print out the asm code that define global variables in the .data section
void EMITGLOBAL(ASTNode * p, FILE * file);

// the function will generate a label with increasing number
char * genlabel();

// check if the program has a main function
// pre: a node to a AST tree
// post: return 1 if there is a main function, else 0.
int findMain(ASTNode * p);
#endif  // of EMIT.h
