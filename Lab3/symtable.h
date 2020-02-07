#ifndef SYMTABLE_H
#define SYMTABLE_H

    #include<stdio.h>
    /* #include<conio.h> */
    #include<malloc.h>
    #include<string.h>
    #include<stdlib.h>

    // functions prototypes
    void Insert();
    void Display();
    void Delete();
    int Search(char lab[]);
    void Modify();

    // SymbTab struct definition
    struct SymbTab
    {
        char label[10],symbol[10];
        int addr;
        struct SymbTab *next;
        
    };
    
#endif // of SYMTAB_H
