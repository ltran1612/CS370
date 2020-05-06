/*  Symbol Table --linked list  headers
    Used for Compilers class

    Modified Spring 2015 to allow for name to pointed to by symtable, instead of copied, since the name is copied
    into the heap

    Modified to have levels.  A level 0 means global variable, other levels means in range of the function.  We
    start out our offsets at 0 (from stack pointer) for level 1,,,when we enter a functional declaration.
    We increment offset each time we insert a new variable.  A variable is considered to be valid if it is found in
    the symbol table at our level or lesser level.  If at 0, then it is global.  

    We return a pointer to the symbol table when a variable matches our creteria.

    We add a routine to remove variables at our level and above.
*/

/*
    Modified by Long Tran
    April 17, 2020
    
    Delete undefined functions (FetchAddress), make comments, and fix to fit the other programs.

*/
// change to normal convention of preprocesor wrapper
#ifndef  SYMTABLE_H
#define  SYMTABLE_H

// include to have access to ASTNode for fparams
#include "AST.h"

// the struct definition of SymbTab
// Change the name to better suit my style
struct SymbTab
{
     char *name;
     int offset; /* from activation record boundary */
     int size;  /* number of words this item is 1 or more */
     int level;  /* the level where we found the variable */
     enum OPERATORS type;  /* the type of the symbol */
     int isFunc;  /* the element is a function */
     ASTNode * fparms; /* pointer to parameters of the function in the AST */

    // pointer to the next entry in the table
     struct SymbTab *next;
}; // end SymbTab struct definition

// functions
/* Simple Insert into the symbol table with the size, type level that the name is being inserted into */
// pre: name, type, a function or not, the level of the definition, its size, the offset value, and its parametern (if any).
// post: a symbtab initialized with those values
struct SymbTab * Insert(char * name, enum OPERATORS type, int isFunc, int level, int mysize, int offset, ASTNode * fparms );

/*  Search for a symbol name at level or below.  We have to do multiple passes into the symbol table because we have to find
   the name closest to us 
    If recur is non-zero, then we look through all of the levels, otherwise, only our level 
    We return a pointer to a SymbolTab structure so that we can use other functions/methods to get the attributes */
// pre: the name, level, and if we want to search recursively (search all level)
// post: the symbtab entry with that name, or null if there are not any.
struct SymbTab * Search(char * name, int level, int recur);

/*  General display to see what is our symbol table */
// pre: nothing
// post: Print out the symbol table
void Display();

/* Remove all enteries that have the indicated level
   We need to take care about updating first pointer into the linked list when we are deleting edge elements */
// pre: the level of all of the symbtab entries I want to delete
// post: have all symbtab entries with the input level deleted.
int Delete();

// Create a temporary space for assignment, all expressions, and function arguments.
// pre: nothing
// post: the name of the new temporary space.
char * CreateTemp();
#endif // of SYMTABLE_H
