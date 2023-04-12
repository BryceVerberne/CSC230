# Title:  Count Down
# Desc:   This program displays a countdown from 99 to 1 on a seven-segment display
# Author: Bryce Verberne
# Title:  04/12/2023



# This tool is composed of 3 parts : 
#  1. Two seven-segment displays
#  2. A hexadecimal keyboard
#  3. Acounter 

#  Seven segment display
#  Byte value at address 0xFFFF0010 : command right seven segment display 
#  Byte value at address 0xFFFF0011 : command left seven segment display 
#  Each bit of these two bytes are connected to segments (bit 0 for a segment, 1 for b segment and 7 for point 
.eqv SEG1 0xFFFF0010
.eqv SEG2 0xFFFF0011
.eqv SEVEN 0x07      # Is a seven a seven?  00000111 in binary
.eqv EIGHT 0x7f      # Is this the bit pattern for 8?
.eqv ONE   0x06

.macro SLEEP
  li $a0, 1000
  li $v0, 32
  syscall
.end_macro
.data
  nums: .byte ONE, SEVEN, EIGHT
.text
 .globl main
main:
  addi $s0, $zero, SEG1   # $s0 now holds the address of segment 1
  addi $s1, $zero, SEG2   # $s1 now holds the address of segment 2

  la $s2, nums  # Base of our list of numbers
  
  lb $t0, 0($s2)  # Load ONE into $t0
  sb $t0, 0($s0)  # Write it to segment 1
  SLEEP
  lb $t0, 1($s2)  # Load SEVEN into $t0
  sb $t0, 0($s0)  # Write it to segment 1
  SLEEP
  lb $t0, 2($s2)  # Load SEVEN into $t0
  sb $t0, 0($s0)  # Write it to segment 1
  SLEEP    
  li $v0, 10
  syscall