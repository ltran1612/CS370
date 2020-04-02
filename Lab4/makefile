# Lab 4 docal
# Long Tran
# Feb 21, 2020

all: docalc

docalc: y.tab.c lex.yy.c y.tab.h symtable.c
	gcc y.tab.c lex.yy.c symtable.c  -o docalc

y.tab.c: lab2docalc.y
	yacc -d lab2docalc.y

lex.yy.c: lab2docalc.l
	lex lab2docalc.l

symtable: symtable.c symtable.h
	gcc symtable.c

clean:
	rm -rf y.tab.c y.tab.h lex.yy.c 
