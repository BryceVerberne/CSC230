# Title:  Count Down
# Desc:   This program displays a countdown from 99 to 1 on a seven-segment display
# Author: Bryce Verberne
# Title:  04/12/2023



# This tool is composed of 3 parts : 
#  1. Two seven-segment displays
#  2. A hexadecimal keyboard
#  3. A counter 

.include "MyMacros.asm"

#  Seven segment display
#  Byte value at address 0xFFFF0010 : command right seven segment display 
#  Byte value at address 0xFFFF0011 : command left seven segment display 
#  Each bit of these two bytes are connected to segments (bit 0 for a segment, 1 for b segment and 7 for point 
.eqv SEG1 0xFFFF0010
.eqv SEG2 0xFFFF0011

# Create number segments 0-9
.eqv ZERO  0x3f  # Binary: 0011 1111
.eqv ONE   0x06  # Binary: 0000 0110
.eqv TWO   0x5b  # Binary: 0101 1011
.eqv THREE 0x4f  # Binary: 0100 1111
.eqv FOUR  0x66  # Binary: 0110 0110
.eqv FIVE  0x6d  # Binary: 0110 1101
.eqv SIX   0x7d  # Binary: 0111 1101
.eqv SEVEN 0x07  # Binary: 0000 0111
.eqv EIGHT 0x7f  # Binary: 0111 1111
.eqv NINE  0x6f  # Binary: 0110 1111

.data
  nums: .byte ZERO, ONE, TWO, THREE, FOUR, FIVE, SIX, SEVEN, EIGHT, NINE
  
.text
 .globl main
main:
  addi $s0, $zero, SEG1   # $s0 now holds the address of segment 1
  addi $s1, $zero, SEG2   # $s1 now holds the address of segment 2
  
  la $s2, nums            # Base of our list of numbers
  
  add $t0, $zero, $zero   # Iterator (++i)
  addi $s3, $zero, 10     # Loop stopping value
  
  # Number Segment tester
  forLoop:
    # Condition 
    beq $t0, $s3, endLoop # If $t0 = $s0 end the loop
    
    # Logic
    lb $t0, 0($s2)        # Load ZERO into $t0
    sb $t0, 0($s0)        # Write it to segment 1
    sleep
    
    # Prep
    addi $t0, $t0, 1      # Iterate $t0
    addi $s2, $s2, 1      # Cycle through the array
    
    b forLoop
  endLoop:
  
    
  # Terminate Program  
  done