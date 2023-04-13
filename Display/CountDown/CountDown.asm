# Title:  Count Down
# Desc:   This program displays a countdown from 99 to 0 on a seven-segment display
# Author: Bryce Verberne
# Title:  04/12/2023



# Tool Composition: 
#  1. Two seven-segment displays
#  2. A hexadecimal keyboard
#  3. A counter 

#  Seven segment display:
#   - Byte value at address 0xFFFF0010 : command right seven segment display 
#   - Byte value at address 0xFFFF0011 : command left seven segment display 
#     - Each bit of these two bytes are connected to segments
.eqv R_SEG 0xFFFF0010
.eqv L_SEG 0xFFFF0011

# Create number segments 0-9
.eqv ZERO  0x3f
.eqv ONE   0x06
.eqv TWO   0x5b
.eqv THREE 0x4f
.eqv FOUR  0x66
.eqv FIVE  0x6d
.eqv SIX   0x7d
.eqv SEVEN 0x07
.eqv EIGHT 0x7f
.eqv NINE  0x6f

.include "MyMacros.asm"

.data
  nums: .byte NINE, EIGHT, SEVEN, SIX, FIVE, FOUR, THREE, TWO, ONE, ZERO
  
.text
 .globl main
main:
  addi $s0, $zero, R_SEG    # $s0 now holds the address of segment 1
  addi $s1, $zero, L_SEG    # $s1 now holds the address of segment 2
   
  # Base of our list of numbers for tensLoop & onesLoop
  la $s2, nums
  la $s3, nums
  
  # Set the loop stopping value
  addi $s4, $zero, 10
  
  # This loop displays to the L_SEG (tens place)
  tensLoop:
    # Condition 
    beq $t0, $s4, endTens   # If $t0 = $s4 (i=10) end the loop
    
    # Logic
    lb $t2, 0($s2)          # Load the current number segment into $t2
    sb $t2, 0($s1)          # Write $t2 to L_SEG
    
    # Reset nums address & iterator for onesLoop
    la $s3, nums
    li $t1, 0
    
    # This loop displays to the R_SEG (ones place)
    onesLoop:
     # Condition 
     beq $t1, $s4, endOnes  # If $t1 == $s4 (j=10) end the loop 
     
     # Logic
     lb $t3, 0($s3)         # Load the current number segment into $t3
     sb $t3, 0($s0)         # Write $t3 to R_SEG
     sleep
     
     # Prep for next iteration
     addi $t1, $t1, 1       # Iterate $t1 (++j)
     addi $s3, $s3, 1       # Cycle through the array
     
     b onesLoop
   endOnes:
    
    # Prep for next iteration
    addi $t0, $t0, 1        # Iterate $t2 (++i)
    addi $s2, $s2, 1        # Cycle through the array
    
    b tensLoop
  endTens:
  
    
  # Terminate Program  
  done