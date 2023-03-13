# Title: Array of Fibonacci Sequence
# Desc: In this program, I am populating an array with Fibonacci numbers.
# Author: Bryce Verberne
# Date: 02/27/2023



.data

.text
  .globl main
main:
  
  move $s0, $zero   # Load the value 0 into register $s0
  li   $s1, 1       # Load the value 1 into register $s1
  li   $s2, 10      # Number of loop iterations
  move $t0, $zero   # Iterator
  
  li   $v0, 1
  move $a0, $s0
  syscall
    
  li   $v0, 11
  li   $a0, '\n'
  syscall
    
  li   $v0, 1
  move $a0, $s1
  syscall
    
  li   $v0, 11
  li   $a0, '\n'
  syscall
  
  loop: 
    beq  $s2, $t0, end
    
    move $t1, $s1
    add  $s1, $s1, $s0
    move $s0, $t1
    
    li   $v0, 1
    move $a0, $s1
    syscall
    
    li   $v0, 11
    li   $a0, '\n'
    syscall
        
    addi $t0, $t0, 1     # Iterate $t1
    
    b loop
  end:
  
  # Terminating Program
  lw $v0, 10
  syscall
