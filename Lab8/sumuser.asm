 # Long Tran
 # this program prompts the user for an input and calculates the sum of squares up to and including that number
 # April 17, 2020
 # Input: a number
 # Output: the sum of squares up to and including that number
           
.data
# strings for input
L1: .asciiz "Please enter value: "
L3:  .asciiz "The square is "
NL:  .asciiz "\n"

# strings for output
str: .asciiz "The sum from 0 .. "
str1: .asciiz " is \n"

.text  # directive that we are in the code segment
main:
        subu $a0, $sp, 16 # We want 5 mem locations for main SP, RA, i , s, and the variable for the input
        sw $ra, 4($a0)  # we need to store the RA in the Activation record
        sw $sp, ($a0) # store SP
        move $sp, $a0  # adjust SP

        sw $0, 8($sp)  # store 0 into memory -- counting variable 
        sw $0, 12($sp)  # store 0 into memory -- accumulating variable
        
        #Prints the prompt2 string
	li $v0, 4
	la $a0, L1
	syscall 

	#reads one integer from user and saves in t0
	li $v0, 5
	syscall
	sw $v0 16($sp)
 
       
loop:
	#calculations
        lw $t6, 8($sp)  #   i
        mul $t7, $t6, $t6  #  i * i
        lw $t8, 12($sp)   #  s
        addu $t9, $t8, $t7  #  s + i*i
        sw $t9, 12($sp)  #   s= s + i*i 
        lw $t6, 8($sp)   # i 
        addu $t0, $t6, 1  # i+1
        sw $t0, 8($sp)  #  i = i + 1
        
        # check the condition
        lw $t1, 16($sp)
        ble $t0, $t1, loop  #   keep doing it for the input amount of times
        nop   # 
        
        # print "The sum from 0 .. "
        la $a0, str
        li $v0 4  #   print the string
        syscall # 
        nop   # 
        
        # print the number input
        lw $a0, 16($sp)
        li $v0 1
        syscall
        
        # print "is \n"
        la $a0, str1
        li $v0 4  #   print the string
        syscall # 
        
        lw $a0, 12($sp)
        li $v0 1 #   Print the number
        syscall
        
       
        lw $ra, 4($sp)
        lw $sp , ($sp)  # put backl Ra and SP
        
        li $v0, 10 
        syscall     #  exit for MAIN only
        
        
