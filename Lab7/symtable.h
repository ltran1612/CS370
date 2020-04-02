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

    

#include "AST.h"

// change to normal convention
#ifndef  SYMTABLE_H
#define  SYMTABLE_H

int mem=0;


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

     struct SymbTab *next;
}; // end SymbTab struct definition


struct SymbTab * Insert(char *name, enum OPERATORS Type, int isafunc, int  level, int mysize, int offset, ASTNode * fparms );
void Display();
int Delete();
int FetchAddr (char *lab);
#endif
