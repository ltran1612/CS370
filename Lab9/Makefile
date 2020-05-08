#Makefile for lab 9
#Long Tran
#May 8, 2020

all: lab9

lab9:  y.tab.c lex.yy.c AST.c AST.h symtable.c symtable.h emit.c emit.h
	gcc lex.yy.c y.tab.c AST.c symtable.c emit.c -o lab9

lex.yy.c: lab9.l
	lex lab9.l

y.tab.c: lab9.y
	yacc -d lab9.y

# clean target for cleaning the executable file, and the files created from lex and yacc
clean:
	rm -r lex.yy.c y.tab.c y.tab.h lab9 *.o

# test the code in test.al and output to test.asm
test:
	./lab9 < test.al -o test

# test the functionality of the ALGOL-C language stored in test_all.al
testall: test_all.al lab9
	./lab9 < test_all.al -o test

# zip the content
zip:
	zip -r long-lab9.zip AST.c AST.h emit.c emit.h lab9.l lab9.y Makefile symtable.c symtable.h test_folder

