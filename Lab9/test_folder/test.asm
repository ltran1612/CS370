.data

_L98:		.asciiz	"Choosing the options below for testing: (enter 0 to quit)"		# global string
_L99:		.asciiz	"Option 1: TEST DETECTING GLOBAL, LOCAL VARIABLES, AND ARRAY PARAMETER"		# global string
_L100:		.asciiz	"Option 2: TEST EXPRESSION (+, -, *, /, <,<=, >, >=, !=, ==, and, or, not)"		# global string
_L101:		.asciiz	"Option 3: TEST WRITE READ ASSIGNMENT"		# global string
_L102:		.asciiz	"Option 4: TEST WHILE"		# global string
_L103:		.asciiz	"Option 5: TEST IF, ELSE STATEMENT AND MULTIPLE IF ELSE IF"		# global string
_L104:		.asciiz	"Option 6: TEST FUNCTION, RECURSION, AND FUNCTION AS A PARAMETER OF ANOTHER FUNCTION"		# global string
_L105:		.asciiz	"Option 7: TEST THE VALUE OF BOOLEAN VARIABLES"		# global string
_L63:		.asciiz	"TEST EXPRESSION (+, -, *, /, <,<=, >, >=, !=, ==, and, or, not)"		# global string
_L64:		.asciiz	"Enter x: "		# global string
_L65:		.asciiz	"Enter y: "		# global string
_L66:		.asciiz	""		# global string
_L67:		.asciiz	"x + y is: "		# global string
_L68:		.asciiz	""		# global string
_L69:		.asciiz	"x - y is: "		# global string
_L70:		.asciiz	""		# global string
_L71:		.asciiz	"x * y is: "		# global string
_L72:		.asciiz	""		# global string
_L73:		.asciiz	"x / y is: "		# global string
_L74:		.asciiz	""		# global string
_L75:		.asciiz	"x < y is: "		# global string
_L76:		.asciiz	""		# global string
_L77:		.asciiz	"x <= y is: "		# global string
_L78:		.asciiz	""		# global string
_L79:		.asciiz	"x > y is: "		# global string
_L80:		.asciiz	""		# global string
_L81:		.asciiz	"x >= y is: "		# global string
_L82:		.asciiz	""		# global string
_L83:		.asciiz	"x ==  y is: "		# global string
_L84:		.asciiz	""		# global string
_L85:		.asciiz	"x != y is: "		# global string
_L86:		.asciiz	""		# global string
_L87:		.asciiz	"x and y is: "		# global string
_L88:		.asciiz	""		# global string
_L89:		.asciiz	"x or y is: "		# global string
_L90:		.asciiz	""		# global string
_L91:		.asciiz	"not(x) is: "		# global string
_L92:		.asciiz	""		# global string
_L93:		.asciiz	"true, false, not(true), not(false) is: "		# global string
_L94:		.asciiz	"Test x == 2 or/and 3 == 1"		# global string
_L95:		.asciiz	"Enter x: "		# global string
_L96:		.asciiz	"x == 2 or 3 == 1: (expected 1 if x = 3)"		# global string
_L97:		.asciiz	"x == 2 and 3 == 1: (expected 1 if x = 2)"		# global string
_L49:		.asciiz	"TEST DETECTING GLOBAL, LOCAL VARIABLES, AND ARRAY PARAMETER"		# global string
_L54:		.asciiz	"global x is: (expected 1)"		# global string
_L55:		.asciiz	""		# global string
_L56:		.asciiz	"global array num[0] is: (expected 1) "		# global string
_L57:		.asciiz	""		# global string
_L58:		.asciiz	"Passing global x, and global array num to a function to assign its value: "		# global string
_L59:		.asciiz	"global x is: (expected 1)"		# global string
_L60:		.asciiz	""		# global string
_L61:		.asciiz	"global array num[0] is: (expected -1) "		# global string
_L62:		.asciiz	""		# global string
_L50:		.asciiz	"local x is: (expected 2) "		# global string
_L51:		.asciiz	""		# global string
_L52:		.asciiz	"local array num x[0] is: (expected 2) "		# global string
_L53:		.asciiz	""		# global string
_L48:		.asciiz	"In change variable: "		# global string
_L33:		.asciiz	"TEST WRITE READ ASSIGNMENT"		# global string
_L34:		.asciiz	"Test writing a value 1"		# global string
_L35:		.asciiz	""		# global string
_L36:		.asciiz	"Test variable (scalar and array) assignment"		# global string
_L37:		.asciiz	"The value of scalar one is: (expected 1)"		# global string
_L38:		.asciiz	"The value of array[0] is: (expected 10)"		# global string
_L39:		.asciiz	""		# global string
_L40:		.asciiz	"Test read the variable assignment: "		# global string
_L41:		.asciiz	"The value of two before read is: "		# global string
_L42:		.asciiz	"Enter a value for two: "		# global string
_L43:		.asciiz	"The value of two after read is: "		# global string
_L44:		.asciiz	""		# global string
_L45:		.asciiz	"The value of array[99] before read is: "		# global string
_L46:		.asciiz	"Enter a value for array[99]"		# global string
_L47:		.asciiz	"The value of array[99] after read is: "		# global string
_L28:		.asciiz	"TEST WHILE"		# global string
_L29:		.asciiz	"Assigning values to the array"		# global string
_L30:		.asciiz	"Write the values of one, two, array[] of five starting locations: "		# global string
_L31:		.asciiz	"Write WHILE to the screen 5 times, with while (count)"		# global string
_L32:		.asciiz	"WHILE"		# global string
_L13:		.asciiz	"TEST IF, ELSE STATEMENT AND MULTIPLE IF ELSE IF"		# global string
_L14:		.asciiz	"Enter a value for one: "		# global string
_L15:		.asciiz	"Enter a value for two: "		# global string
_L16:		.asciiz	"Checking these two conditions"		# global string
_L20:		.asciiz	""		# global string
_L21:		.asciiz	"Check equal,not equal"		# global string
_L24:		.asciiz	"Test selection with one number only"		# global string
_L25:		.asciiz	"Enter one"		# global string
_L26:		.asciiz	"TRUE"		# global string
_L27:		.asciiz	"FALSE"		# global string
_L22:		.asciiz	"one is equal to two"		# global string
_L23:		.asciiz	"one is not equal to two"		# global string
_L17:		.asciiz	"one is greater than two"		# global string
_L18:		.asciiz	"one is equal to two"		# global string
_L19:		.asciiz	"one is less than two"		# global string
_L5:		.asciiz	"TEST FUNCTION, RECURSION, AND FUNCTION AS A PARAMETER OF ANOTHER FUNCTION"		# global string
_L6:		.asciiz	"Test recursive with fibonanci number less than 100 with memorization of a local array"		# global string
_L7:		.asciiz	"Enter value for x: "		# global string
_L8:		.asciiz	"The result is: "		# global string
_L9:		.asciiz	"Test function as parameter of a function"		# global string
_L10:		.asciiz	"Enter a value for x: "		# global string
_L11:		.asciiz	"The result is: (expected to be x + 2)"		# global string
_L12:		.asciiz	"Test function no return, no param"		# global string
_L4:		.asciiz	"print"		# global string
_L3:		.asciiz	"NEW VALUE"		# global string
_L0:		.asciiz	"TEST THE VALUE OF BOOLEAN VARIABLES"		# global string
_L1:		.asciiz	"The value of true is: "		# global string
_L2:		.asciiz	"The value of false is: "		# global string
_NL:	.asciiz	"\n"
.align 2 # start all of global variable aligned

num:		.space 400		# define a global variable
x:		.space 4		# define a global variable

.text

.globl main

				
testDataType:				# start of FUNCTION
		subu $a0, $sp, 24		# adjust the stack for function set up
		sw $sp, ($a0)		# store the stack pointer
		sw $ra, 4($a0)		# store the return address
		move $sp, $a0		# adjust the stack pointer
				
				# compound statement
				# write statement
		li $v0, 4		#print a string
		la $a0, _L0		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# assignment statement
		add $a0, $sp, 12		# get the address of LOCAL VAR
		sw $a0, 16($sp)		# storing the address of LHS to temporary space
		li $a0, 1		# expression is a TRUE
		move $a1, $a0		# store the value of RHS to $a1
		lw $a0, 16($sp)		# retrieve the value of LHS back to LHS
		sw $a1, ($a0)		# assign the RHS to LHS
				
				# assignment statement
		add $a0, $sp, 8		# get the address of LOCAL VAR
		sw $a0, 20($sp)		# storing the address of LHS to temporary space
		li $a0, 0		# expression is a FALSE
		move $a1, $a0		# store the value of RHS to $a1
		lw $a0, 20($sp)		# retrieve the value of LHS back to LHS
		sw $a1, ($a0)		# assign the RHS to LHS
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L1		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		add $a0, $sp, 12		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		li $v0, 1		# print a number
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L2		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		add $a0, $sp, 8		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		li $v0, 1		# print a number
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				
				
		lw $ra, 4($sp)		# Restore RA
		lw $sp, ($sp)		# Restore SP
		jr $ra		# Jump back to the caller
				
				
fib:				# start of FUNCTION
		subu $a0, $sp, 64		# adjust the stack for function set up
		sw $sp, ($a0)		# store the stack pointer
		sw $ra, 4($a0)		# store the return address
		move $sp, $a0		# adjust the stack pointer
				
				# compound statement
				# selection statement
		add $a0, $sp, 8		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		sw $a0, 16($sp)		# store the value of left hand side
		li $a0, 0		# expression is a NUMBER
		move $a1, $a0		# store the value of right hand side
		lw $a0, 16($sp)		# retrieve the result of left hand side
		slt $a0, $a0, $a1		# LHS < RHS
		li $t6, 0		# load temporary value for comparison
		beq $a0, $t6, _L106		# go to else part when the if condition is false (0)
				# return statement
		li $a0, 0		# expression is a NUMBER
				
		lw $ra, 4($sp)		# Restore RA
		lw $sp, ($sp)		# Restore SP
		jr $ra		# Jump back to the caller
				
				
		j _L107		# exit statement when finished
_L106:				# else label
_L107:				# end of selection statement
				
				# selection statement
		add $a0, $sp, 8		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		sw $a0, 20($sp)		# store the value of left hand side
		li $a0, 0		# expression is a NUMBER
		move $a1, $a0		# store the value of right hand side
		lw $a0, 20($sp)		# retrieve the result of left hand side
		seq $a0, $a0, $a1		# check if the two operands are equal
		sw $a0, 28($sp)		# store the value of left hand side
		add $a0, $sp, 8		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		sw $a0, 24($sp)		# store the value of left hand side
		li $a0, 1		# expression is a NUMBER
		move $a1, $a0		# store the value of right hand side
		lw $a0, 24($sp)		# retrieve the result of left hand side
		seq $a0, $a0, $a1		# check if the two operands are equal
		move $a1, $a0		# store the value of right hand side
		lw $a0, 28($sp)		# retrieve the result of left hand side
		or $a0, $a0, $a1		# LHS or RHS
		li $t6, 0		# load temporary value for comparison
		beq $a0, $t6, _L108		# go to else part when the if condition is false (0)
				# return statement
		add $a0, $sp, 8		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
				
		lw $ra, 4($sp)		# Restore RA
		lw $sp, ($sp)		# Restore SP
		jr $ra		# Jump back to the caller
				
				
		j _L109		# exit statement when finished
_L108:				# else label
_L109:				# end of selection statement
				
				# selection statement
		add $a0, $sp, 8		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		sll $a0, $a0, 2		# times the word size
		add $a1, $sp, 12		# get the address of ARRAY PARAMETER
		lw $a1, ($a1)		# get the address of the array passed to this ARRAY PARAMETER
		add $a0, $a1, $a0		# add in the index to the address of teh array
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		li $t6, 0		# load temporary value for comparison
		beq $a0, $t6, _L110		# go to else part when the if condition is false (0)
				# return statement
		add $a0, $sp, 8		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		sll $a0, $a0, 2		# times the word size
		add $a1, $sp, 12		# get the address of ARRAY PARAMETER
		lw $a1, ($a1)		# get the address of the array passed to this ARRAY PARAMETER
		add $a0, $a1, $a0		# add in the index to the address of teh array
		lw $a0, ($a0)		#fetch value from the location stored at $a0
				
		lw $ra, 4($sp)		# Restore RA
		lw $sp, ($sp)		# Restore SP
		jr $ra		# Jump back to the caller
				
				
		j _L111		# exit statement when finished
_L110:				# else label
_L111:				# end of selection statement
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L3		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# assignment statement
		add $a0, $sp, 8		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		sll $a0, $a0, 2		# times the word size
		add $a1, $sp, 12		# get the address of ARRAY PARAMETER
		lw $a1, ($a1)		# get the address of the array passed to this ARRAY PARAMETER
		add $a0, $a1, $a0		# add in the index to the address of teh array
		sw $a0, 60($sp)		# storing the address of LHS to temporary space
				# fun call
		add $a0, $sp, 8		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		sw $a0, 32($sp)		# store the value of left hand side
		li $a0, 1		# expression is a NUMBER
		move $a1, $a0		# store the value of right hand side
		lw $a0, 32($sp)		# retrieve the result of left hand side
		sub $a0, $a0, $a1		# LHS - RHS
		sw $a0, 40($sp)		# store the calculated argument value in temporary space
		add $a0, $sp, 12		# get the address of LOCAL VAR
		lw $a0, ($a0)		# get the address of array passed to ARRAY PARAMETER
		sw $a0, 36($sp)		# store the calculated argument value in temporary space
		subu $t5, $sp, 64		# calculate the future stack pointer after we call the function
		lw $a0, 40($sp)		# load the argument value back from the temporary space
		sw $a0, 8($t5)		# store it in the wanted location of the calling function
		lw $a0, 36($sp)		# load the argument value back from the temporary space
		sw $a0, 12($t5)		# store it in the wanted location of the calling function
		jal fib		# call the function
		sw $a0, 56($sp)		# store the value of left hand side
				# fun call
		add $a0, $sp, 8		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		sw $a0, 44($sp)		# store the value of left hand side
		li $a0, 2		# expression is a NUMBER
		move $a1, $a0		# store the value of right hand side
		lw $a0, 44($sp)		# retrieve the result of left hand side
		sub $a0, $a0, $a1		# LHS - RHS
		sw $a0, 52($sp)		# store the calculated argument value in temporary space
		add $a0, $sp, 12		# get the address of LOCAL VAR
		lw $a0, ($a0)		# get the address of array passed to ARRAY PARAMETER
		sw $a0, 48($sp)		# store the calculated argument value in temporary space
		subu $t5, $sp, 64		# calculate the future stack pointer after we call the function
		lw $a0, 52($sp)		# load the argument value back from the temporary space
		sw $a0, 8($t5)		# store it in the wanted location of the calling function
		lw $a0, 48($sp)		# load the argument value back from the temporary space
		sw $a0, 12($t5)		# store it in the wanted location of the calling function
		jal fib		# call the function
		move $a1, $a0		# store the value of right hand side
		lw $a0, 56($sp)		# retrieve the result of left hand side
		add $a0, $a0, $a1		# LHS + RHS
		move $a1, $a0		# store the value of RHS to $a1
		lw $a0, 60($sp)		# retrieve the value of LHS back to LHS
		sw $a1, ($a0)		# assign the RHS to LHS
				
				# return statement
		add $a0, $sp, 8		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		sll $a0, $a0, 2		# times the word size
		add $a1, $sp, 12		# get the address of ARRAY PARAMETER
		lw $a1, ($a1)		# get the address of the array passed to this ARRAY PARAMETER
		add $a0, $a1, $a0		# add in the index to the address of teh array
		lw $a0, ($a0)		#fetch value from the location stored at $a0
				
		lw $ra, 4($sp)		# Restore RA
		lw $sp, ($sp)		# Restore SP
		jr $ra		# Jump back to the caller
				
				
				
				
		lw $ra, 4($sp)		# Restore RA
		lw $sp, ($sp)		# Restore SP
		jr $ra		# Jump back to the caller
				
				
add:				# start of FUNCTION
		subu $a0, $sp, 20		# adjust the stack for function set up
		sw $sp, ($a0)		# store the stack pointer
		sw $ra, 4($a0)		# store the return address
		move $sp, $a0		# adjust the stack pointer
				
				# compound statement
				# return statement
		add $a0, $sp, 8		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		sw $a0, 16($sp)		# store the value of left hand side
		add $a0, $sp, 12		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		move $a1, $a0		# store the value of right hand side
		lw $a0, 16($sp)		# retrieve the result of left hand side
		add $a0, $a0, $a1		# LHS + RHS
				
		lw $ra, 4($sp)		# Restore RA
		lw $sp, ($sp)		# Restore SP
		jr $ra		# Jump back to the caller
				
				
				
				
		lw $ra, 4($sp)		# Restore RA
		lw $sp, ($sp)		# Restore SP
		jr $ra		# Jump back to the caller
				
				
print:				# start of FUNCTION
		subu $a0, $sp, 8		# adjust the stack for function set up
		sw $sp, ($a0)		# store the stack pointer
		sw $ra, 4($a0)		# store the return address
		move $sp, $a0		# adjust the stack pointer
				
				# compound statement
				# write statement
		li $v0, 4		#print a string
		la $a0, _L4		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				
				
		lw $ra, 4($sp)		# Restore RA
		lw $sp, ($sp)		# Restore SP
		jr $ra		# Jump back to the caller
				
				
testFunction:				# start of FUNCTION
		subu $a0, $sp, 436		# adjust the stack for function set up
		sw $sp, ($a0)		# store the stack pointer
		sw $ra, 4($a0)		# store the return address
		move $sp, $a0		# adjust the stack pointer
				
				# compound statement
				# write statement
		li $v0, 4		#print a string
		la $a0, _L5		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L6		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L7		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# read statement
		add $a0, $sp, 8		# get the address of LOCAL VAR
		li $v0, 5		# read a number from input
		syscall		# reading a number from input
		sw $v0, ($a0)		# store the read value into a mem location
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L8		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
				# fun call
		add $a0, $sp, 8		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		sw $a0, 416($sp)		# store the calculated argument value in temporary space
		add $a0, $sp, 12		# get the address of LOCAL VAR
		sw $a0, 412($sp)		# store the calculated argument value in temporary space
		subu $t5, $sp, 64		# calculate the future stack pointer after we call the function
		lw $a0, 416($sp)		# load the argument value back from the temporary space
		sw $a0, 8($t5)		# store it in the wanted location of the calling function
		lw $a0, 412($sp)		# load the argument value back from the temporary space
		sw $a0, 12($t5)		# store it in the wanted location of the calling function
		jal fib		# call the function
		li $v0, 1		# print a number
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L9		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L10		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# read statement
		add $a0, $sp, 8		# get the address of LOCAL VAR
		li $v0, 5		# read a number from input
		syscall		# reading a number from input
		sw $v0, ($a0)		# store the read value into a mem location
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L11		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
				# fun call
		li $a0, 1		# expression is a NUMBER
		sw $a0, 432($sp)		# store the calculated argument value in temporary space
				# fun call
		li $a0, 1		# expression is a NUMBER
		sw $a0, 424($sp)		# store the calculated argument value in temporary space
		add $a0, $sp, 8		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		sw $a0, 420($sp)		# store the calculated argument value in temporary space
		subu $t5, $sp, 20		# calculate the future stack pointer after we call the function
		lw $a0, 424($sp)		# load the argument value back from the temporary space
		sw $a0, 8($t5)		# store it in the wanted location of the calling function
		lw $a0, 420($sp)		# load the argument value back from the temporary space
		sw $a0, 12($t5)		# store it in the wanted location of the calling function
		jal add		# call the function
		sw $a0, 428($sp)		# store the calculated argument value in temporary space
		subu $t5, $sp, 20		# calculate the future stack pointer after we call the function
		lw $a0, 432($sp)		# load the argument value back from the temporary space
		sw $a0, 8($t5)		# store it in the wanted location of the calling function
		lw $a0, 428($sp)		# load the argument value back from the temporary space
		sw $a0, 12($t5)		# store it in the wanted location of the calling function
		jal add		# call the function
		li $v0, 1		# print a number
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L12		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# fun call
		subu $t5, $sp, 8		# calculate the future stack pointer after we call the function
		jal print		# call the function
				
				
				
		lw $ra, 4($sp)		# Restore RA
		lw $sp, ($sp)		# Restore SP
		jr $ra		# Jump back to the caller
				
				
testSelection:				# start of FUNCTION
		subu $a0, $sp, 32		# adjust the stack for function set up
		sw $sp, ($a0)		# store the stack pointer
		sw $ra, 4($a0)		# store the return address
		move $sp, $a0		# adjust the stack pointer
				
				# compound statement
				# write statement
		li $v0, 4		#print a string
		la $a0, _L13		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L14		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# read statement
		add $a0, $sp, 12		# get the address of LOCAL VAR
		li $v0, 5		# read a number from input
		syscall		# reading a number from input
		sw $v0, ($a0)		# store the read value into a mem location
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L15		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# read statement
		add $a0, $sp, 8		# get the address of LOCAL VAR
		li $v0, 5		# read a number from input
		syscall		# reading a number from input
		sw $v0, ($a0)		# store the read value into a mem location
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L16		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# selection statement
		add $a0, $sp, 12		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		sw $a0, 16($sp)		# store the value of left hand side
		add $a0, $sp, 8		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		move $a1, $a0		# store the value of right hand side
		lw $a0, 16($sp)		# retrieve the result of left hand side
		slt $a0, $a1, $a0		# LHS > RHS
		li $t6, 0		# load temporary value for comparison
		beq $a0, $t6, _L112		# go to else part when the if condition is false (0)
				# write statement
		li $v0, 4		#print a string
		la $a0, _L17		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
		j _L113		# exit statement when finished
_L112:				# else label
				# selection statement
		add $a0, $sp, 12		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		sw $a0, 20($sp)		# store the value of left hand side
		add $a0, $sp, 8		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		move $a1, $a0		# store the value of right hand side
		lw $a0, 20($sp)		# retrieve the result of left hand side
		seq $a0, $a0, $a1		# check if the two operands are equal
		li $t6, 0		# load temporary value for comparison
		beq $a0, $t6, _L114		# go to else part when the if condition is false (0)
				# write statement
		li $v0, 4		#print a string
		la $a0, _L18		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
		j _L115		# exit statement when finished
_L114:				# else label
				# selection statement
		add $a0, $sp, 12		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		sw $a0, 24($sp)		# store the value of left hand side
		add $a0, $sp, 8		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		move $a1, $a0		# store the value of right hand side
		lw $a0, 24($sp)		# retrieve the result of left hand side
		slt $a0, $a0, $a1		# LHS < RHS
		li $t6, 0		# load temporary value for comparison
		beq $a0, $t6, _L116		# go to else part when the if condition is false (0)
				# write statement
		li $v0, 4		#print a string
		la $a0, _L19		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
		j _L117		# exit statement when finished
_L116:				# else label
_L117:				# end of selection statement
				
_L115:				# end of selection statement
				
_L113:				# end of selection statement
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L20		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L21		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# selection statement
		add $a0, $sp, 12		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		sw $a0, 28($sp)		# store the value of left hand side
		add $a0, $sp, 8		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		move $a1, $a0		# store the value of right hand side
		lw $a0, 28($sp)		# retrieve the result of left hand side
		seq $a0, $a0, $a1		# check if the two operands are equal
		li $t6, 0		# load temporary value for comparison
		beq $a0, $t6, _L118		# go to else part when the if condition is false (0)
				# write statement
		li $v0, 4		#print a string
		la $a0, _L22		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
		j _L119		# exit statement when finished
_L118:				# else label
				# write statement
		li $v0, 4		#print a string
		la $a0, _L23		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
_L119:				# end of selection statement
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L24		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L25		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# read statement
		add $a0, $sp, 12		# get the address of LOCAL VAR
		li $v0, 5		# read a number from input
		syscall		# reading a number from input
		sw $v0, ($a0)		# store the read value into a mem location
				
				# selection statement
		add $a0, $sp, 12		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		li $t6, 0		# load temporary value for comparison
		beq $a0, $t6, _L120		# go to else part when the if condition is false (0)
				# write statement
		li $v0, 4		#print a string
		la $a0, _L26		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
		j _L121		# exit statement when finished
_L120:				# else label
				# write statement
		li $v0, 4		#print a string
		la $a0, _L27		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
_L121:				# end of selection statement
				
				
				
		lw $ra, 4($sp)		# Restore RA
		lw $sp, ($sp)		# Restore SP
		jr $ra		# Jump back to the caller
				
				
testWhile:				# start of FUNCTION
		subu $a0, $sp, 456		# adjust the stack for function set up
		sw $sp, ($a0)		# store the stack pointer
		sw $ra, 4($a0)		# store the return address
		move $sp, $a0		# adjust the stack pointer
				
				# compound statement
				# write statement
		li $v0, 4		#print a string
		la $a0, _L28		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# assignment statement
		add $a0, $sp, 416		# get the address of LOCAL VAR
		sw $a0, 420($sp)		# storing the address of LHS to temporary space
		li $a0, 0		# expression is a NUMBER
		move $a1, $a0		# store the value of RHS to $a1
		lw $a0, 420($sp)		# retrieve the value of LHS back to LHS
		sw $a1, ($a0)		# assign the RHS to LHS
				
				# assignment statement
		add $a0, $sp, 412		# get the address of LOCAL VAR
		sw $a0, 424($sp)		# storing the address of LHS to temporary space
		li $a0, 1		# expression is a NUMBER
		move $a1, $a0		# store the value of RHS to $a1
		lw $a0, 424($sp)		# retrieve the value of LHS back to LHS
		sw $a1, ($a0)		# assign the RHS to LHS
				
				# assignment statement
		add $a0, $sp, 408		# get the address of LOCAL VAR
		sw $a0, 428($sp)		# storing the address of LHS to temporary space
		li $a0, 2		# expression is a NUMBER
		move $a1, $a0		# store the value of RHS to $a1
		lw $a0, 428($sp)		# retrieve the value of LHS back to LHS
		sw $a1, ($a0)		# assign the RHS to LHS
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L29		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# iteration statement
_L122:				#WHILE TOP TARGET
		add $a0, $sp, 416		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		sw $a0, 432($sp)		# store the value of left hand side
		li $a0, 5		# expression is a NUMBER
		move $a1, $a0		# store the value of right hand side
		lw $a0, 432($sp)		# retrieve the result of left hand side
		slt $a0, $a0, $a1		# LHS < RHS
		li $t6, 0		# load zero value for comparison
		beq $a0, $t6, _L123		# checking the condition of while statement, exit if the expression is 0 (false)
				# compound statement
				# assignment statement
		add $a0, $sp, 416		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		sll $a0, $a0, 2		# times the word size
		add $a0, $a0, 8		# add the offset from sp with the index of the array
		add $a0, $sp, $a0		# get the address with index of LOCAL ARRAY
		sw $a0, 444($sp)		# storing the address of LHS to temporary space
		add $a0, $sp, 408		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		sw $a0, 436($sp)		# store the value of left hand side
		li $a0, 1		# expression is a NUMBER
		move $a1, $a0		# store the value of right hand side
		lw $a0, 436($sp)		# retrieve the result of left hand side
		add $a0, $a0, $a1		# LHS + RHS
		sw $a0, 440($sp)		# store the value of left hand side
		add $a0, $sp, 416		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		move $a1, $a0		# store the value of right hand side
		lw $a0, 440($sp)		# retrieve the result of left hand side
		add $a0, $a0, $a1		# LHS + RHS
		move $a1, $a0		# store the value of RHS to $a1
		lw $a0, 444($sp)		# retrieve the value of LHS back to LHS
		sw $a1, ($a0)		# assign the RHS to LHS
				
				# assignment statement
		add $a0, $sp, 416		# get the address of LOCAL VAR
		sw $a0, 452($sp)		# storing the address of LHS to temporary space
		add $a0, $sp, 416		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		sw $a0, 448($sp)		# store the value of left hand side
		li $a0, 1		# expression is a NUMBER
		move $a1, $a0		# store the value of right hand side
		lw $a0, 448($sp)		# retrieve the result of left hand side
		add $a0, $a0, $a1		# LHS + RHS
		move $a1, $a0		# store the value of RHS to $a1
		lw $a0, 452($sp)		# retrieve the value of LHS back to LHS
		sw $a1, ($a0)		# assign the RHS to LHS
				
				
		j _L122		# jump back to the top target of while statement
_L123:				#WHILE BOTTOM TARGET
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L30		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		add $a0, $sp, 412		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		li $v0, 1		# print a number
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		add $a0, $sp, 408		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		li $v0, 1		# print a number
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# assignment statement
		add $a0, $sp, 416		# get the address of LOCAL VAR
		sw $a0, 436($sp)		# storing the address of LHS to temporary space
		li $a0, 0		# expression is a NUMBER
		move $a1, $a0		# store the value of RHS to $a1
		lw $a0, 436($sp)		# retrieve the value of LHS back to LHS
		sw $a1, ($a0)		# assign the RHS to LHS
				
				# iteration statement
_L124:				#WHILE TOP TARGET
		add $a0, $sp, 416		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		sw $a0, 440($sp)		# store the value of left hand side
		li $a0, 5		# expression is a NUMBER
		move $a1, $a0		# store the value of right hand side
		lw $a0, 440($sp)		# retrieve the result of left hand side
		slt $a0, $a0, $a1		# LHS < RHS
		li $t6, 0		# load zero value for comparison
		beq $a0, $t6, _L125		# checking the condition of while statement, exit if the expression is 0 (false)
				# compound statement
				# write statement
		add $a0, $sp, 416		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		sll $a0, $a0, 2		# times the word size
		add $a0, $a0, 8		# add the offset from sp with the index of the array
		add $a0, $sp, $a0		# get the address with index of LOCAL ARRAY
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		li $v0, 1		# print a number
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# assignment statement
		add $a0, $sp, 416		# get the address of LOCAL VAR
		sw $a0, 448($sp)		# storing the address of LHS to temporary space
		add $a0, $sp, 416		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		sw $a0, 444($sp)		# store the value of left hand side
		li $a0, 1		# expression is a NUMBER
		move $a1, $a0		# store the value of right hand side
		lw $a0, 444($sp)		# retrieve the result of left hand side
		add $a0, $a0, $a1		# LHS + RHS
		move $a1, $a0		# store the value of RHS to $a1
		lw $a0, 448($sp)		# retrieve the value of LHS back to LHS
		sw $a1, ($a0)		# assign the RHS to LHS
				
				
		j _L124		# jump back to the top target of while statement
_L125:				#WHILE BOTTOM TARGET
				
				# assignment statement
		add $a0, $sp, 416		# get the address of LOCAL VAR
		sw $a0, 444($sp)		# storing the address of LHS to temporary space
		li $a0, 5		# expression is a NUMBER
		move $a1, $a0		# store the value of RHS to $a1
		lw $a0, 444($sp)		# retrieve the value of LHS back to LHS
		sw $a1, ($a0)		# assign the RHS to LHS
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L31		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# iteration statement
_L126:				#WHILE TOP TARGET
		add $a0, $sp, 416		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		li $t6, 0		# load zero value for comparison
		beq $a0, $t6, _L127		# checking the condition of while statement, exit if the expression is 0 (false)
				# compound statement
				# write statement
		li $v0, 4		#print a string
		la $a0, _L32		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# assignment statement
		add $a0, $sp, 416		# get the address of LOCAL VAR
		sw $a0, 452($sp)		# storing the address of LHS to temporary space
		add $a0, $sp, 416		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		sw $a0, 448($sp)		# store the value of left hand side
		li $a0, 1		# expression is a NUMBER
		move $a1, $a0		# store the value of right hand side
		lw $a0, 448($sp)		# retrieve the result of left hand side
		sub $a0, $a0, $a1		# LHS - RHS
		move $a1, $a0		# store the value of RHS to $a1
		lw $a0, 452($sp)		# retrieve the value of LHS back to LHS
		sw $a1, ($a0)		# assign the RHS to LHS
				
				
		j _L126		# jump back to the top target of while statement
_L127:				#WHILE BOTTOM TARGET
				
				
				
		lw $ra, 4($sp)		# Restore RA
		lw $sp, ($sp)		# Restore SP
		jr $ra		# Jump back to the caller
				
				
testWriteReadAsignment:				# start of FUNCTION
		subu $a0, $sp, 428		# adjust the stack for function set up
		sw $sp, ($a0)		# store the stack pointer
		sw $ra, 4($a0)		# store the return address
		move $sp, $a0		# adjust the stack pointer
				
				# compound statement
				# write statement
		li $v0, 4		#print a string
		la $a0, _L33		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L34		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $a0, 1		# expression is a NUMBER
		li $v0, 1		# print a number
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L35		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L36		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# assignment statement
		add $a0, $sp, 412		# get the address of LOCAL VAR
		sw $a0, 416($sp)		# storing the address of LHS to temporary space
		li $a0, 1		# expression is a NUMBER
		move $a1, $a0		# store the value of RHS to $a1
		lw $a0, 416($sp)		# retrieve the value of LHS back to LHS
		sw $a1, ($a0)		# assign the RHS to LHS
				
				# assignment statement
		li $a0, 0		# expression is a NUMBER
		sll $a0, $a0, 2		# times the word size
		add $a0, $a0, 8		# add the offset from sp with the index of the array
		add $a0, $sp, $a0		# get the address with index of LOCAL ARRAY
		sw $a0, 420($sp)		# storing the address of LHS to temporary space
		li $a0, 10		# expression is a NUMBER
		move $a1, $a0		# store the value of RHS to $a1
		lw $a0, 420($sp)		# retrieve the value of LHS back to LHS
		sw $a1, ($a0)		# assign the RHS to LHS
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L37		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		add $a0, $sp, 412		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		li $v0, 1		# print a number
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L38		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $a0, 0		# expression is a NUMBER
		sll $a0, $a0, 2		# times the word size
		add $a0, $a0, 8		# add the offset from sp with the index of the array
		add $a0, $sp, $a0		# get the address with index of LOCAL ARRAY
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		li $v0, 1		# print a number
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L39		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L40		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# assignment statement
		add $a0, $sp, 408		# get the address of LOCAL VAR
		sw $a0, 424($sp)		# storing the address of LHS to temporary space
		li $a0, 1		# expression is a NUMBER
		move $a1, $a0		# store the value of RHS to $a1
		lw $a0, 424($sp)		# retrieve the value of LHS back to LHS
		sw $a1, ($a0)		# assign the RHS to LHS
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L41		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		add $a0, $sp, 408		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		li $v0, 1		# print a number
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L42		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# read statement
		add $a0, $sp, 408		# get the address of LOCAL VAR
		li $v0, 5		# read a number from input
		syscall		# reading a number from input
		sw $v0, ($a0)		# store the read value into a mem location
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L43		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		add $a0, $sp, 408		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		li $v0, 1		# print a number
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L44		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L45		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $a0, 99		# expression is a NUMBER
		sll $a0, $a0, 2		# times the word size
		add $a0, $a0, 8		# add the offset from sp with the index of the array
		add $a0, $sp, $a0		# get the address with index of LOCAL ARRAY
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		li $v0, 1		# print a number
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L46		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# read statement
		li $a0, 99		# expression is a NUMBER
		sll $a0, $a0, 2		# times the word size
		add $a0, $a0, 8		# add the offset from sp with the index of the array
		add $a0, $sp, $a0		# get the address with index of LOCAL ARRAY
		li $v0, 5		# read a number from input
		syscall		# reading a number from input
		sw $v0, ($a0)		# store the read value into a mem location
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L47		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $a0, 99		# expression is a NUMBER
		sll $a0, $a0, 2		# times the word size
		add $a0, $a0, 8		# add the offset from sp with the index of the array
		add $a0, $sp, $a0		# get the address with index of LOCAL ARRAY
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		li $v0, 1		# print a number
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				
				
		lw $ra, 4($sp)		# Restore RA
		lw $sp, ($sp)		# Restore SP
		jr $ra		# Jump back to the caller
				
				
changeVar:				# start of FUNCTION
		subu $a0, $sp, 32		# adjust the stack for function set up
		sw $sp, ($a0)		# store the stack pointer
		sw $ra, 4($a0)		# store the return address
		move $sp, $a0		# adjust the stack pointer
				
				# compound statement
				# write statement
		li $v0, 4		#print a string
		la $a0, _L48		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# assignment statement
		add $a0, $sp, 8		# get the address of LOCAL VAR
		sw $a0, 20($sp)		# storing the address of LHS to temporary space
		li $a0, 0		# expression is a NUMBER
		sw $a0, 16($sp)		# store the value of left hand side
		li $a0, 1		# expression is a NUMBER
		move $a1, $a0		# store the value of right hand side
		lw $a0, 16($sp)		# retrieve the result of left hand side
		sub $a0, $a0, $a1		# LHS - RHS
		move $a1, $a0		# store the value of RHS to $a1
		lw $a0, 20($sp)		# retrieve the value of LHS back to LHS
		sw $a1, ($a0)		# assign the RHS to LHS
				
				# assignment statement
		li $a0, 0		# expression is a NUMBER
		sll $a0, $a0, 2		# times the word size
		add $a1, $sp, 12		# get the address of ARRAY PARAMETER
		lw $a1, ($a1)		# get the address of the array passed to this ARRAY PARAMETER
		add $a0, $a1, $a0		# add in the index to the address of teh array
		sw $a0, 28($sp)		# storing the address of LHS to temporary space
		li $a0, 0		# expression is a NUMBER
		sw $a0, 24($sp)		# store the value of left hand side
		li $a0, 1		# expression is a NUMBER
		move $a1, $a0		# store the value of right hand side
		lw $a0, 24($sp)		# retrieve the result of left hand side
		sub $a0, $a0, $a1		# LHS - RHS
		move $a1, $a0		# store the value of RHS to $a1
		lw $a0, 28($sp)		# retrieve the value of LHS back to LHS
		sw $a1, ($a0)		# assign the RHS to LHS
				
				
				
		lw $ra, 4($sp)		# Restore RA
		lw $sp, ($sp)		# Restore SP
		jr $ra		# Jump back to the caller
				
				
testVariablesLevel:				# start of FUNCTION
		subu $a0, $sp, 68		# adjust the stack for function set up
		sw $sp, ($a0)		# store the stack pointer
		sw $ra, 4($a0)		# store the return address
		move $sp, $a0		# adjust the stack pointer
				
				# compound statement
				# assignment statement
		la $a0, x		# load the address of GLOBAL VAR
		sw $a0, 8($sp)		# storing the address of LHS to temporary space
		li $a0, 1		# expression is a NUMBER
		move $a1, $a0		# store the value of RHS to $a1
		lw $a0, 8($sp)		# retrieve the value of LHS back to LHS
		sw $a1, ($a0)		# assign the RHS to LHS
				
				# assignment statement
		li $a0, 0		# expression is a NUMBER
		sll $a0, $a0, 2		# times the word size
		la $a1, num		# load the address of the GLOBAL ARRAY
		add $a0, $a0, $a1		# add the index in the address of GLOBAL ARRAY
		sw $a0, 12($sp)		# storing the address of LHS to temporary space
		li $a0, 1		# expression is a NUMBER
		move $a1, $a0		# store the value of RHS to $a1
		lw $a0, 12($sp)		# retrieve the value of LHS back to LHS
		sw $a1, ($a0)		# assign the RHS to LHS
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L49		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# compound statement
				# assignment statement
		add $a0, $sp, 16		# get the address of LOCAL VAR
		sw $a0, 60($sp)		# storing the address of LHS to temporary space
		li $a0, 2		# expression is a NUMBER
		move $a1, $a0		# store the value of RHS to $a1
		lw $a0, 60($sp)		# retrieve the value of LHS back to LHS
		sw $a1, ($a0)		# assign the RHS to LHS
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L50		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		add $a0, $sp, 16		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		li $v0, 1		# print a number
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L51		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# assignment statement
		li $a0, 0		# expression is a NUMBER
		sll $a0, $a0, 2		# times the word size
		add $a0, $a0, 20		# add the offset from sp with the index of the array
		add $a0, $sp, $a0		# get the address with index of LOCAL ARRAY
		sw $a0, 64($sp)		# storing the address of LHS to temporary space
		li $a0, 2		# expression is a NUMBER
		move $a1, $a0		# store the value of RHS to $a1
		lw $a0, 64($sp)		# retrieve the value of LHS back to LHS
		sw $a1, ($a0)		# assign the RHS to LHS
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L52		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $a0, 0		# expression is a NUMBER
		sll $a0, $a0, 2		# times the word size
		add $a0, $a0, 20		# add the offset from sp with the index of the array
		add $a0, $sp, $a0		# get the address with index of LOCAL ARRAY
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		li $v0, 1		# print a number
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L53		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L54		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		la $a0, x		# load the address of GLOBAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		li $v0, 1		# print a number
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L55		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L56		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $a0, 0		# expression is a NUMBER
		sll $a0, $a0, 2		# times the word size
		la $a1, num		# load the address of the GLOBAL ARRAY
		add $a0, $a0, $a1		# add the index in the address of GLOBAL ARRAY
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		li $v0, 1		# print a number
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L57		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L58		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# fun call
		la $a0, x		# load the address of GLOBAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		sw $a0, 20($sp)		# store the calculated argument value in temporary space
		la $a0, num		# load the address of GLOBAL VAR
		sw $a0, 16($sp)		# store the calculated argument value in temporary space
		subu $t5, $sp, 32		# calculate the future stack pointer after we call the function
		lw $a0, 20($sp)		# load the argument value back from the temporary space
		sw $a0, 8($t5)		# store it in the wanted location of the calling function
		lw $a0, 16($sp)		# load the argument value back from the temporary space
		sw $a0, 12($t5)		# store it in the wanted location of the calling function
		jal changeVar		# call the function
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L59		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		la $a0, x		# load the address of GLOBAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		li $v0, 1		# print a number
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L60		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L61		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $a0, 0		# expression is a NUMBER
		sll $a0, $a0, 2		# times the word size
		la $a1, num		# load the address of the GLOBAL ARRAY
		add $a0, $a0, $a1		# add the index in the address of GLOBAL ARRAY
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		li $v0, 1		# print a number
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L62		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				
				
		lw $ra, 4($sp)		# Restore RA
		lw $sp, ($sp)		# Restore SP
		jr $ra		# Jump back to the caller
				
				
testExpression:				# start of FUNCTION
		subu $a0, $sp, 88		# adjust the stack for function set up
		sw $sp, ($a0)		# store the stack pointer
		sw $ra, 4($a0)		# store the return address
		move $sp, $a0		# adjust the stack pointer
				
				# compound statement
				# write statement
		li $v0, 4		#print a string
		la $a0, _L63		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L64		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# read statement
		add $a0, $sp, 12		# get the address of LOCAL VAR
		li $v0, 5		# read a number from input
		syscall		# reading a number from input
		sw $v0, ($a0)		# store the read value into a mem location
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L65		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# read statement
		add $a0, $sp, 8		# get the address of LOCAL VAR
		li $v0, 5		# read a number from input
		syscall		# reading a number from input
		sw $v0, ($a0)		# store the read value into a mem location
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L66		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L67		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		add $a0, $sp, 12		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		sw $a0, 16($sp)		# store the value of left hand side
		add $a0, $sp, 8		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		move $a1, $a0		# store the value of right hand side
		lw $a0, 16($sp)		# retrieve the result of left hand side
		add $a0, $a0, $a1		# LHS + RHS
		li $v0, 1		# print a number
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L68		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L69		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		add $a0, $sp, 12		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		sw $a0, 20($sp)		# store the value of left hand side
		add $a0, $sp, 8		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		move $a1, $a0		# store the value of right hand side
		lw $a0, 20($sp)		# retrieve the result of left hand side
		sub $a0, $a0, $a1		# LHS - RHS
		li $v0, 1		# print a number
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L70		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L71		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		add $a0, $sp, 12		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		sw $a0, 24($sp)		# store the value of left hand side
		add $a0, $sp, 8		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		move $a1, $a0		# store the value of right hand side
		lw $a0, 24($sp)		# retrieve the result of left hand side
		mult $a0, $a1		# LHS * RHS
		mflo $a0		# retrieve the result of multiplication
		li $v0, 1		# print a number
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L72		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L73		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		add $a0, $sp, 12		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		sw $a0, 28($sp)		# store the value of left hand side
		add $a0, $sp, 8		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		move $a1, $a0		# store the value of right hand side
		lw $a0, 28($sp)		# retrieve the result of left hand side
		div $a0, $a1		# LHS / RHS
		mflo $a0		# retrieve the quotient of the division
		li $v0, 1		# print a number
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L74		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L75		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		add $a0, $sp, 12		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		sw $a0, 32($sp)		# store the value of left hand side
		add $a0, $sp, 8		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		move $a1, $a0		# store the value of right hand side
		lw $a0, 32($sp)		# retrieve the result of left hand side
		slt $a0, $a0, $a1		# LHS < RHS
		li $v0, 1		# print a number
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L76		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L77		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		add $a0, $sp, 12		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		sw $a0, 36($sp)		# store the value of left hand side
		add $a0, $sp, 8		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		move $a1, $a0		# store the value of right hand side
		lw $a0, 36($sp)		# retrieve the result of left hand side
		slt $t0, $a0, $a1		# LHS <= RHS
		seq $t1, $a0, $a1		# check if the two operands are equal
		or $a0, $t0, $t1		# either less than or equal
		li $v0, 1		# print a number
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L78		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L79		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		add $a0, $sp, 12		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		sw $a0, 40($sp)		# store the value of left hand side
		add $a0, $sp, 8		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		move $a1, $a0		# store the value of right hand side
		lw $a0, 40($sp)		# retrieve the result of left hand side
		slt $a0, $a1, $a0		# LHS > RHS
		li $v0, 1		# print a number
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L80		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L81		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		add $a0, $sp, 12		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		sw $a0, 44($sp)		# store the value of left hand side
		add $a0, $sp, 8		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		move $a1, $a0		# store the value of right hand side
		lw $a0, 44($sp)		# retrieve the result of left hand side
		slt $t0, $a1, $a0		# LHS > RHS
		seq $t1, $a0, $a1		# check if the two operands are equal
		or $a0, $t0, $t1		# either greater than or equal
		li $v0, 1		# print a number
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L82		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L83		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		add $a0, $sp, 12		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		sw $a0, 48($sp)		# store the value of left hand side
		add $a0, $sp, 8		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		move $a1, $a0		# store the value of right hand side
		lw $a0, 48($sp)		# retrieve the result of left hand side
		seq $a0, $a0, $a1		# check if the two operands are equal
		li $v0, 1		# print a number
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L84		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L85		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		add $a0, $sp, 12		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		sw $a0, 52($sp)		# store the value of left hand side
		add $a0, $sp, 8		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		move $a1, $a0		# store the value of right hand side
		lw $a0, 52($sp)		# retrieve the result of left hand side
		sne $a0, $a0, $a1		# check if the two operands are not equal
		li $v0, 1		# print a number
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L86		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L87		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		add $a0, $sp, 12		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		sw $a0, 56($sp)		# store the value of left hand side
		add $a0, $sp, 8		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		move $a1, $a0		# store the value of right hand side
		lw $a0, 56($sp)		# retrieve the result of left hand side
		and $a0, $a0, $a1		# LHS and RHS
		li $v0, 1		# print a number
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L88		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L89		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		add $a0, $sp, 12		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		sw $a0, 60($sp)		# store the value of left hand side
		add $a0, $sp, 8		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		move $a1, $a0		# store the value of right hand side
		lw $a0, 60($sp)		# retrieve the result of left hand side
		or $a0, $a0, $a1		# LHS or RHS
		li $v0, 1		# print a number
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L90		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L91		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		add $a0, $sp, 12		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		sltiu $a0, $a0, 1		# check if the expression is 0 -> set to 1. else -> set to 0
		li $v0, 1		# print a number
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L92		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L93		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $a0, 1		# expression is a TRUE
		li $v0, 1		# print a number
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $a0, 0		# expression is a FALSE
		li $v0, 1		# print a number
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $a0, 1		# expression is a TRUE
		sltiu $a0, $a0, 1		# check if the expression is 0 -> set to 1. else -> set to 0
		li $v0, 1		# print a number
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $a0, 0		# expression is a FALSE
		sltiu $a0, $a0, 1		# check if the expression is 0 -> set to 1. else -> set to 0
		li $v0, 1		# print a number
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L94		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L95		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# read statement
		add $a0, $sp, 12		# get the address of LOCAL VAR
		li $v0, 5		# read a number from input
		syscall		# reading a number from input
		sw $v0, ($a0)		# store the read value into a mem location
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L96		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		add $a0, $sp, 12		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		sw $a0, 68($sp)		# store the value of left hand side
		li $a0, 2		# expression is a NUMBER
		sw $a0, 64($sp)		# store the value of left hand side
		li $a0, 3		# expression is a NUMBER
		move $a1, $a0		# store the value of right hand side
		lw $a0, 64($sp)		# retrieve the result of left hand side
		or $a0, $a0, $a1		# LHS or RHS
		move $a1, $a0		# store the value of right hand side
		lw $a0, 68($sp)		# retrieve the result of left hand side
		seq $a0, $a0, $a1		# check if the two operands are equal
		sw $a0, 72($sp)		# store the value of left hand side
		li $a0, 1		# expression is a NUMBER
		move $a1, $a0		# store the value of right hand side
		lw $a0, 72($sp)		# retrieve the result of left hand side
		seq $a0, $a0, $a1		# check if the two operands are equal
		li $v0, 1		# print a number
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L97		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		add $a0, $sp, 12		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		sw $a0, 80($sp)		# store the value of left hand side
		li $a0, 2		# expression is a NUMBER
		sw $a0, 76($sp)		# store the value of left hand side
		li $a0, 3		# expression is a NUMBER
		move $a1, $a0		# store the value of right hand side
		lw $a0, 76($sp)		# retrieve the result of left hand side
		and $a0, $a0, $a1		# LHS and RHS
		move $a1, $a0		# store the value of right hand side
		lw $a0, 80($sp)		# retrieve the result of left hand side
		seq $a0, $a0, $a1		# check if the two operands are equal
		sw $a0, 84($sp)		# store the value of left hand side
		li $a0, 1		# expression is a NUMBER
		move $a1, $a0		# store the value of right hand side
		lw $a0, 84($sp)		# retrieve the result of left hand side
		seq $a0, $a0, $a1		# check if the two operands are equal
		li $v0, 1		# print a number
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				
				
		lw $ra, 4($sp)		# Restore RA
		lw $sp, ($sp)		# Restore SP
		jr $ra		# Jump back to the caller
				
				
main:				# start of FUNCTION
		subu $a0, $sp, 48		# adjust the stack for function set up
		sw $sp, ($a0)		# store the stack pointer
		sw $ra, 4($a0)		# store the return address
		move $sp, $a0		# adjust the stack pointer
				
				# compound statement
				# assignment statement
		add $a0, $sp, 8		# get the address of LOCAL VAR
		sw $a0, 16($sp)		# storing the address of LHS to temporary space
		li $a0, 0		# expression is a NUMBER
		sw $a0, 12($sp)		# store the value of left hand side
		li $a0, 1		# expression is a NUMBER
		move $a1, $a0		# store the value of right hand side
		lw $a0, 12($sp)		# retrieve the result of left hand side
		sub $a0, $a0, $a1		# LHS - RHS
		move $a1, $a0		# store the value of RHS to $a1
		lw $a0, 16($sp)		# retrieve the value of LHS back to LHS
		sw $a1, ($a0)		# assign the RHS to LHS
				
				# iteration statement
_L128:				#WHILE TOP TARGET
		add $a0, $sp, 8		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		li $t6, 0		# load zero value for comparison
		beq $a0, $t6, _L129		# checking the condition of while statement, exit if the expression is 0 (false)
				# compound statement
				# write statement
		li $v0, 4		#print a string
		la $a0, _L98		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L99		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L100		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L101		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L102		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L103		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L104		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# write statement
		li $v0, 4		#print a string
		la $a0, _L105		# fetch string location
		syscall		
		li $v0, 4		#print a newline
		la $a0, _NL		
		syscall		
				
				# read statement
		add $a0, $sp, 8		# get the address of LOCAL VAR
		li $v0, 5		# read a number from input
		syscall		# reading a number from input
		sw $v0, ($a0)		# store the read value into a mem location
				
				# selection statement
		add $a0, $sp, 8		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		sw $a0, 20($sp)		# store the value of left hand side
		li $a0, 1		# expression is a NUMBER
		move $a1, $a0		# store the value of right hand side
		lw $a0, 20($sp)		# retrieve the result of left hand side
		seq $a0, $a0, $a1		# check if the two operands are equal
		li $t6, 0		# load temporary value for comparison
		beq $a0, $t6, _L130		# go to else part when the if condition is false (0)
				# fun call
		subu $t5, $sp, 68		# calculate the future stack pointer after we call the function
		jal testVariablesLevel		# call the function
				
		j _L131		# exit statement when finished
_L130:				# else label
				# selection statement
		add $a0, $sp, 8		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		sw $a0, 24($sp)		# store the value of left hand side
		li $a0, 2		# expression is a NUMBER
		move $a1, $a0		# store the value of right hand side
		lw $a0, 24($sp)		# retrieve the result of left hand side
		seq $a0, $a0, $a1		# check if the two operands are equal
		li $t6, 0		# load temporary value for comparison
		beq $a0, $t6, _L132		# go to else part when the if condition is false (0)
				# fun call
		subu $t5, $sp, 88		# calculate the future stack pointer after we call the function
		jal testExpression		# call the function
				
		j _L133		# exit statement when finished
_L132:				# else label
				# selection statement
		add $a0, $sp, 8		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		sw $a0, 28($sp)		# store the value of left hand side
		li $a0, 3		# expression is a NUMBER
		move $a1, $a0		# store the value of right hand side
		lw $a0, 28($sp)		# retrieve the result of left hand side
		seq $a0, $a0, $a1		# check if the two operands are equal
		li $t6, 0		# load temporary value for comparison
		beq $a0, $t6, _L134		# go to else part when the if condition is false (0)
				# fun call
		subu $t5, $sp, 428		# calculate the future stack pointer after we call the function
		jal testWriteReadAsignment		# call the function
				
		j _L135		# exit statement when finished
_L134:				# else label
				# selection statement
		add $a0, $sp, 8		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		sw $a0, 32($sp)		# store the value of left hand side
		li $a0, 4		# expression is a NUMBER
		move $a1, $a0		# store the value of right hand side
		lw $a0, 32($sp)		# retrieve the result of left hand side
		seq $a0, $a0, $a1		# check if the two operands are equal
		li $t6, 0		# load temporary value for comparison
		beq $a0, $t6, _L136		# go to else part when the if condition is false (0)
				# fun call
		subu $t5, $sp, 456		# calculate the future stack pointer after we call the function
		jal testWhile		# call the function
				
		j _L137		# exit statement when finished
_L136:				# else label
				# selection statement
		add $a0, $sp, 8		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		sw $a0, 36($sp)		# store the value of left hand side
		li $a0, 5		# expression is a NUMBER
		move $a1, $a0		# store the value of right hand side
		lw $a0, 36($sp)		# retrieve the result of left hand side
		seq $a0, $a0, $a1		# check if the two operands are equal
		li $t6, 0		# load temporary value for comparison
		beq $a0, $t6, _L138		# go to else part when the if condition is false (0)
				# fun call
		subu $t5, $sp, 32		# calculate the future stack pointer after we call the function
		jal testSelection		# call the function
				
		j _L139		# exit statement when finished
_L138:				# else label
				# selection statement
		add $a0, $sp, 8		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		sw $a0, 40($sp)		# store the value of left hand side
		li $a0, 6		# expression is a NUMBER
		move $a1, $a0		# store the value of right hand side
		lw $a0, 40($sp)		# retrieve the result of left hand side
		seq $a0, $a0, $a1		# check if the two operands are equal
		li $t6, 0		# load temporary value for comparison
		beq $a0, $t6, _L140		# go to else part when the if condition is false (0)
				# fun call
		subu $t5, $sp, 436		# calculate the future stack pointer after we call the function
		jal testFunction		# call the function
				
		j _L141		# exit statement when finished
_L140:				# else label
				# selection statement
		add $a0, $sp, 8		# get the address of LOCAL VAR
		lw $a0, ($a0)		#fetch value from the location stored at $a0
		sw $a0, 44($sp)		# store the value of left hand side
		li $a0, 7		# expression is a NUMBER
		move $a1, $a0		# store the value of right hand side
		lw $a0, 44($sp)		# retrieve the result of left hand side
		seq $a0, $a0, $a1		# check if the two operands are equal
		li $t6, 0		# load temporary value for comparison
		beq $a0, $t6, _L142		# go to else part when the if condition is false (0)
				# fun call
		subu $t5, $sp, 24		# calculate the future stack pointer after we call the function
		jal testDataType		# call the function
				
		j _L143		# exit statement when finished
_L142:				# else label
_L143:				# end of selection statement
				
_L141:				# end of selection statement
				
_L139:				# end of selection statement
				
_L137:				# end of selection statement
				
_L135:				# end of selection statement
				
_L133:				# end of selection statement
				
_L131:				# end of selection statement
				
				
		j _L128		# jump back to the top target of while statement
_L129:				#WHILE BOTTOM TARGET
				
				
				
		lw $ra, 4($sp)		# Restore RA
		lw $sp, ($sp)		# Restore SP
				
		li $v0, 10		# leave main program
		syscall		# leave main
				
