# Title:  Etch A Sketch
# Desc:   This program emulates an Etch A Sketch, allowing you to draw with the bitmap display.
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
.eqv THD 0xFFFF000C  # Data to write to the device
.eqv THR 0xFFFF0008  # Device ready check
.eqv KC  0xFFFF0004  # Address for reading data
.eqv KR  0xFFFF0000  # Key Write Request
.eqv BMD 0x10010000  # Base Memory Address (change to heap if needed)

.kdata
  currentColor: .word 0x000000000 # current color of the pixel
  blue:         .word 0x000000FF  # Starting color (blue)
  red:          .word 0x00FF0000  # Color red
  green:        .word 0x0000ff00  # Color green
  olive:        .word 0xFF6B8E23  # Color olive
  white:        .word 0xFFFFFFFF  # Color white
  black:        .word 0x00000000  # Background color (black)
  bmdAddress:   .word 0x10010000  # Base Memory Address (BMD) for storing state

.text
.globl main

# main function
main:
  li $t9, KR      # Load the address for Key Write Request
  li $t8, 2       # Set bit 2 to enable interrupts (0x0010)
  sb $t8, 0($t9)  # Set the interrupt enable bit in KR

  # Get the starting color and store it into our color tracker (currentColor)
  lw $t1, blue
  sw $t1, currentColor

  # Load permanent color values into save registers
  lw $s0, black
  lw $s1, olive
  lw $s2, white

  # Load the Base Memory Address (BMD) into $t2
  lw $t2, bmdAddress

  # Draw a border around the bitmap display and mark the center
  jal createBorder
  jal markCenter


loop:  # Infinite loop to keep the program running
  b loop


# Title: createBorder
# Desc:  This subroutine draws a olive-colored border around the bitmap
createBorder:
  addi $sp, $sp, -4  # Reserve space on the stack for return address and $t2
  sw $t2, 0($sp)     # Store $t2 on the stack
  
  li $t0, 0          # Initialize $t0 to zero
  
  # Draw top border
  topBorder:
    beq $t0, 63, endTop      # If we have drawn 64 pixels, exit the loop
    
    addi $t2, $t2, 4         # Move the buffer pointer one pixel to the right
    sw $s1, 0($t2)           # Write the border color pixel to the buffer
    
    addi $t0, $t0, 1         # Increment pixel counter
    
    b topBorder              # Branch back to topBorder to draw the next pixel
  endTop:
  
  # Draw right border
  li $t0, 0                  # Initialize $t0 to zero
  
  rightBorder:
    beq $t0, 63, endRight    # If we have drawn 64 pixels, exit the loop
    
    addi $t2, $t2, 256       # Move the buffer pointer one pixel down
    sw $s1, 0($t2)           # Write the border color pixel to the buffer
    
    addi $t0, $t0, 1         # Increment pixel counter
    
    b rightBorder            # Branch back to rightBorder to draw the next pixel
  endRight:
  
  # Draw bottom border
  li $t0, 0                  # Initialize $t0 to zero
  
  bottomBorder:
    beq $t0, 63, endBottom   # If we have drawn 64 pixels, exit the loop
    
    addi $t2, $t2, -4        # Move the buffer pointer one pixel to the left
    sw $s1, 0($t2)           # Write the border color pixel to the buffer
    
    addi $t0, $t0, 1         # Increment pixel counter
    
    b bottomBorder           # Branch back to bottomBorder to draw the next pixel
  endBottom:
  
  # Draw left border
  li $t0, 0                  # Initialize $t0 to zero
  
  leftBorder:
    beq $t0, 63, endLeft     # If we have drawn 64 pixels, exit the loop
    
    addi $t2, $t2, -256      # Move the buffer pointer one pixel up
    sw $s1, 0($t2)           # Write the border color pixel to the buffer
    
    addi $t0, $t0, 1         # Increment pixel counter
    
    b leftBorder             # Branch back to leftBorder to draw the next pixel
  endLeft:
  
  lw $t2, 0($sp)    # Restore $t2 from the stack
  addi $sp, $sp, 4  # Release stack
  
  jr $ra
  
  
# Title: markCenter
# Desc:  This subroutine marks the center pixel of a bitmap display.
markCenter:

  # The base address of the bitmap display in MARS is 0x10008000 (4096*8 + 0x8000).
  addi $t2, $t2, 8320  # Calculate the center pixel address: 0x10008000 + 2080 = 0x10008920
  sw $s2, 0($t2)       # Store the value of $s2 at the calculated center pixel address

  jr $ra

  
.ktext 0x80000180
  
  # Exception handling code starts here
  # Save any registers that you modify in the following routines

  # Load the key pressed and print it (useful for debugging)
  li $t0, KC
  lw $s3, 0($t0)
  
  move $a0, $s3
  li $v0, 11
  syscall

  # Call handleKeyInput to handle each keystroke
  jal handleKeyInput

  # Restore saved registers and return to the main loop
  eret


# Title: handleKeyInput
# Desc:  This subroutine handles user input and performs different actions based on the key pressed. 
handleKeyInput:
  # Prolog: Save $ra
  addi $sp, $sp, -4
  sw $ra, 0($sp)

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
  sw $t1, currentColor
  sw $t2, bmdAddress

  # Epilog: Restore $ra and return
  lw $ra, 0($sp)
  addi $sp, $sp, 4
  jr $ra

   
# Key Handling
# ============
# Desc: These subroutines handle key presses and write pixels to a bitmap display.

# Handle 'J': Draw a pixel at the current location and move one to the left
handleKeyJ:
  beq $t3, 31, skipLeft         # Check if at the left border (x-coordinate is 31)
  
    addi $t3, $t3, 1            # Increment $t3 by 1 (move left)
    addi $t4, $t4, -1           # Decrement $t4 by 1 (update remaining space right)
    
    addi $t2, $t2, -4           # Decrement pointer by 4 bytes (move left)
    sw $t1, 0($t2)              # Write a pixel
    
  skipLeft:
  
  jr $ra

# Handle 'K': Draw a pixel at the current location and move down one row
handleKeyK:
  beq $t6, 30, skipDown         # Check if at the bottom border (y-coordinate is 30)
  
    addi $t6, $t6, 1            # Increment $t6 by 1 (move down)
    addi $t5, $t5, -1           # Decrement $t5 by 1 (update remaining space up)
    
    addi $t2, $t2, 256          # Increment pointer by 256 bytes (move down)
    sw $t1, 0($t2)              # Write a pixel
    
  skipDown:
  
  jr $ra

# Handle 'L': Draw a pixel at the current location and move one to the right
handleKeyL:
  beq $t4, 30, skipRight        # Check if at the right border (x-coordinate is 30)
  
    addi $t4, $t4, 1            # Increment $t4 by 1 (move right)
    addi $t3, $t3, -1           # Decrement $t3 by 1 (update remaining space left)
    
    addi $t2, $t2, 4            # Increment pointer by 4 bytes (move right)
    sw $t1, 0($t2)              # Write a pixel
    
  skipRight:
  
  jr $ra

# Handle 'I': Draw a pixel at the current location and move up one row
handleKeyI:
  beq $t5, 31, skipUp           # Check if at the top border (y-coordinate is 31)
  
    addi $t5, $t5, 1            # Increment $t5 by 1 (move up)
    addi $t6, $t6, -1           # Decrement $t6 by 1 (update remaining space down)
    
    addi $t2, $t2, -256         # Decrement pointer by 256 bytes (move up)
    sw $t1, 0($t2)              # Write a pixel
    
  skipUp:
  
  jr $ra

# Handle 'Y': Draw a pixel at the current location and move up and left
handleKeyY:
  beq $t5, 31, skipUpLeft       # Check if at the top border (y-coordinate is 31)
    beq $t3, 31, skipUpLeft     # Check if at the left border (x-coordinate is 31)
    
      addi $t5, $t5, 1          # Increment $t5 by 1 (move up)
      addi $t6, $t6, -1         # Decrement $t6 by 1 (update remaining space down)
      
      addi $t3, $t3, 1          # Increment $t3 by 1 (move left)
      addi $t4, $t4, -1         # Decrement $t4 by 1 (update remaining space right)
    
      addi $t2, $t2, -260       # Update pointer to move up and left
      sw $t1, 0($t2)            # Write a pixel
      
  skipUpLeft:
  
  jr $ra

# Handle 'O': Draw a pixel at the current location and move up and right
handleKeyO:
  beq $t5, 31, skipUpRight      # Check if at the top border (y-coordinate is 31)
    beq $t4, 30, skipUpRight    # Check if at the right border (x-coordinate is 30)
    
      addi $t5, $t5, 1          # Increment $t5 by 1 (move up)
      addi $t6, $t6, -1         # Decrement $t6 by 1 (update remaining space down)
      
      addi $t4, $t4, 1          # Increment $t4 by 1 (move right)
      addi $t3, $t3, -1         # Decrement $t3 by 1 (update remaining space left)
      
      addi $t2, $t2, -252       # Update pointer to move up and right
      sw $t1, 0($t2)            # Write a pixel
      
  skipUpRight:
  
  jr $ra

# Handle 'N': Draw a pixel at the current location and move down and left
handleKeyN:
  beq $t6, 30, skipDownLeft     # Check if at the bottom border (y-coordinate is 30)
    beq $t3, 31, skipDownLeft   # Check if at the left border (x-coordinate is 31)
    
      addi $t6, $t6, 1          # Increment $t6 by 1 (move down)
      addi $t5, $t5, -1         # Decrement $t5 by 1 (update remaining space up)
      
      addi $t3, $t3, 1          # Increment $t3 by 1 (move left)
      addi $t4, $t4, -1         # Decrement $t4 by 1 (update remaining space right)
      
      addi $t2, $t2, 252        # Update pointer to move down and left
      sw $t1, 0($t2)            # Write a pixel
      
  skipDownLeft:
  
  jr $ra

# Handle 'M': Draw a pixel at the current location and move down and right
handleKeyM:
  beq $t6, 30, skipDownRight    # Check if at the bottom border (y-coordinate is 30)
    beq $t4, 30, skipDownRight  # Check if at the right border (x-coordinate is 30)
    
      addi $t6, $t6, 1          # Increment $t6 by 1 (move down)
      addi $t5, $t5, -1         # Decrement $t5 by 1 (update remaining space up)
      
      addi $t4, $t4, 1          # Increment $t4 by 1 (move right)
      addi $t3, $t3, -1         # Decrement $t3 by 1 (update remaining space left)
      
      addi $t2, $t2, 260        # Update pointer to move down and right
      sw $t1, 0($t2)            # Write a pixel
      
  skipDownRight:
  
  jr $ra

# Handle 'D': Delete the current pixel, but do not move
handleKeyD:
  sw $s0, 0($t2)                # Write a background-colored pixel (delete)
  jr $ra

# Handle 'Q': Exit the program
handleKeyQ:
  li $v0, 10                    # Set syscall code for exit
  syscall                       # Perform the syscall
  jr $ra


# Pixel Colors
# ============
# Desc: These subroutines set the color of the pixels.

# Set the color to red
setColorRed:
  lw $t1, red   # Load the red color value
  jr $ra
  
# Set the color to blue
setColorBlue:
  lw $t1, blue  # Load the blue color value
  jr $ra
  
# Set the color to green
setColorGreen:
  lw $t1, green # Load the green color value
  jr $ra
