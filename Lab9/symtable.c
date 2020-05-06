/*  Symbol Table --linked list
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
  Symbol Table
  Modifed by Long Tran
  Date: April 17th, 2020

  Changed Display and PrintSym to print more fields of SymbTab
*/

#include <string.h>
#include <stdio.h>
#include <stdlib.h>

#include "symtable.h"
#include "AST.h"

// the node pointing to the start of the LinkedList or symbol table.
struct SymbTab * first = NULL;

// the number temporary values has created, used for creating name for temporary space.
int GTEMP = 0;

// Create a temporary space for assignment, all expressions, and function arguments.
// pre: nothing
// post: the name of the new temporary space.
char * CreateTemp()
{  
  char hold[100];
  char *s;
  sprintf(hold, "_t%d", GTEMP++);
  s = strdup(hold);
  return (s);
} // end CreateTemp

/* Simple Insert into the symbol table with the size, type level that the name is being inserted into */
// pre: name, type, a function or not, the level of the definition, its size, the offset value, and its parametern (if any).
// post: a symbtab initialized with those values
struct SymbTab * Insert(char *name, enum OPERATORS type, int isFunc, int  level, int size, int offset , ASTNode * fparms)
{
  struct SymbTab * n;
  n=Search(name,level, 0);
  if(n!=NULL)
  {
  fprintf(stderr, "\n\tThe name %s exists at level %d already in the symbol table\n\tDuplicate can.t be inserted",name, level);
  return (NULL);
  } // end if
  else
  {
    struct SymbTab *p;
    p = malloc(sizeof(struct SymbTab));
    p->name = name;
    p->offset = offset;  /* assign the offset */
    p->level = level;  /* assign the level */
    p->size = size;  /* assign the size */
    p->type = type;  /* assign the Type */
    p->isFunc = isFunc;  /* assign the Function  */
    p->fparms = fparms;  /* assign the Function  */
    p->next = NULL;

  /* Check on how many elements we have in the symbol table */
    if(first==NULL)
    {
      first=p;
    } // end if
    else
    {
      p->next=first;
      first=p;
    } // end else

    // return a pointer to the SymbTab of a newly created SymbTab
    return (p);
  } // end else

  // something has been inserted
  printf("\n\tLabel inserted\n");
} // end insert

/* print out a single symbol table entry -- for debugging */
// pre: a symbtab entry
// post: print out the name, offset, level, typ, size, isFunc of that entry
void PrintSym(struct SymbTab *s)
{
  // print name, offset, and level
  fprintf(stderr, "\t%s\t\t%d\t\t%d\t\t",s->name,s->offset, s->level);

  // print the data type
  printOperator(s->type);

  // print the size and isFunc
  fprintf(stderr, "\t\t%d\t\t%d\n", s->size, s->isFunc);
} // end PrintSym

/*  General display to see what is our symbol table */
// pre: nothing
// post: Print out the symbol table
void Display()
{
  // the types of field
  fprintf(stderr, "\n\tLABEL\t\tOffset\t\tLEVEL\t\tTYPE\t\tSIZE\t\tISFUNC\n");

    // print the table
  struct SymbTab *p;
  p=first;
  while (p!=NULL)
  {
      PrintSym(p);
      p=p->next;
  } // end while
} // end Display

/*  Search for a symbol name at level or below.  We have to do multiple passes into the symbol table because we have to find
   the name closest to us 
    If recur is non-zero, then we look through all of the levels, otherwise, only our level 
    We return a pointer to a SymbolTab structure so that we can use other functions/methods to get the attributes */
// pre: the name, level, and if we want to search recursively (search all level)
// post: the symbtab entry with that name, or null if there are not any.
struct SymbTab * Search(char * name, int level, int recur)
{
   int i,flag=0;
   struct SymbTab *p;

  /* for each level, try to find our symbol */
   while (level >= 0)
    {
       p=first;
       while (p!=NULL)
        {
         if((strcmp(p->name,name)==0) && (p->level == level))
           return p;
         p=p->next;
        } // end while
       if (recur == 0) return (NULL);   /* we did not find it at our level */
       level--; /* check the next level up */
    } // end while

   return  NULL;  /* did not find it, return 0 */
} // end Search

/* Remove all enteries that have the indicated level
   We need to take care about updating first pointer into the linked list when we are deleting edge elements */
// pre: the level of all of the symbtab entries I want to delete
// post: have all symbtab entries with the input level deleted.
int Delete(int level)
{
  int SIZE=0;

  /* we follow with pointer f */
  /* cruise through the list */
  for (struct SymbTab *p = first, *f = NULL; p != NULL; p = p->next)
  {
    /* do we match? */
    if (p->level >= level )
    { 
      SIZE += p->size;

      /* if it is the first in the list we have to update first, we know this by f being NULL */
      if (f == NULL) 
      {
        first = p->next;
      } // end if
      else /* not the first element */
      {
        f->next = p->next;
      }  // end else
    } // end if
    else
    {
      /* update follow pointer, move the p pointer */
      f = p;
    } // end else
  } // end while

  return(SIZE);
} // end Delete

// int main()
// {
//        printf("search returns %d\n", Search("myfirst", 0, 0) == NULL);
//        Insert("myfirst", INTTYPE, 0, 0, 1, 0, NULL);
//        Insert("mysecond", INTTYPE, 0, 0, 1, 0, NULL);
//        Insert("mythird", INTTYPE, 0, 0, 1, 0, NULL);
//        printf("search returns %d\n", Search("myfirst", 0, 0) == NULL);
//        Display();
//        printf("%d\n", Delete(0));
// }  /* and of main */
