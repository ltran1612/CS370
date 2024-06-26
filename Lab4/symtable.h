/*
    file name: symtable.h
    Description: the header file for symtable.c, containing the prototypes for functions: Insert, Display, Delete, Search, and Modify, and the definition for struct SymbTab. symtable.c is a program that we can insert or delete an entry in a table with attributes symbol and address or display the table and get the address value of an entry. The table is implemented as a linked list.
    
    the file symtable.c is pulled from http://forgetcode.com/C/101-Symbol-table
    
    Long Tran
    February 21, 2020
*/

// preprocessors wrapper
#ifndef SYMTABLE_H
#define SYMTABLE_H
    
    #include<stdio.h>
    /* #include<conio.h> */
    #include<malloc.h>
    #include<string.h>
    #include<stdlib.h>

    // functions prototypes
    // insert an entry with a symbol and offset into the table
    void Insert(char * symbol, int offset);
    
    // displaying the entries in the symbol table
    void Display();
    
    // delete an entry in a symbol entry with the parameter symbol 
    void Delete(char * symbol);
    
    // search in the table for an entry with the label in the parameter and return 1 if found, 0 if not found
    int Search(char * symbol);
   
    // get the address of the entry with the parameter symbol
    int FetchAddress(char * symbol);

    // SymbTab struct definition for an entry of the table
    struct SymbTab
    {
        char * symbol;
        int addr; // add offset
        struct SymbTab *next; // a pointer to another SymbTab object
    }; // end Symbtab definition
    
#endif // of SYMTAB_H
