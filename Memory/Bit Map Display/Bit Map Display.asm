# Title:  Bit Map Display
# Desc:   In this program, we are drawing pixels.
# Author: Bryce Verberne
# Data:   02/21/2023



.include "MyMacros.asm"

.eqv BASE_ADDRESS 0x10010000   # The Base Address of our display
.eqv RED   0x00FF0000
.eqv GREEN 0x0000FF00
.eqv BLUE  0x000000FF

.text
 li $s0, BASE_ADDRESS          # Bitmap Display is a one dimensional array, that wraps.
                               # We use a base address and an offset to write to it.
   
 li $t5, RED
 li $t6, GREEN
 li $t7, BLUE
   
  sw $t5, 0($s0)
  sw $t6, 4($s0)
  sw $t7, 8($s0)
  sw $t5, 128($s0)
   
  # Write a for loop that prints the left eyebrow
  li $t0, 0                    # $t0 is our i variable
  li $t1, 10                   # $t1 is our limit
  addi $s1, $s0, 680
   
  forLeft: 
    slt $t2, $t0, $t1          # Set $t2 if i < 10
    beq $t2, $zero, endLeft
      
    sw $t5, 0($s1)             # Write to the pixel addressed by $s1

    addi $t0, $t0, 1           # i++
    addi $s1, $s1, 4           # We can't change the offset, so we change the BASE
      
    b forLeft
  endLeft:
  
  # Write a for loop that prints the right eyebrow
  addi $s1, $s1, 4             # Create the bridge in our eybrow before we continue.
  li $t0, 0                    # $t0 is our i variable
 
  forRight:
    slt $t2, $t0, $t1          # Set $t2 if i < 10
    beq $t2, $zero, endRight
    
    sw $t5, 0($s1)             # Write to the prxel addressed by $s1
    
    addi $t0, $t0, 1            # i++
    addi $s1, $s1, 4            # We can't change the offset, so we change the BASE
    
    b forRight
  endRight:
   
   
  # Terminating program
  done