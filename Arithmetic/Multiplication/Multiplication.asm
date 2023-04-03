# Title:  Multiplication
# Desc:   In this program, I am covering various multiplication examples.
# Author: Bryce Verberne
# Date:   02/19/2023



.data
  multiply1:   .asciiz "The product of 10 x 4 is: "
  multiply2:   .asciiz "The product of 2000 x 10 is: "
  multiply3:   .asciiz "The product of 4 x 4 is: "
   
.text
  .globl main
main:
   
  # --------------------- Multiplying two numbers with mul:
  # We can use "mul", "mult", and "sll" to multiply in MIPS
  addi $s0, $zero, 10   # We just stored the value 10 in $s0
  addi $s1, $zero, 4    # We just stored the value 4 in $s1
   
  mul  $t0, $s0, $s1    # We are performing the operation $s0 x $s1 and storing it in $t0
                         # The instruction "mul" is unique since you can only multiply two 16 bit numbers (32 bit word)
  li   $v0, 4
  la   $a0, multiply1
  syscall
   
  li   $v0, 1
  move $a0, $t0
  syscall
  # --------------------- End
   
    
  li   $v0, 11
  li   $a0, '\n'
  syscall
   
   
  # --------------------- Multiplying two numbers with mult:
  addi $t0, $zero, 2000
  addi $t1, $zero, 10
   
  mult $t0, $t1         # Where are we storing the product?
                         # The result stores in lo and hi, which allows us to multiply numbers larger than 16 bits
   
  mflo $s0              # This takes the value from the lo register and stores it in $s0
                         # If the product is larger, we will have to get the value from both lo and hi (mfhi)
   
  li   $v0, 4
  la   $a0, multiply2
  syscall
   
  li   $v0, 1
  move $a0, $s0
  syscall
  # --------------------- End
   
   
  li   $v0, 11
  li   $a0, '\n'
  syscall
   
   
  # --------------------- Multiplying two numbers with sll (shift left logical):
  # sll lets you do multiplication in an efficient manner
  addi $s0, $zero, 4
   
  sll  $t0, $s0, 2       # This instruction will shift $s0 left twice, which is equivalent to 2^2 x 4(value of $s0)
                          # This is equivalent to 4 x 4 = 16
   
  li   $v0, 4
  la   $a0, multiply3
  syscall
   
  li   $v0, 1
  move $a0, $t0
  syscall
  # --------------------- End
   
   
  # Terminating program
  li $v0, 10
  syscall
