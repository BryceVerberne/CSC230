# Title:  Procedures Basics
# Desc:   In this program, I am covering procedures.
# Author: Bryce Verberne
# Date:   02/19/2023



# Functions are like Java methods or C and C++ functions.
# You can use them whenever you want, which is call calling a fucntion. 
# In MIPS, functions are called "procedures"
# Procedures are stored in $ra, which is why we use this register to return.

.data
   message: .asciiz "Hi, everybody. \nMy name is Bryce Verberne.\n"

.text
  .globl main
main:                   # Whenever you are making a program, make sure that you have a main label.
                        # Main is, essentially, the main procedure/function.
 jal displayMessage     # jal (jump in link) is how we call procedures
   
 addi $s0, $zero, 5
   
  # Print 5 after procedure call.
  li   $v0, 1
  move $a0, $s0
  syscall


  # Terminating program
  li   $v0, 10          # Without terminating the program, you will have recursion when calling procedures...
  syscall


  # Whenever I call displayMessage, I want the variable "message" to be displayed.
  displayMessage:       # This is my procedure. As you can see, it is outside of the scope of the program.
    li $v0, 4
    la $a0, message
    syscall
   
    jr $ra              # This is a return. Telling the program to go back once the procedure is complete.
