# Title:  Heap & Interrupts
# Desc:   This program demonstrates how to allocate & fill memory, plus use exceptions.
# Author: Bryce Verberne
# Date:   04/04/2023



# Program functions:
#  1. Ask the user how many random numbers they want. 
#  2. Generate random numbers into an array. 
#  3. Turn our random number generator into its own method to review reentrant subroutines.

.include "MyMacros.asm"

.data
  prompt: .asciiz "How many numbers do you want?"
  result: .asciiz "Here are your random numbers: "
  numMes: .asciiz "\nNumbers: "
  comma:  .asciiz ", "
  avgMes: .asciiz "\nAverage: "
  minMes: .asciiz "\nMin: "
  maxMes: .asciiz "\nMax: "
  

.text
  .globl main
main:

  jal getRandomNumbers
  
  move $a0, $v0             # Move the size of our array in $a0
  move $a1, $v1             # Move the base address of our array into $a1
  jal printRandomNumbers
  
  
  # Terminating Program
  done


# getRandomNumbers
#  - Receives no parameters
#  - Returns the size of the array in $v0
#  - Returns the base address of the array in $v1
getRandomNumbers:
  
  # Prolog to save state - Save $ra & any $s# that are used
  addi $sp, $sp, -20        # Allocate room on the stack (5 words)
    
  # Store our values
  sw $ra, 0($sp)
  sw $s0, 4($sp)
  sw $s1, 8($sp)
  sw $s2, 12($sp)
  sw $s3, 16($sp)
  
  printString prompt        # Prompt user for integer and read it
  printNewLine
  readInt $t0
  
  # Following Implementations:
  #  1. Save the integer value to heap.
  #  2. Allocate memory in the heap for the array.
  #  3. Create for loop that populates the array.
    
  # Allocate memory 
  malloc $t0, $s0           # Allocate %t0 bytes & store the base in %s0
  sw $t0, 0($s0)            # Store the size of our array in heap
  
  malloc $t0, $s1           # Allocate memory in heap for the array
  
  # for loop that populates array
  li $t0, 0                 # Use $t0 as our i
  lw $t1, 0($s0)            # Load our size of array into $t1
  move $s3, $s1             # Move the base address of our array in $s3 to do Math
  
  For: 
    # Parts:
    #  1. Test
    #  2. Logic
    #  3. Update
    
    # Test
    slt $t3, $t0, $t1       # As long as $t0 < $t1, keep going
    beq $t3, $zero, end     # Branch if true
    
    # Logic
    # To do a random number, use 42 for a random int.
    li $a1, 100             # Set the range to 100
    li $v0, 42
    syscall
    # The random number should be in $v0
    
    sw $v0, 0($s3)          # Move random number to base
    
    # Update
    addi $t0, $t0, 1
    addi $s3, $s3, 4        # Update the pointer by 4
    b For
    
  end:
  
  # Epilog - Set up return values & restores state
  lw   $v0, 0($s0)          # Pass the data written into $v0
  move $v1, $s1             # Load our base address into $v1
  
  lw $ra, 0($sp)
  lw $s0, 4($sp)
  lw $s1, 8($sp)
  lw $s2, 12($sp)
  lw $s3, 16($sp)
  
  addi $sp, $sp, 20         # Allocate room on the stack (5 words)
  
  jr $ra
  
  
# printRandomNumbers
#  - Passed the number of random numbers in $a0
#  - Passed the base address of the array in $a1
#  - Uses a pointer to iterate through the array & print each element
#  - Also prints the average, min, & max
#  - Returns nothing

printRandomNumbers:
  # Parts:
  #  1. Prolog
  #  2. Logic
  #  3. Epilog
    
  # Prolog
  addi $sp, $sp, -12
  
  sw $ra, 0($sp)            # Store $ra in stack
  sw $a0, 4($sp)            # Store $a0 in stack
  sw $a1, 8($sp)            # Store $s1 in stack
  
  # Store values of arguments in $t0 & $t1, so they are not overwritten
  move $t0, $a0
  move $t1, $a1
  
  # Clear $t2
  add $t2, $zero, $zero     # i = 0
    
  # Logic
  printInt $t0              # Print the number of numbers
  printNewLine
  printHex $t1              # Print the base address
    
  # Print 'numMes1' - "Numbers: "
  printString numMes
    
  while:
    slt $t3, $t2, $t0       # While $t2 < $t0, continue...
    beq $t3, $zero, endLoop # If $t3 = 0, branch to 'endLoop'
    
    lw $t4, 0($t1)          # Load the current array value into $t4
    
    # Print array value
    printInt $t4
    
    # Print comma
    printString comma
    
    # Add 4 to our base address to point to the next array element
    addi $t1, $t1, 4
    
    # Increment $t2
    addi $t2, $t2, 1
    
    b while
  endLoop:
    
    
  # Epilog
  
  jr $ra
