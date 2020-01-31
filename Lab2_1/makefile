all: lab2remove
lab2remove: lex.yy.c
	gcc -o lab2remove lex.yy.c
lex.yy.c: lab2remove.l
	lex lab2remove.l
