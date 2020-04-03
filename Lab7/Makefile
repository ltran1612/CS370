#Makefile for lab 7
#Long Tran
#March rd, 2020

all: lab7

lab7:  y.tab.c lex.yy.c AST.c AST.h symtable.c symtable.h
	gcc lex.yy.c y.tab.c AST.c symtable.c -o lab7

lex.yy.c: lab7.l
	lex lab7.l

y.tab.c: lab7.y
	yacc -d lab7.y

# clean target for cleaning the executable file, and the files created from lex and yacc
clean:
	rm -r lex.yy.c y.tab.c y.tab.h lab7 *.o
