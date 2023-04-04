# Title:  Heap & Interrupts
# Desc:   This program demonstrates how to allocate & fill memory, plus use exceptions.
# Author: Bryce Verberne
# Date:   04/04/2023



# Todo:
# 1. Ask the user how many random numbers they want. 
# 2. Generate random numbers into an array. 
# 3.. Turn our random number generator into its own method to review reentrant subroutines.

.include "MyMacros.asm"

.data
prompt: .asciiz "How many numbers do you want?"
result: .asciiz "Here's your random numbers: "

.text
  .globl main
main:
  
  printString prompt     # Prompt user for integer and read it
  printNewLine
  readInt $t0
  
  # Todo:
  # 1. Save my integer value to heap.
  # 2. Allocate memory in the heap for the array.
  # 3. Create for loop that populates the array.
    
  li $v0, 9              # Syscall to allocate memory
  move $a0, $t0          # Number of bytes to allocate
  syscall                # Resulting address will be in $v0
  move $s0, $v0          # Now, $s0 is a pointer *p to the location in the heap
  
  sw $t0, 0($s0)         # Store the size of our array in heap
  
  # Now, we want to allocate memroy in the heap for the array
  li $v0, 9
  move $a0, $t0
  syscall
  
  move $s1, $v0          # Now $s1 holds the base address of our array
  
  # Allocate one more integer for proof of concept
  li $v0, 9
  li $a0, 1
  syscall
  
  # Allocate $t bytes of memory & store resulting base address in %v
  move $s2, $v0          # $s2 is the base
  sw $t0, 0($s2)         # Store our array size at the end of the array
  
  malloc $t0, $s0        # Allocate %t0 bytes & sotre the base in %s0
  sw $t0, 0($s0)         # Store the size of our array in heap
  
  # Now, we want to allocate memory in heap for the array
  malloc $t0, $s1
  
  # for loop that populates array
  li $t0, 0              # Use $t0 as our i
  lw $t1, 0($s0)         # Load our size of array into $t1
  move $s3, $s1          # Move the base address of our array in $s3 to do Math
  
  # Todo:
  # 1. Test
  # 2. Logic
  # 3. Update
  For: 
    # Test
    slt $t3, $t0, $t1    # As long as $t0 < $t1, keep going
    beq $t0, $zero, end  # Branch if false
    
    # Logic
    # To do a random number, use 42 for a random int.
    li $a0, 42
    li $a1, 100          # Set the range to 100
    li $v0, 42
    syscall
    # The random number should be in $v0
    
    sw $a0, 0($s3)       # Move random number to base
    
    # Update
    addi $t0, $t0, 1
    addi $s3, $s3, 4     # Update the pointer by 4
    b For
    
  end:
  
  
  # Terminating Program
  done