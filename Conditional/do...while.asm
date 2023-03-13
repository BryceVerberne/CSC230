# Title:  do...while
# Desc:   Convert a C do-while loop to assembly.
# Author: Bryce Verberne
# Data:   03/13/2023



# #include <stdio.h>
# int main() {
# 
# int x;
#
# do {
#   printf("Please enter an integer: ");
#   scanf("%d\n", &x);
# } while (x <= 10);
# 
# printf("This is your result: %d\n", x);
# 
# return 0;
# }

.data
  prompt: .asciiz "Please enter an integer: "
  result: .asciiz "This is your result: "

.text
  .globl main
main:

  li $t1, 10

  la $a0, prompt   # Printing prompt
  li $v0, 4
  syscall
  
  li $v0, 5        # Reading integer
  syscall
  move $t0, $v0
  
  loop:
    bgt $t0, $t1, end
    
    la $a0, prompt   # Printing prompt
    li $v0, 4
    syscall
  
    li $v0, 5        # Reading integer
    syscall
    move $t0, $v0
    
    b loop
  end:
  
  la $a0, result
  li $v0, 4
  syscall
  
  move $a0, $t0
  li $v0, 1
  syscall
  
  li $a0, '\n'
  li $v0, 11
  syscall
  
  

  # Terminating Program
  li $v0, 10
  syscall
