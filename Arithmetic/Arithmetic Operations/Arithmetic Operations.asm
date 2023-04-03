# Title:  Arithmetic Operations
# Desc:   In this program, I am covering arithmetic examples.
# Author: Bryce Verberne
# Date:   02/19/2023



.data
  num1:        .word 5
  num2:        .word 10
  addition:    .asciiz "The sum of $t1 and $t0 is: "
  subtraction: .asciiz "The difference of 10 - 5 is: "
  division1:   .asciiz "The quotient of 30 / 5 is: "
  quotient:    .asciiz "The quotient of 30 / 8 is: "
  remainder:   .asciiz "The remainder of 30 / 8 is: "
   
.text
  .globl main
main:
   
  # --------------------- Adding two numbers:
  lw   $t0, num1($zero)   # lw $t0, num1 would perform the same operation
  lw   $t1, num2($zero)
   
  add  $t2, $t1, $t0     # Add $t1 and $t0, then store the result in $t2
   
  li   $v0, 4
  la   $a0, addition
  syscall
   
  li   $v0, 1
  add  $a0, $zero, $t2   # This is a nice alternative to the pseudo instruction "move"
  syscall
  # --------------------- End


  li   $v0, 11
  li   $a0, '\n'
  syscall
   
   
  # --------------------- Subtracting two numbers:
  lw   $s0, num1          # $s0 = 5
  lw   $s1, num2          # $s1 = 10
   
  sub  $t0, $s1, $s0      # Store $s1 - $s0 in $t0 
   
  li   $v0, 4
  la   $a0, subtraction
  syscall
   
  li   $v0, 1
  move $a0, $t0
  syscall
  # --------------------- End

         
  li   $v0, 11
  li   $a0, '\n'
  syscall
   
   
  # --------------------- Dividing two numbers (No overflow version):
  addi $t0, $zero, 30
  addi $t1, $zero, 5
   
  div  $s0, $t0, $t1        # Store $t0 / $t1 in $s0. 
                             # You can also say div $s0, $t0, 5
   
  li   $v0, 4
  la   $a0, division1
  syscall
   
  li   $v0, 1
  move $a0, $s0
  syscall
  # --------------------- End
   
          
  li   $v0, 11
  li   $a0, '\n'
  syscall
   
   
  # --------------------- Dividing two numbers (Overflow version):
  addi $t0, $zero, 30
  addi $t1, $zero, 8
   
  div  $t0, $t1             # This concept is similar to the multiplication of large numbers.
                             # We don't store the value in a register for this example; instead, register lo
                             # takes the quotient and the remainder goes to hi (always).
   
  mflo $s0                  # We are taking the quotient from lo and storing it in $s0
  mfhi $s1                  # We are taking the remainder from hi and storing it in $s1.
   
  li   $v0, 4
  la   $a0, quotient
  syscall
   
  li   $v0, 1
  move $a0, $s0             # Print the quotient (mflo)
  syscall
   
  li   $v0, 11
  li   $a0, '\n'
  syscall
   
  li   $v0, 4
  la   $a0, remainder
  syscall
   
  li   $v0, 1
  move $a0, $s1             # Print the remainder (mfhi)
  syscall
  # --------------------- End

  # Terminate Program
  li $v0, 10
  syscall
