/*
    file name: symtable.h
    Description: the header file for symtable.c, containing the prototypes for functions: Insert, Display, Delete, Search, and Modify, and the definition for struct SymbTab. symtable.c is a program that we can insert into, display, delte, modify a table of rows (called tab) with attributes label, symbol, and address. The table is implemented as a linked list. We can only insert tabs with distinct names
    Long Tran
    February 10, 2020
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
    
    // insert a tab with distinct label into the table
    void Insert();
    
    // displaying the tabs in the symbol table
    void Display();
    
    // delete a tab in a symbol table with the requested label from the user. Finding the need-to-be-deleted tab by checking the first tab, the last tab, then the middle tabs
    void Delete();
    
    // search in the table for a tab with the label in the parameter and return 1 if found, 0 if not found
    int Search(char lab[]);
    
    // modify every tab in the symbol table with the requested lable name fromt the user. this function can modify label and/or symbol and address
    void Modify();

    // SymbTab struct definition
    struct SymbTab
    {
        char label[10],symbol[10]; // two strings for label and symbol
        int addr; // the address
        struct SymbTab *next; // a pointer to another SymbTab object
    }; // end Symbtab definition
    
#endif // of SYMTAB_H
