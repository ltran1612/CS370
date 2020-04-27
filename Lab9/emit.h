#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#ifndef EMIT_H
#define EMIT_H

#include "AST.h"
#include "symtable.h"
#define WSIZE 4  // number of bytes in a word
#define LOGWSIZE 2  // number of shifts to get to WSIZE

char * genlabel();

//void EMITSTRINGS(ASTnode * p);
//void EMITGLOBALS(ASTnode * p);
void EMITAST(ASTNode * p, FILE * file);
void EMITSTRINGS(ASTNode * p, FILE * file);
void EMITGLOBAL(ASTNode * p, FILE * file);
#endif  // of EMIT.h
