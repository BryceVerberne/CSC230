# Title:  Bit Shifting
# Desc:   This program gets an 8 bit number and adds up the total 1's.
# Author: Bryce Verberne
# Data:   03/13/2023



# i.e. given 27 which is 0001 1011 would be 4.
# We need to isolate the lsb. It will either be a 1 or a zero.
# We need to add the lsb to our total.
# Then, we need to shift our # >> to the right one.
# Then, rinse and repeat. 

# 00011011
# 00000001 -> Add to the total
# 00011011 >> 1

# 00001101
# 00000001 >> Add that to the total
# 00001101 >> 1

# 00000110
# 00000000 >> Add that to the total.

.include "MyMacros.asm"

.data
  prompt: .asciiz "Enter a # less than 127: "
  result: .asciiz "The number of bits set is: "

.text
  .globl main
main:
  # Get a number from the user.
  printString prompt
  readInt $t0         # Read the number from the user into $t0.
  
  li $t1, 0           # Let's make $t1 our i value
  li $t2, 0           # Let's make $t2 our accumulator for the # of bits set
  li $s0, 1           # This is how we isolate the lsb. 
   
  for:                # This is the beginning of our for loop
    slti $t3, $t1, 8  # As long as $t1 is < than 8
    beq $t3, $zero, endFor
    
    and $s1, $t0, $s0 # AND our number from the user with 1.
    add $t2, $t2, $s1 # Let's add the results in $s1 to our accumulator. 
    srl $t0, $t0, 1   # Shift our number from the user to the right one bit.
    
    addi $t1, $t1, 1
    b for             # Branch back to the for label
    
  endFor:

  printString result
  printInt $t2
  
      
  # Terminating Program
  done
