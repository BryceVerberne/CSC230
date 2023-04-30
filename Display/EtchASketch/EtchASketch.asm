# Title:  Etch A Sketch
# Desc:   This program explores MMIO with the incorporation of interrupts
# Author: Bryce Verberne
# Title:  04/18/2023



# This program supports the following keys:
# J - Draw a pixel at the current location and move one to the left
# K - Draw a pixel at the current location and move down one
# L - Draw a pixel at the current location and move right
# I - Draw a pixel at the current location and move up
# Y - Draw a pixel at the current location and move up/left
# O - Draw a pixel at the current location and move up/right
# N - Draw a pixel at the current location and move down/left
# M - Draw a pixel at the current location and move down/right
# D - Delete the pixel at the current location, but do not move
# Q - Exit the program

# R - Changes current color to Red
# G - Changes current color to Green
# B - Changes current color to Blue

# Define constants for memory-mapped I/O addresses
.eqv THD 0xffff000c  # Data to write to the device
.eqv THR 0xffff0008  # Device ready check
.eqv KC  0xffff0004  # Address for reading data
.eqv KR  0xffff0000  # Key Write Request
.eqv BMD 0x10010000  # Base Memory Address (change to heap if needed)

.text
.globl main
main:
  li $t1, KR          # Load the address for Key Write Request
  li $t5, 2           # Set bit 2 to enable interrupts (0x0010)
  sb $t5, 0($t1)      # Set the interrupt enable bit in KR

loop:
  b loop

.kdata
  blue:       .word 0x000000ff  # Starting color (blue)
  red:        .word 0x00ff0000  # Color red
  green:      .word 0x0000ff00  # Color green
  bmdAddress: .word 0x10010020  # Base Memory Address (BMD) for storing state
  baseColor:  .word 0x00000000  # Background color (black)

.ktext 0x80000180
  # Load the baseColor into $t9
  lw $t9, baseColor
  
  # Get the starting color
  jal setColorBlue

  # Exception handling code starts here
  # Save any registers that you modify in the following routines

  # Load the key pressed and print it (useful for debugging)
  li $t0, KC
  lw $s0, 0($t0)
  
  move $a0, $s0
  li $v0, 11
  syscall

  # Call handleKeyInput to handle each keystroke
  jal handleKeyInput

  # Restore saved registers and return to the main loop
  eret


handleKeyInput:
  # Prolog: Save $ra
  addi $sp, $sp, -4
  sw $ra, 0($sp)

  # Load state
  lw $t4, bmdAddress

  # Switch statement based on the key pressed ($a0)
  # Replace the 'J', 'K', etc. with the desired keys for each case
  seq $t0, $a0, 'J'
  beq $t0, $zero, checkK
  jal handleKeyJ
  b endSwitch

checkK:
  seq $t0, $a0, 'K'
  beq $t0, $zero, checkL
  jal handleKeyK
  b endSwitch

checkL:
  seq $t0, $a0, 'L'
  beq $t0, $zero, checkI
  jal handleKeyL
  b endSwitch

checkI:
  seq $t0, $a0, 'I'
  beq $t0, $zero, checkY
  jal handleKeyI
  b endSwitch

checkY:
  seq $t0, $a0, 'Y'
  beq $t0, $zero, checkO
  jal handleKeyY
  b endSwitch

checkO:
  seq $t0, $a0, 'O'
  beq $t0, $zero, checkN
  jal handleKeyO
  b endSwitch

checkN:
  seq $t0, $a0, 'N'
  beq $t0, $zero, checkM
  jal handleKeyN
  b endSwitch

checkM:
  seq $t0, $a0, 'M'
  beq $t0, $zero, checkD
  jal handleKeyM
  b endSwitch

checkD:
  seq $t0, $a0, 'D'
  beq $t0, $zero, checkQ
  jal handleKeyD
  b endSwitch

checkQ:
  seq $t0, $a0, 'Q'
  beq $t0, $zero, checkR
  jal handleKeyQ
  b endSwitch
  
checkR:
  seq $t0, $a0, 'R'
  beq $t0, $zero, checkB
  jal setColorRed
  b endSwitch
  
checkB:
  seq $t0, $a0, 'B'
  beq $t0, $zero, checkG
  jal setColorBlue
  b endSwitch
  
checkG:
  seq $t0, $a0, 'G'
  beq $t0, $zero, endSwitch
  jal setColorGreen
  b endSwitch

endSwitch:
  # Save the new state
  sw $t6, blue
  sw $t4, bmdAddress

  # Epilog: Restore $ra and return
  lw $ra, 0($sp)
  addi $sp, $sp, 4
  jr $ra

   
# Key Handling
# ============

# Handle 'J': Draw a pixel at the current location and move one to the left
handleKeyJ:
  addi $t4, $t4, -4             # Decrement pointer by 4 bytes (move left)
  sw $t6, 0($t4)                # Write a pixel
  jr $ra

# Handle 'K': Draw a pixel at the current location and move down one row
handleKeyK:
  addi $t4, $t4, 256            # Increment pointer by 256 bytes (move down)
  sw $t6, 0($t4)                # Write a pixel
  jr $ra

# Handle 'L': Draw a pixel at the current location and move one to the right
handleKeyL:
  addi $t4, $t4, 4              # Increment pointer by 4 bytes (move right)
  sw $t6, 0($t4)                # Write a pixel
  jr $ra

# Handle 'I': Draw a pixel at the current location and move up one row
handleKeyI:
  addi $t4, $t4, -256           # Decrement pointer by 256 bytes (move up)
  sw $t6, 0($t4)                # Write a pixel
  jr $ra

# Handle 'Y': Draw a pixel at the current location and move up and left
handleKeyY:
  addi $t4, $t4, -260           # Update pointer to move up and left
  sw $t6, 0($t4)                # Write a pixel
  jr $ra

# Handle 'O': Draw a pixel at the current location and move up and right
handleKeyO:
  addi $t4, $t4, -252           # Update pointer to move up and right
  sw $t6, 0($t4)                # Write a pixel
  jr $ra

# Handle 'N': Draw a pixel at the current location and move down and left
handleKeyN:
  addi $t4, $t4, 252            # Update pointer to move down and left
  sw $t6, 0($t4)                # Write a pixel
  jr $ra

# Handle 'M': Draw a pixel at the current location and move down and right
handleKeyM:
  addi $t4, $t4, 260            # Update pointer to move down and right
  sw $t6, 0($t4)                # Write a pixel
  jr $ra

# Handle 'D': Delete the current pixel, but do not move
handleKeyD:
  sw $t9, 0($t4)                # Write a background-colored pixel (delete)
  jr $ra

# Handle 'Q': Exit the program
handleKeyQ:
  li $v0, 10                    # Set syscall code for exit
  syscall                       # Perform the syscall
  jr $ra                        # Return to caller


# Pixel Colors
# ============

setColorRed:
  lw $t6, red
  jr $ra
  
setColorBlue:
  lw $t6, blue
  jr $ra
  
setColorGreen:
  lw $t6, green
  jr $ra