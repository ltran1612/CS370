/*
    file name: symtable.c
	Description: A program that we can insert into, display, delte, a symbol table with attributes symbol, and addr. The table is implemented as a linked list. 
	
	Code pulled from http://forgetcode.com/C/101-Symbol-table
	
	modifier: Long Tran
	February 25, 2020
	
	Changes:
		+ Add comments
		+ Indent the code
		+ Move the functions prototoypes, struct SymbTab definition, and the old preprocessors to a header file.
        + Add an include preprocessor to include the header file.
        + Changed Insert, Search, and Display
        + Delete Modify.
*/

// include the header file
#include "symtable.h"

// the number of symbol entries
int size=0;

// the pointer to the first and last entry of the symbol table, the entries will be stored in a linked list
struct SymbTab *first = NULL,*last = NULL;

// void main()
// {
//        printf("search returns %d\n", Search("myfirst"));
//        Insert("myfirst", 0);
//        Insert("mysecond", 1);
//        Insert("mythird", 2);
//        printf("search returns %d\n", Search("myfirst"));
//        Display();
// }  /* and of main */

// insert an entry with a symbol and offset into the table
void Insert(char * symbol, int offset)
{
    // create a newentry with the values from the parameters
    struct SymbTab * newentry = (struct SymbTab *) malloc(sizeof(struct SymbTab));
    newentry->symbol = strdup(symbol);
    newentry->addr = offset;
    newentry->next = NULL;
    
    // insert the newentry into the table
    // if no entry has been inserted, first and last will both point to the newentry
    // else, the last entry next will point to the newentry, and last will point to this new entry.
    if (first == NULL) 
    {
        first = last = newentry;  
    } // end if
    else 
    {
        last->next = newentry;
        last = last->next;
    } // end else
    
    // increase the size of the table
    size++;
} // end Insert

// displaying the entries in the symbol table
// used for testing
void Display()
{
    // a pointer cursor
    // set it to the first entry
    struct SymbTab *p;
    p=first; 
    
    // print the attributes that the table have
    printf("\n\tSYMBOL\t\tADDRES\n");
    
    // go through every entry in the table and print out its symbol, and address in a specific format.
    int i;
    for(i=0;i<size;i++)
    {
        //print the content of the entry p is pointing to
        printf("\t%s\t\t%d\n", p->symbol, p->addr);
        
        //go to the next entry
        p=p->next;
    } // end for
} // end Display

// search in the table for an entry with the symbol in the parameter and return 1 if found, 0 if not found
int Search(char * symbol)
{
    // a pointer to the entry we are checking
    struct SymbTab *p;
    
    // start searching by going through the linked list
    // if we have found an entry with the given symbol, return 1
    for (p = first; p != NULL; p = p->next) 
    {
        if (strcmp(p->symbol, symbol) == 0)
            return 1;
    } // end for loop
    
    // after traveling through the entire table.
    // return 0 because we could not find an entry with the given symbol
    return 0;
} // end Search


// get the address of the entry with the given symbol
int FetchAddress(char * symbol) 
{
    // a pointer to an entry in the table, used to travel through the linked list.
    struct SymbTab * p;
    for (p = first; p != NULL; p = p->next)
    {
        // an entry with the given symbol has been found
        if (strcmp(p->symbol, symbol) == 0)
            return p->addr;
    } /// end for loop
    
    // an entry with the given symbol has not been found
    return -1;
} // end FetchAddress

// delete an entry in a symbol entry with the given symbol 
void Delete(char * symbol)
{
    // prev is the the pointer to the entry previous to the entry pointed by cur pointer. cur is used to check for the entry with the given symbol, and prev is used for deleting.
    // travel through the linked list
    struct SymbTab * prev = NULL, * cur = NULL;
    for (cur = first; cur != NULL; prev = cur, cur = cur->next) {
        // if the entry that cur is pointing to has the same symbol as the given symbol, do the thing in the if
        // else, go to the next entry to check
        if (strcmp(cur->symbol, symbol) == 0) 
        {
            // if the found entry is the first one, first will be the next entry to the found entry
            // else the next entry of the previous entry of the found entry will be the next entry of the found entry.
            // a->b->c (b is the found entry) become a->c
            // if the found entry is the last one, then last will also point to the prev entry
            if (cur == first)
                first = cur->next;
            else { 
                    prev->next = cur->next;
                    if (cur == last)
                        last = prev;
            } // end else
            
            // decrease the size of the table
            size--;
        } // end if
    } // end for 
} // end Delete

