.data # start of the DATA section, strings first

_L0:	.asciiz "enter X"		#global string
_NL: .asciiz "\n "# NEw line
.align 2 # start all of global variable aligned


.text
 			
	.text		
			
main:			#Start of Function 
	subu $t0  $sp 60		#set up $t0 to be the new spot for SP
	sw $ra ($t0)		 #Store the return address 
	sw $sp 4($t0)		 #Store the old stack pointer 
	move $sp $t0 		# set the stack pointer to the new value
			
	li $a0 0		# expresion a number
	sw $a0, 32($sp)		#store RHS value in memory
	li $a0 28		#get Identifier offset
	 add $a0,$a0,$sp		# we have direct reference to memory 
	lw $a1, 32($sp)		# Get RHS stored value
	sw $a1 ($a0)		# ASSIGN final store 
			
_L1:	 			# WHILE TOP target
	li $a0 28		#get Identifier offset
	 add $a0,$a0,$sp		# we have direct reference to memory 
	lw $a0 ($a0)		#expression is identifier
	sw $a0  36($sp)		#store LHS of expression in memory
	li $a0 5		# expresion a number
	move $a1, $a0		#right hand side needs to be a1
	lw $a0  36($sp)		#fetch LHS of expression from memory
	slt $a0, $a0, $a1		#EXPR Lessthan
	sw $a0  36($sp)		#store RHS of expression in memory
	beq $a0 $0 _L2		#WHILE branch out
	li $v0, 4		#print a string
	la $a0, _L0		#print fetch string location
	syscall		
	li $v0, 4		#print NEWLINE
	la $a0, _NL		#print NEWLINE string location
	syscall		
			
	li $a0 28		#get Identifier offset
	 add $a0,$a0,$sp		# we have direct reference to memory 
	lw $a0 ($a0)		#expression is identifier
	sll $t3, $a0, 2 		 #multiply wordsile   
	li $a0 8		#get Identifier offset
	 add $a0,$a0,$sp		# we have direct reference to memory 
	add $a0, $a0, $t3		# move add on $t3 as this is an array reference
	li $v0 5		#read in a number 
	syscall		#now read  
	sw $v0 ($a0)		# end of read statement 
			
	li $a0 28		#get Identifier offset
	 add $a0,$a0,$sp		# we have direct reference to memory 
	lw $a0 ($a0)		#expression is identifier
	sw $a0  40($sp)		#store LHS of expression in memory
	li $a0 1		# expresion a number
	move $a1, $a0		#right hand side needs to be a1
	lw $a0  40($sp)		#fetch LHS of expression from memory
	add $a0, $a0, $a1		#EXPR ADD
	sw $a0  40($sp)		#store RHS of expression in memory
	sw $a0, 44($sp)		#store RHS value in memory
	li $a0 28		#get Identifier offset
	 add $a0,$a0,$sp		# we have direct reference to memory 
	lw $a1, 44($sp)		# Get RHS stored value
	sw $a1 ($a0)		# ASSIGN final store 
			
	j _L1		#WHILE Jump back
_L2:	 			# End of WHILE 
			
	li $a0 0		# expresion a number
	sw $a0, 40($sp)		#store RHS value in memory
	li $a0 28		#get Identifier offset
	 add $a0,$a0,$sp		# we have direct reference to memory 
	lw $a1, 40($sp)		# Get RHS stored value
	sw $a1 ($a0)		# ASSIGN final store 
			
_L3:	 			# WHILE TOP target
	li $a0 28		#get Identifier offset
	 add $a0,$a0,$sp		# we have direct reference to memory 
	lw $a0 ($a0)		#expression is identifier
	sw $a0  44($sp)		#store LHS of expression in memory
	li $a0 5		# expresion a number
	move $a1, $a0		#right hand side needs to be a1
	lw $a0  44($sp)		#fetch LHS of expression from memory
	slt $a0, $a0, $a1		#EXPR Lessthan
	sw $a0  44($sp)		#store RHS of expression in memory
	beq $a0 $0 _L4		#WHILE branch out
	li $a0 28		#get Identifier offset
	 add $a0,$a0,$sp		# we have direct reference to memory 
	lw $a0 ($a0)		#expression is identifier
	sll $t3, $a0, 2 		 #multiply wordsile   
	li $a0 8		#get Identifier offset
	 add $a0,$a0,$sp		# we have direct reference to memory 
	add $a0, $a0, $t3		# move add on $t3 as this is an array reference
	lw $a0 ($a0)		#expression is identifier
	sw $a0  48($sp)		#store LHS of expression in memory
	li $a0 28		#get Identifier offset
	 add $a0,$a0,$sp		# we have direct reference to memory 
	lw $a0 ($a0)		#expression is identifier
	sll $t3, $a0, 2 		 #multiply wordsile   
	li $a0 8		#get Identifier offset
	 add $a0,$a0,$sp		# we have direct reference to memory 
	add $a0, $a0, $t3		# move add on $t3 as this is an array reference
	lw $a0 ($a0)		#expression is identifier
	move $a1, $a0		#right hand side needs to be a1
	lw $a0  48($sp)		#fetch LHS of expression from memory
	mult $a0 $a1		#EXPR MULT
	mflo $a0		#EXPR MULT
	sw $a0  48($sp)		#store RHS of expression in memory
	li $v0 1		#set up write call
	syscall		
	li $v0, 4		#print NEWLINE
	la $a0, _NL		#print NEWLINE string location
	syscall		
			
	li $a0 28		#get Identifier offset
	 add $a0,$a0,$sp		# we have direct reference to memory 
	lw $a0 ($a0)		#expression is identifier
	sw $a0  52($sp)		#store LHS of expression in memory
	li $a0 1		# expresion a number
	move $a1, $a0		#right hand side needs to be a1
	lw $a0  52($sp)		#fetch LHS of expression from memory
	add $a0, $a0, $a1		#EXPR ADD
	sw $a0  52($sp)		#store RHS of expression in memory
	sw $a0, 56($sp)		#store RHS value in memory
	li $a0 28		#get Identifier offset
	 add $a0,$a0,$sp		# we have direct reference to memory 
	lw $a1, 56($sp)		# Get RHS stored value
	sw $a1 ($a0)		# ASSIGN final store 
			
	j _L3		#WHILE Jump back
_L4:	 			# End of WHILE 
			
	li $v0 0    		#  return  NULL zero (0) 
	lw $ra ($sp)		# reset return address 
	lw $sp 4($sp)		# reset stack pointer 
	li $v0, 10		#Main function ends 
	syscall		#MAIN FUNCTION EXITS
