all: lab2docalc
lab2docalc: y.tab.c lex.yy.c
	gcc -o lab2docalc y.tab.c
lex.yy.c: lab2docalc.l
	lex lab2docalc.l
y.tab.c: lab2docalc.y
	yacc -d lab2docalc.y
