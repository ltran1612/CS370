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

#include <string.h>
#include <stdio.h>
#include <stdlib.h>

#include "symtable.h"
#include "AST.h"

int GTEMP = 0;

// 
struct SymbTab * first = NULL;

char * CreateTemp()
{    char hold[100];
     char *s;
     sprintf(hold,"_t%d",GTEMP++);
     s=strdup(hold);
     return (s);
} // end CreateTemp

/* Simple Insert into the symbol table with the size, type level that the name is being inserted into */
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
void PrintSym(struct SymbTab *s)
{
  fprintf(stderr, "\t%s\t\t%d\t\t%d\t\t",s->name,s->offset, s->level);
  printOperator(s->type);
  fprintf(stderr, "\t\t%d\t\t%d", s->size, s->isFunc);
  fprintf(stderr, "\n");
} // end PrintSym

/*  General display to see what is our symbol table */
void Display()
{
  int i;
  struct SymbTab *p;
  p=first;
  printf("\n\tLABEL\t\tOffset\t\tLEVEL\t\tTYPE\t\tSIZE\t\tISFUNC\n");
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
