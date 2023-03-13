# Title:  Logical Operators
# Desc:   In this program, I am covering logical operators discussed in the lesson.
# Author: Bryce Verberne
# Date:   02/17/2023


.data
  shiftL: .asciiz "This is our value after using the sll operation: "
  shiftR: .asciiz "This is our value after using the srl operation: "
  andOp:  .asciiz "This is our value after using the AND operation: "
  orOp:   .asciiz "This is our value after using the OR operation: "
  norOp:  .asciiz "This is our value after using the NOR operation: "
  andiOp: .asciiz "This is our value after using the AND immediate operation: "

.text
  .globl main
main:

  #  --------------------- This is a shift left example:
  li $s0, 10        # Load 10 (1010) into register $s0

  sll $t0, $s0, 4   # reg $t0 = reg $s0 << 4 bits -> 1010 +0000 = 160
                  # Tip: If you assign 10 to $t0 and replace this with $s0 in our operation, you will get the same outcome. 
  la $a0, shiftL
  li $v0, 4
  syscall

  move $a0, $t0
  li   $v0, 1
  syscall
  #  --------------------- End of shift left example


  li $a0, '\n'
  li $v0, 11
  syscall
  li $a0, '\n'
  li $v0, 11
  syscall


  # --------------------- This is a shift right example:
  # Divide $s2 by 8 and store the result in $s1
  li $s2, 16        # Loading 16 (1 0000) into $s2

  srl $s1, $s2, 3   # Shift right 3 = 1 0000 -> 1000 > 0100 -> 0010 (2). 16 / 8 = 2.

  la $a0, shiftR
  li $v0, 4
  syscall

  move $a0, $s1
  li   $v0, 1
  syscall

  # --------------------- End of shift right example


  li $a0, '\n'
  li $v0, 11
  syscall
  li $a0, '\n'
  li $v0, 11
  syscall


  #  --------------------- This is an AND operation example:
  li $t0, 5         # Load 5 (0101) into register $t0
  li $t1, 21        # Load 21 (1 0101) into register $t1

  and $t3, $t1, $t0 # Reg $t3 = $t1 & $t0. 2^2 and 2^0 are matching, so our value is 0101 or 5.
  
  la $a0, andOp
  li $v0, 4
  syscall

  move $a0, $t3
  li   $v0, 1
  syscall
  #  --------------------- End of AND example


  li $a0, '\n'
  li $v0, 11
  syscall
  li $a0, '\n'
  li $v0, 11
  syscall


  #  --------------------- This is an OR operation example:
  li $t0, 5        # Load 5 (0101) into regsiter $t0
  li $t1, 8        # Load 8 (1000) into regsiter $t1

  or $t2, $t0, $t1 # Reg $t2 = $t1 | $t0. 2^3, 2^2, and 2^0 are 1, so our value is 1101 or 13.

  la $a0, orOp
  li $v0, 4
  syscall

  move $a0, $t2
  li   $v0, 1
  syscall
  #  --------------------- End of OR example


  li $a0, '\n'
  li $v0, 11
  syscall
  li $a0, '\n'
  li $v0, 11
  syscall


  #  --------------------- This is a NOR operation example:
  li $t0, 10        # Load 10 (1010) into regsiter $t0
  li $t1, 2         # Load 2 (0010) into regsiter $t1

  nor $t2, $t0, $t1 # reg $t2 = ~(reg $t1 | reg $t3). 
                  # 2^3 and 2^1 are 1 giving us a value of (28 0's) 1010, which is inversed to (28 1's) 0101 or -11 due to 2's complement. 

  la $a0, norOp
  li $v0, 4
  syscall

  move $a0, $t2
  li   $v0, 1
  syscall
  # --------------------- End of NOR example


  li $a0, '\n'
  li $v0, 11
  syscall
  li $a0, '\n'
  li $v0, 11
  syscall


  #  --------------------- Here's an example of AND immediate:
  li $t0, 3         # Load 3 (0011) into register $t1

  andi $t1, $t0, 7  # Since $t0 = 3 (0011) and 7 = (0111), $t1 should have the value 0011 or 3.

  la $a0, andiOp
  li $v0, 4
  syscall

  move $a0, $t1
  li   $v0, 1
  syscall
  #  --------------------- End of immediate AND example


  # Terminating Program
  li $v0, 10
  syscall
