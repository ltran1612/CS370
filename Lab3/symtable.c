/*
    file name: symtable.c
	Description: A program that we can insert into, display, delte, modify a table of rows (called tab) with attributes label, symbol, and address. The table is implemented as a linked list. We can only insert tabs with distinct names
	
	Code pulled from http://forgetcode.com/C/101-Symbol-table
	
	modifier: Long Tran
	February 10, 2020
	
	Changes:
		+ Add comments
		+ Indent the code
		+ Move the functions prototoypes, struct SymbTab definition, and the old preprocessors to a header file.
        + Add an include preprocessor to include the header file.
*/

// include the header file
#include "symtable.h"

// the number of symbol tabs
int size=0;

// the pointer to the first and last tab of the symbol table, the tabs will be stored in a linked list
struct SymbTab *first = NULL,*last = NULL;

void main()
{
    int op,y;
    char la[10];
    
    do
    {
        // display the options of activities for the table
        printf("\n\tSYMBOL TABLE IMPLEMENTATION\n");
        printf("\n\t1.INSERT\n\t2.DISPLAY\n\t3.DELETE\n\t4.SEARCH\n\t5.MODIFY\n\t6.END\n");
        printf("\n\tEnter your option : ");
        scanf("%d",&op);
        
        // do the options requested by the user
        switch(op)
        {
            // option Insert
            case 1:
            Insert();
            break;
            
            // option Display
            case 2:
            Display();
            break;
            
            // option Delete
            case 3:
            Delete();
            break;
            
            // option search
            case 4:
            // requesting the label to be searched
            printf("\n\tEnter the label to be searched : ");
            scanf("%s",la);
            
            // search the entry with the label in the table
            y=Search(la);
            
            // print the search result
            printf("\n\tSearch Result:");
            
            if(y==1) // if found
                printf("\n\tThe label is present in the symbol table\n");
            else // if not found
                printf("\n\tThe label is not present in the symbol table\n");
            break;
            
            // option Modify
            case 5:
            Modify();
            break;
            
            // option exit
            case 6:
            exit(0);
            
        }  // end switch
    } while(op<6); // end do-while

}  /* and of main */

// insert a tab with distinct label into the table
void Insert()
{
    // the result of the search for a tab with the label of the tab we want to insert
    int n;
    
    // the label of the tab we want to insert
    char l[10];
    
    // ask the user to enter the name of the label
    printf("\n\tEnter the label : ");
    scanf("%s",l);
    
    // write the name of the label
    n=Search(l);
    
    if(n==1) // the entry with that label is found in the table
        printf("\n\tThe label exists already in the symbol table\n\tDuplicate can.t be inserted");
    else // the entry with that label is not found in the table
    {
        // create new table
        struct SymbTab *p;
        
        // dynamically allocate a new location in the memory for SymbTab pointer
        p=malloc(sizeof(struct SymbTab));
        
        // copy the name of the label to the field label in p
        strcpy(p->label,l);
        
        // requesting the symbol of the tab
        printf("\n\tEnter the symbol : ");
        scanf("%s",p->symbol); // put the input symbol c-string to the field symbol in p
        
        printf("\n\tEnter the address : ");
        scanf("%d",&p->addr); // put the input address value to the field addr in p
        
        // no next symbol tab by default
        p->next=NULL;
        
       
        if(size==0)  // if no tabs have been created, set first and last pointer to the tab
        {
            first=p;
            last=p;
        } // end if
        else 
        {
            // some tabs have been created, add the new tab in the linked list and move the last pointer to the created one.
            last->next=p;
            last=p;
        } // end else
        
        // indent the number of tab created
        size++;
    } // end else
    
    // notify the user that a tab has been successfully inserted into the table
    printf("\n\tLabel inserted\n");
} // end Insert

// displaying the tabs in the symbol table
void Display()
{
    // a variable to count the number of tabs printed
    int i;
    
    // a pointer cursor
    struct SymbTab *p;
    p=first; // set it to the first tab
    
    // printing the types of information in a tab
    printf("\n\tLABEL\t\tSYMBOL\t\tADDRESS\n");
    
    for(i=0;i<size;i++)
    {
        // print the content of the tab p is pointing to
        printf("\t%s\t\t%s\t\t%d\n",p->label,p->symbol,p->addr);
        
        // go to the next tab
        p=p->next;
    } // end for
} // end Display

// search in the table for a tab with the label in the parameter and return 1 if found, 0 if not found
int Search(char lab[])
{
    // variable i to count of tabs searched, variable flag to check if a tab with the parameter label is found
    int i,flag=0;
    
    // a pointer to the tab we are checking
    struct SymbTab *p;
    
    // start searching
    p=first;
    for(i=0;i<size;i++)
    {
        // the current tab does match the label parameter
        if(strcmp(p->label,lab)==0)
            flag=1; // set the flag that the tab with parameter label has been found
        p=p->next; // go to the next tab
    } // end for
    
    // return to tell if we have found the tab or not
    return flag;
} // end Search

// modify every tab in the symbol table with the requested lable name fromt the user. this function can modify label and/or symbol and address
void Modify()
{
    // l: current label, nl: new label
    char l[10],nl[10];
    
    
    // add:  the current address
    // choice: the modify options. 
    // i: the iteration variable
    // s: the result of the search with the current label
    int add,choice,i,s;
    
    // the pointer to a tab in symbol table
    struct SymbTab *p;
    
    // set p to the first tab
    p=first;
    
    // ask the user which things they want to modify
    printf("\n\tWhat do you want to modify?\n");
    
    // show the modify options
    printf("\n\t1.Only the label\n\t2.Only the address\n\t3.Both the label and address\n");
    
    // ask for a modify option
    printf("\tEnter your choice : ");
    scanf("%d",&choice);
    
    // see which option to do
    switch(choice)
    {
        // modify label
        case 1:
        // ask for the current label
        printf("\n\tEnter the old label : ");
        scanf("%s",l);
        
        // search for a tab with that label
        s=Search(l);
        
        if(s==0) // if a tab with that label has not been found
            printf("\n\tLabel not found\n");
        else // if a tab with that label has been found
        {
            // ask for a new label to replace the current label
            printf("\n\tEnter the new label : ");
            scanf("%s",nl);
            
            // search through each tab to find a tab with the current label
            for(i=0;i<size;i++)
            {
                // if we have found a tab with that current label
                if(strcmp(p->label,l)==0)
                    strcpy(p->label,nl); // put the new label to the label field of the tab
                p=p->next; // go to the next tab
            } // end for
            
            
            // display the result after modification
            printf("\n\tAfter Modification:\n");
            Display();
        } // end else
        break; // of modify label
        
        // modify address
        case 2:
        // ask for the label of the tab whose address we want to change
        printf("\n\tEnter the label where the address is to be modified : ");
        scanf("%s",l);
        
        // search for a tab with that label
        s=Search(l);
        
        if(s==0) // if the tab has not been found
            printf("\n\tLabel not found\n");
        else // if the tab has been found
        {
            // ask for a new address
            printf("\n\tEnter the new address : ");
            scanf("%d",&add);
            
            // search through the symbol table for a tab with the asked label
            for(i=0;i<size;i++)
            {
                // if we have found one
                if(strcmp(p->label,l)==0)
                    p->addr=add; // replace the address of the tab with the new ones
                p=p->next; // go to the next tab
            } // end for 
            
            // display the symbol table after modification
            printf("\n\tAfter Modification:\n");
            Display();
        } // end else
        break; // of modify address
        
        // modify the label and address
        case 3:
        // ask for the current label
        printf("\n\tEnter the old label : ");
        scanf("%s",l);
        
        // search in the symbol table for a tab with the asked label
        s=Search(l);
        
        if(s==0) // if a tab with the asked label has not been found
            printf("\n\tLabel not found\n");
        else // if a tab with the asked label has been found
        {
            // ask for a new label
            printf("\n\tEnter the new label : ");
            scanf("%s",nl);
            
            // ask for a new address
            printf("\n\tEnter the new address : ");
            scanf("%d",&add);
            
            // search through a symbol table for a tab with the asked label
            for(i=0;i<size;i++)
            {
                // if a tab with the asked label has been found
                if(strcmp(p->label,l)==0)
                {
                    strcpy(p->label,nl); // replace the old label with the new one
                    p->addr=add; // replace the old address with the new one
                } // end if
                
                // go to the next tab
                p=p->next;
            } // end for
            
            // display the symbol table after modification
            printf("\n\tAfter Modification:\n");
            Display();
        } // end else
        break; // of modifying label and address
        
    } // end switch
} // end Modify

// delete a tab in a symbol table with the requested label from the user. Finding the need-to-be-deleted tab by checking the first tab, the last tab, then the middle tabs
void Delete()
{
    // the current address
    int a;
    // the current label
    char l[10];
    
    // p: previous tab pointer, q: current tab pointer
    struct SymbTab *p,*q;
    
    // set the previous tab pointer to the first tab
    p=first;
    
    // ask for the name of the label of the tab we want to delete
    printf("\n\tEnter the label to be deleted : ");
    scanf("%s",l);
    
    // search for a tab with the asked label
    a=Search(l);
    
    if(a==0) // if that tab has not been found
        printf("\n\tLabel not found\n");
    else  // if that tab has been found
    {
        
        if(strcmp(first->label,l)==0) // if the first tab has the same label as the asked label
            first=first->next; // delete the first tab by moving first pointer to the next tab
        else if(strcmp(last->label,l)==0) // if the last tab has the same label as the asked label
        {
            // the current tab pointer will be the next tab of the previous tab pointer
            q=p->next;
            
            while(strcmp(q->label,l)!=0) // while the tab pointed to by the current tab pointer does not have the same label as the asked label
            {
                // move each pointer to its next tab
                p=p->next; 
                q=q->next;
            } // end while
            
            // the current tab pointer is now at the last tab
            // set the previous tab next field to NULL
            p->next=NULL;
            // the last tab will now be the previous tab
            last=p;
        } // end else if 
        else // if the tab with the asked label is neither the first tab nor the last tab
        {
            // the current tab pointer will the next one of the previous tab pointer
            q=p->next;
            
            // while the current tab pointer points to a tab that does not has the same label as the asked label
            while(strcmp(q->label,l)!=0)
            {
                // move the two pointer to the next one
                p=p->next; 
                q=q->next;
            } // end while
            
            // reach a point where the current tab pointer is at the tab that has the asked label, and previous tab pointer is at the tab behind it.
            // remove the tab that the current tab pointer is pointing at by replace the next link of the previous tab with the next tab of the current tab.
            p->next=q->next;
        } // end else
        
        // reduce the number of tabs in the symbol table
        size--;
        
        // show the symbol table after modification
        printf("\n\tAfter Deletion:\n");
        Display();
    } // end else
} // end Delete

