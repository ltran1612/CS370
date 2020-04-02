#Makefile for lab6
#Long Tran
#March rd, 2020

all: lab6

lab6:  y.tab.c lex.yy.c AST.c AST.h
	gcc lex.yy.c y.tab.c AST.c -o lab6

lex.yy.c: lab6.l
	lex lab6.l

y.tab.c: lab6.y
	yacc -d lab6.y

# clean target for cleaning the executable file, and the files created from lex and yacc
clean:
	rm -r lex.yy.c y.tab.c y.tab.h lab6
