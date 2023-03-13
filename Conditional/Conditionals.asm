# Title:  Conditionals
# Desc:   In this program, I am covering conditionals, which were discussed in our lesson.
# Author: Bryce Verberne
# Date:   02/17/2023



.data
branch:    .asciiz "This is the result of our conditional branch: "
loopEntry: .asciiz "I'm in a loop!"
value:     .asciiz "This is the current value of $t1: "
loopExit:  .asciiz "I've left the loop... finally."

.text
  .globl main
main:

  # --------------------- This is a conditional branch example:
  li $s0, 5   # Load $s0 with the value 5
  li $s1, 5   # Load $s1 with the value 7

  beq $s0, $s1, Else   # This statement says that we will branch to the else statement if $s0 = $s1
    add $s2, $s0, $s1   # If $s0 ≠ $s1, then $s2 = $s0 + $s1
    j Exit
    Else: subi $s2, $s1, 1   # If $s0 = $s1, then $s2 = $s1 - 1
  Exit:

  la $a0, branch
  li $v0, 4
  syscall

  move $a0, $s2
  li   $v0, 1
  syscall
  # --------------------- End of conditional branch example:


  li $a0, '\n'
  li $v0, 11
  syscall
  li $a0, '\n'
  li $v0, 11
  syscall


  # --------------------- This is loop example:
  li $t0, 5   # Load $s0 with the value 5
  li $t1, 0   # Load $s1 with the value 0

  Loop: 
    beq $t0, $t1, exit   # This essentially means, "if $s0 ≠ $s1, iterate.
  
    la $a0, loopEntry    # Print: "I'm in a loop!"
    li $v0, 4
    syscall
  
    addi $t1, $t1, 1     # Incrementing $s1 by 1 to eventually exit the loop.
  
    li $a0, '\n'         # Print newline
    li $v0, 11
    syscall
  
    la $a0, value        # Print: "This is the current value of $t1: "
    li $v0, 4
    syscall
  
    move $a0, $t1        # Print value of $t1
    li   $v0, 1
    syscall
  
    li $a0, '\n'         # Print newline
    li $v0, 11
    syscall
  
    li $a0, '\n'         # Print newline
    li $v0, 11
    syscall
  
    j Loop
  exit:

  la $a0, loopExit
  li $v0, 4
  syscall
  # --------------------- End of loop example:


  li $a0, '\n'
  li $v0, 11
  syscall
  li $a0, '\n'
  li $v0, 11
  syscall


  # Terminating program
  li $v0, 10
  syscall
