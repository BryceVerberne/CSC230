# Title:  Etch A Sketch
# Desc:   This program emulates an Etch A Sketch, allowing you to draw with the bitmap display.
# Author: Bryce Verberne
# Title:  05/06/2023



# === Overview ===
# This MIPS assembly program emulates an Etch A Sketch toy, allowing users to
# draw on the bitmap display with various colors and shades.
#
# === Bitmap Display Settings ===
# - Unit Width in Pixels:     8
# - Unit Height in Pixels:    8
# - Display Width in Pixels:  512
# - Display Height in Pixels: 512
# - Base address for display: 0x10040000 (heap)
#
# === Controls ===
# Movement & Drawing:
#   j - Move left and draw
#   k - Move down and draw
#   l - Move right and draw
#   i - Move up and draw
#   y - Move up/left and draw
#   o - Move up/right and draw
#   n - Move down/left and draw
#   m - Move down/right and draw
#   d - Delete pixel at current location
#   q - Quit the program
#
# Color Selection:
#   r - Red
#   g - Green
#   b - Blue
#
# === Additional Features ===
# 1. Pressing the same color key repeatedly increases the gradient by 30 up to
#    8 times, allowing for a variety of shades (Note: Blue is very dark when 
#    initially changing its gradient).
# 2. Holding shift while pressing any movement key (j, k, l, i, y, o, n, m)
#    draws pixels continuously in the specified direction until reaching the border.


.eqv THD 0xFFFF000C  # Data to write to the device
.eqv THR 0xFFFF0008  # Device ready check
.eqv KC  0xFFFF0004  # Address for reading data
.eqv KR  0xFFFF0000  # Key Write Request
.eqv BMD 0x10040000  # Base Memory Address (heap)

.kdata
  currentColor: .word 0x000000000  # Current color of the pixel
  blue:         .word 0x000000FF   # Starting color (blue)
  red:          .word 0x00FF0000   # Color red
  green:        .word 0x0000ff00   # Color green
  olive:        .word 0xFF6B8E23   # Color olive
  white:        .word 0xFFFFFFFF   # Color white
  black:        .word 0x00000000   # Background color (black)
  bmdAddress:   .word 0x10040000   # Base Memory Address (BMD) for storing state
  
  colorOffset:  .word 0            # Gradient counter for color changes
  upInput:      .word 0            # Tracks up movement
  downInput:    .word 0            # Tracks down movement
  rightInput:   .word 0            # Tracks right movement
  leftInput:    .word 0            # Tracks left movement

.text
  .globl main
main:
  li $t9, KR      # Load the address for Key Write Request
  li $t8, 2       # Set bit 2 to enable interrupts (0x0010)
  sb $t8, 0($t9)  # Set the interrupt enable bit in KR

  # Get the starting color (blue) and store it into our color tracker (currentColor)
  lw $s0, blue
  sw $s0, currentColor
  
  # Load the Base Memory Address (BMD) into $s1
  lw $s1, bmdAddress

  # Load permanent color values into save registers for later use
  lw $s2, white
  lw $s3, black
  lw $s4, olive

  # Draw a border around the bitmap display and mark the center
  jal createBorder
  jal markCenter

loop:  # Infinite loop to keep the program running
  b loop



# === Bitmap Display Setup Subroutines ===
# Desc: The following subroutines set up the initial state of the bitmap display by
#       creating a border around the drawing area and marking the center pixel.

# This subroutine draws a olive-colored border around the bitmap
createBorder:
  addi $sp, $sp, -4  # Reserve space on the stack for return address and $s1
  sw $s1, 0($sp)     # Store $s1 on the stack
  
  # Draw top border
  topBorder:
    beq $t0, 63, endTop      # If we have drawn 64 pixels, exit the loop
    
    addi $s1, $s1, 4         # Move the buffer pointer one pixel to the right
    sw $s4, 0($s1)           # Write the border color pixel to the buffer
    
    addi $t0, $t0, 1         # Increment pixel counter
    
    b topBorder              # Branch back to topBorder to draw the next pixel
  endTop:
  
  # Draw right border
  li $t0, 0                  # Initialize $t0 to zero
  
  rightBorder:
    beq $t0, 63, endRight    # If we have drawn 64 pixels, exit the loop
    
    addi $s1, $s1, 256       # Move the buffer pointer one pixel down
    sw $s4, 0($s1)           # Write the border color pixel to the buffer
    
    addi $t0, $t0, 1         # Increment pixel counter
    
    b rightBorder            # Branch back to rightBorder to draw the next pixel
  endRight:
  
  # Draw bottom border
  li $t0, 0                  # Initialize $t0 to zero
  
  bottomBorder:
    beq $t0, 63, endBottom   # If we have drawn 64 pixels, exit the loop
    
    addi $s1, $s1, -4        # Move the buffer pointer one pixel to the left
    sw $s4, 0($s1)           # Write the border color pixel to the buffer
    
    addi $t0, $t0, 1         # Increment pixel counter
    
    b bottomBorder           # Branch back to bottomBorder to draw the next pixel
  endBottom:
  
  # Draw left border
  li $t0, 0                  # Initialize $t0 to zero
  
  leftBorder:
    beq $t0, 63, endLeft     # If we have drawn 64 pixels, exit the loop
    
    addi $s1, $s1, -256      # Move the buffer pointer one pixel up
    sw $s4, 0($s1)           # Write the border color pixel to the buffer
    
    addi $t0, $t0, 1         # Increment pixel counter
    
    b leftBorder             # Branch back to leftBorder to draw the next pixel
  endLeft:
  
  lw $s1, 0($sp)    # Restore $s1 from the stack
  addi $sp, $sp, 4  # Release stack
  
  jr $ra
  
  
# This subroutine marks the center pixel of a bitmap display.
markCenter:

  addi $s1, $s1, 8320  # Calculate the center pixel address: 0x10008000 + 2080 = 0x10008920
  sw $s2, 0($s1)       # Store the value of $s2 at the calculated center pixel address

  jr $ra

  
.ktext 0x80000180   # Exception handling code starts here

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
  
  
  
# === Handle Key Input ===
# Desc: This subroutine handles user input and performs different actions based on the key pressed. 
handleKeyInput:
  # Prolog: Save $ra
  addi $sp, $sp, -4
  sw $ra, 0($sp)

  # Switch statement based on the key pressed ($a0)
  # Replace the 'j', 'k', etc. with the desired keys for each case
  seq $t0, $a0, 'j'
  beq $t0, $zero, checkK
  jal handleKeyJ
  b endSwitch

checkK:
  seq $t0, $a0, 'k'
  beq $t0, $zero, checkL
  jal handleKeyK
  b endSwitch

checkL:
  seq $t0, $a0, 'l'
  beq $t0, $zero, checkI
  jal handleKeyL
  b endSwitch

checkI:
  seq $t0, $a0, 'i'
  beq $t0, $zero, checkY
  jal handleKeyI
  b endSwitch

checkY:
  seq $t0, $a0, 'y'
  beq $t0, $zero, checkO
  jal handleKeyY
  b endSwitch

checkO:
  seq $t0, $a0, 'o'
  beq $t0, $zero, checkN
  jal handleKeyO
  b endSwitch

checkN:
  seq $t0, $a0, 'n'
  beq $t0, $zero, checkM
  jal handleKeyN
  b endSwitch

checkM:
  seq $t0, $a0, 'm'
  beq $t0, $zero, checkD
  jal handleKeyM
  b endSwitch

checkD:
  seq $t0, $a0, 'd'
  beq $t0, $zero, repeatJ
  jal handleKeyD
  b endSwitch

repeatJ:
  seq $t0, $a0, 'J'
  beq $t0, $zero, repeatK
  jal drawKeyJ
  b endSwitch

repeatK:
  seq $t0, $a0, 'K'
  beq $t0, $zero, repeatL
  jal drawKeyK
  b endSwitch

repeatL:
  seq $t0, $a0, 'L'
  beq $t0, $zero, repeatI
  jal drawKeyL
  b endSwitch

repeatI:
  seq $t0, $a0, 'I'
  beq $t0, $zero, repeatY
  jal drawKeyI
  b endSwitch

repeatY:
  seq $t0, $a0, 'Y'
  beq $t0, $zero, repeatO
  jal drawKeyY
  b endSwitch

repeatO:
  seq $t0, $a0, 'O'
  beq $t0, $zero, repeatN
  jal drawKeyO
  b endSwitch

repeatN:
  seq $t0, $a0, 'N'
  beq $t0, $zero, repeatM
  jal drawKeyN
  b endSwitch

repeatM:
  seq $t0, $a0, 'M'
  beq $t0, $zero, checkQ
  jal drawKeyM
  b endSwitch
  
checkQ:
  seq $t0, $a0, 'q'
  beq $t0, $zero, checkR
  jal handleKeyQ
  b endSwitch
  
checkR:
  seq $t0, $a0, 'r'
  beq $t0, $zero, checkB
  jal setColorRed
  b endSwitch
  
checkB:
  seq $t0, $a0, 'b'
  beq $t0, $zero, checkG
  jal setColorBlue
  b endSwitch
  
checkG:
  seq $t0, $a0, 'g'
  beq $t0, $zero, endSwitch
  jal setColorGreen
  b endSwitch

endSwitch:
  # Save the new state
  sw $s0, currentColor
  sw $s1, bmdAddress

  # Epilog: Restore $ra and return
  lw $ra, 0($sp)
  addi $sp, $sp, 4
  jr $ra
  
    
    
# === Key Handling ===
# Desc: These subroutines handle key presses and write pixels to a bitmap display.

# Handle 'J': Move one to the left and draw a pixel at that location.
handleKeyJ: 
  # Load the values of leftInput and rightInput
  lw $t0, leftInput
  lw $t1, rightInput

  beq $t0, 31, skipLeft         # Check if at the left border (x-coordinate is 31)
  
    addi $t0, $t0, 1            # Increment $t0 by 1 (move left)
    addi $t1, $t1, -1           # Decrement $t1 by 1 (update remaining space right)
    
    addi $s1, $s1, -4           # Decrement pointer by 4 bytes (move left)
    sw $s0, 0($s1)              # Write a pixel
    
  skipLeft:
  
  # Store the updated values back to memory
  sw $t0, leftInput
  sw $t1, rightInput
  
  jr $ra


# Handle 'k': Move down one row and draw a pixel at that location.
handleKeyK:
  # Load the values of upInput and downInput
  lw $t0, upInput
  lw $t1, downInput

  beq $t1, 30, skipDown         # Check if at the bottom border (y-coordinate is 30)
  
    addi $t1, $t1, 1            # Increment $t1 by 1 (move down)
    addi $t0, $t0, -1           # Decrement $t0 by 1 (update remaining space up)
    
    addi $s1, $s1, 256          # Increment pointer by 256 bytes (move down)
    sw $s0, 0($s1)              # Write a pixel
    
  skipDown:
  
  # Store the updated values back to memory
  sw $t0, upInput
  sw $t1, downInput
 
  jr $ra


# Handle 'l': Move one to the right and draw a pixel at that location.
handleKeyL:
  # Load the values of leftInput and rightInput
  lw $t0, leftInput
  lw $t1, rightInput

  beq $t1, 30, skipRight        # Check if at the right border (x-coordinate is 30)
  
    addi $t1, $t1, 1            # Increment $t1 by 1 (move right)
    addi $t0, $t0, -1           # Decrement $t0 by 1 (update remaining space left)
    
    addi $s1, $s1, 4            # Increment pointer by 4 bytes (move right)
    sw $s0, 0($s1)              # Write a pixel
    
  skipRight:
  
  # Store the updated values back to memory
  sw $t0, leftInput
  sw $t1, rightInput
  
  jr $ra


# Handle 'i': Move up one row and draw a pixel at that location.
handleKeyI:
  # Load the values of upInput and downInput
  lw $t0, upInput
  lw $t1, downInput

  beq $t0, 31, skipUp           # Check if at the top border (y-coordinate is 31)
  
    addi $t0, $t0, 1            # Increment $t0 by 1 (move up)
    addi $t1, $t1, -1           # Decrement $t1 by 1 (update remaining space down)
    
    addi $s1, $s1, -256         # Decrement pointer by 256 bytes (move up)
    sw $s0, 0($s1)              # Write a pixel
    
  skipUp:
  
  # Store the updated values back to memory
  sw $t0, upInput
  sw $t1, downInput
  
  jr $ra


# Handle 'y': Move up and left, then draw a pixel at that location.
handleKeyY:  
  # Load the values of leftInput, rightInput, upInput, and downInput
  lw $t0, leftInput
  lw $t1, rightInput
  lw $t2, upInput
  lw $t3, downInput

  beq $t2, 31, skipUpLeft       # Check if at the top border (y-coordinate is 31)
  beq $t0, 31, skipUpLeft       # Check if at the left border (x-coordinate is 31)
   
    addi $t2, $t2, 1            # Increment upInput (move up)
    addi $t3, $t3, -1           # Decrement downInput (update remaining space down)
      
    addi $t0, $t0, 1            # Increment leftInput (move left)
    addi $t1, $t1, -1           # Decrement rightInput (update remaining space right)
    
    addi $s1, $s1, -260         # Update pointer to move up and left
    sw $s0, 0($s1)              # Write a pixel
      
  skipUpLeft:

  # Store the updated values back to memory
  sw $t0, leftInput
  sw $t1, rightInput
  sw $t2, upInput
  sw $t3, downInput
  
  jr $ra


# Handle 'o': Move up and right, then draw a pixel at that location.
handleKeyO:
  # Load the values of leftInput, rightInput, upInput, and downInput
  lw $t0, leftInput
  lw $t1, rightInput
  lw $t2, upInput
  lw $t3, downInput

  beq $t2, 31, skipUpRight      # Check if at the top border (y-coordinate is 31)
  beq $t1, 30, skipUpRight      # Check if at the right border (x-coordinate is 30)
    
    addi $t2, $t2, 1            # Increment upInput (move up)
    addi $t3, $t3, -1           # Decrement downInput (update remaining space down)
      
    addi $t1, $t1, 1            # Increment rightInput (move right)
    addi $t0, $t0, -1           # Decrement leftInput (update remaining space left)
    
    addi $s1, $s1, -252         # Update pointer to move up and right
    sw $s0, 0($s1)              # Write a pixel
      
skipUpRight:

  # Store the updated values back to memory
  sw $t0, leftInput
  sw $t1, rightInput
  sw $t2, upInput
  sw $t3, downInput
  
  jr $ra


# Handle 'n': Move down and left, then draw a pixel at that location
handleKeyN:
  # Load the values of leftInput, rightInput, upInput, and downInput
  lw $t0, leftInput
  lw $t1, rightInput
  lw $t2, upInput
  lw $t3, downInput

  beq $t3, 30, skipDownLeft     # Check if at the bottom border (y-coordinate is 30)
  beq $t0, 31, skipDownLeft     # Check if at the left border (x-coordinate is 31)
    
    addi $t3, $t3, 1            # Increment $t3 by 1 (move down)
    addi $t2, $t2, -1           # Decrement $t2 by 1 (update remaining space up)
      
    addi $t0, $t0, 1            # Increment $t0 by 1 (move left)
    addi $t1, $t1, -1           # Decrement $t1 by 1 (update remaining space right)
      
    addi $s1, $s1, 252          # Update pointer to move down and left
    sw $s0, 0($s1)              # Write a pixel at the current location
      
  skipDownLeft:
  
  # Store the updated values back to memory
  sw $t0, leftInput
  sw $t1, rightInput
  sw $t2, upInput
  sw $t3, downInput
  
  jr $ra


# Handle 'm': Move down and right, then draw a pixel at that location
handleKeyM:
  # Load the values of leftInput, rightInput, upInput, and downInput
  lw $t0, leftInput
  lw $t1, rightInput
  lw $t2, upInput
  lw $t3, downInput

  beq $t3, 30, skipDownRight    # Check if at the bottom border (y-coordinate is 30)
  beq $t1, 30, skipDownRight    # Check if at the right border (x-coordinate is 30)
    
    addi $t3, $t3, 1            # Increment $t3 by 1 (move down)
    addi $t2, $t2, -1           # Decrement $t2 by 1 (update remaining space up)
      
    addi $t1, $t1, 1            # Increment $t1 by 1 (move right)
    addi $t0, $t0, -1           # Decrement $t0 by 1 (update remaining space left)
      
    addi $s1, $s1, 260          # Update pointer to move down and right
    sw $s0, 0($s1)              # Write a pixel at the current location
       
  skipDownRight:
  
  # Store the updated values back to memory
  sw $t0, leftInput
  sw $t1, rightInput
  sw $t2, upInput
  sw $t3, downInput
  
  jr $ra


# Handle 'd': Delete the current pixel, but do not move
handleKeyD:
  sw $s3, 0($s1)                # Write a background-colored pixel (delete)
  jr $ra


# Handle 'q': Exit the program
handleKeyQ:
  li $v0, 10                    # Set syscall code for exit
  syscall                       # Perform the syscall
  jr $ra
  
  
  
# === Draw Line ===
# Desc: The following subroutines allow you to draw a line to the edge of the screen
#       in the specified direction.

# Draw 'J': Continuously draw pixels to the left until the border is met
drawKeyJ:
  # Prolog: Store the value of $ra
  addi $sp, $sp, -4
  sw $ra, 0($sp)

  # Loop to draw the pixels to the left
  drawJ:
    lw $t0, leftInput          # Load 'leftInput' into '$t0' for evaluation
    beq $t0, 31, endJ          # Check if at the left border (x-coordinate is 31)
  
    jal handleKeyJ             # Call handleKeyJ to draw the pixel and update the position
    
    b drawJ                    # Repeat the loop
  endJ:
  
  # Epilog: Restore $ra
  lw $ra, 0($sp)
  addi $sp, $sp, 4
  
  jr $ra
  
  
# Draw 'K': Continuously draw pixels down until the border is met
drawKeyK:
  # Prolog: Store the value of $ra
  addi $sp, $sp, -4
  sw $ra, 0($sp)

  # Loop to draw the pixels down
  drawK:
    lw $t0, downInput          # Load 'downInput' into '$t0' for evaluation
    beq $t0, 30, endK          # Check if at the bottom border (y-coordinate is 30)
  
    jal handleKeyK             # Call handleKeyK to draw the pixel and update the position
    
    b drawK                    # Repeat the loop
  endK:
  
  # Epilog: Restore $ra
  lw $ra, 0($sp)
  addi $sp, $sp, 4
  
  jr $ra

  
  
# Draw 'L': Continuously draw pixels to the right until the border is met
drawKeyL:
  # Prolog: Store the value of $ra
  addi $sp, $sp, -4
  sw $ra, 0($sp)

  # Loop to draw the pixels to the right
  drawL:
    lw $t0, rightInput          # Load 'rightInput' into '$t0' for evaluation
    beq $t0, 30, endL           # Check if at the right border (x-coordinate is 30)
  
    jal handleKeyL              # Call handleKeyL to draw the pixel and update the position
    
    b drawL                     # Repeat the loop
  endL:
  
  # Epilog: Restore $ra
  lw $ra, 0($sp)
  addi $sp, $sp, 4

  jr $ra
  
  
# Draw 'I': Continuously draw pixels upwards until the border is met
drawKeyI:
  # Prolog: Store the value of $ra
  addi $sp, $sp, -4
  sw $ra, 0($sp)

  # Loop to draw the pixels up 
  drawI:
    lw $t0, upInput             # Load 'upInput' into '$t0' for evaluation
    beq $t0, 31, endI           # Check if at the top border (y-coordinate is 31)
  
    jal handleKeyI              # Call handleKeyI to draw the pixel and update the position
    
    b drawI                     # Repeat the loop
  endI:
  
  # Epilog: Restore $ra
  lw $ra, 0($sp)
  addi $sp, $sp, 4

  jr $ra

  
  
# Draw 'Y': Continuously draw pixels diagonally up and left until the border is met
drawKeyY:
  # Prolog: Store the value of $ra
  addi $sp, $sp, -4
  sw $ra, 0($sp)

  # Loop to draw the pixels up and left
  drawY:
    # Load 'leftInput' and 'upInput' into $t# registers for evaluation
    lw $t0, leftInput
    lw $t1, upInput
    
    beq $t0, 31, endY           # Check if at the left border (x-coordinate is 31)
    beq $t1, 31, endY           # Check if at the top border (y-coordinate is 31)
    
    jal handleKeyY              # Call handleKeyY to draw the pixel and update the position
        
    b drawY                     # Repeat the loop
  endY:
  
  # Epilog: Restore $ra
  lw $ra, 0($sp)
  addi $sp, $sp, 4
  
  jr $ra
  
# Draw 'O': Continuously draw pixels diagonally up and right until the border is met 
drawKeyO:
  # Prolog: Store the value of $ra
  addi $sp, $sp, -4
  sw $ra, 0($sp)

  # Loop to draw the pixels up and right
  drawO:
    # Load 'rightInput' and 'upInput' into $t# registers for evaluation
    lw $t0, rightInput
    lw $t1, upInput
    
    beq $t0, 30, endO           # Check if at the right border (x-coordinate is 30)
    beq $t1, 31, endO           # Check if at the top border (y-coordinate is 31)
    
    jal handleKeyO              # Call handleKeyO to draw the pixel and update the position
    
    b drawO                     # Repeat the loop
  endO:

  # Epilog: Restore $ra
  lw $ra, 0($sp)
  addi $sp, $sp, 4
  
  jr $ra

  
# Draw 'N': Continuously draw pixels diagonally down and left until the border is met
drawKeyN:
  # Prolog: Store the value of $ra
  addi $sp, $sp, -4
  sw $ra, 0($sp)

  # Loop to draw the pixels down and left
  drawN:
    # Load 'leftInput' and 'downInput' into $t# registers for evaluation
    lw $t0, leftInput
    lw $t1, downInput
  
    beq $t0, 31, endN           # Check if at the left border (x-coordinate is 31)
    beq $t1, 30, endN           # Check if at the bottom border (y-coordinate is 30)
    
    jal handleKeyN              # Call handleKeyN to draw the pixel and update the position
      
    b drawN                     # Repeat the loop
  endN:
  
  # Epilog: Restore $ra
  lw $ra, 0($sp)
  addi $sp, $sp, 4
  
  jr $ra
  
# Draw 'M': Continuously draw pixels diagonally down and right until the border is met
drawKeyM:
  # Prolog: Store the value of $ra
  addi $sp, $sp, -4
  sw $ra, 0($sp)

  # Loop to draw the pixels down and right
  drawM:
    # Load 'rightInput' and 'downInput' into $t# registers for evaluation
    lw $t0, rightInput
    lw $t1, downInput
    
    beq $t0, 30, endM           # Check if at the right border (x-coordinate is 30)
    beq $t1, 30, endM           # Check if at the bottom border (y-coordinate is 30)
    
    jal handleKeyM              # Call handleKeyM to draw the pixel and update the position
    
    b drawM                     # Repeat the loop
  endM:
  
  # Epilog: Restore $ra
  lw $ra, 0($sp)
  addi $sp, $sp, 4
  
  jr $ra



# === Pixel Colors ===
# Desc: These subroutines set the color of the pixels.

# Set the color to red
setColorRed:
  # Load the base color and color offset into registers
  lw $t0, red
  lw $t1, colorOffset
  
  add $t0, $t0, $t1            # Add the current gradient value to the base red color

  bne $s0, $t0, setRed         # If current color is not red, jump to setRed
  beq $t1, 240, exitRed        # If red gradient counter is 240, exit subroutine

    addi $t1, $t1, 30          # Increment the red gradient counter
    addi $s0, $s0, 30          # Add 30 to the red component of the current color

    b exitRed
  setRed:
    lw $s0, red                # Load the base red color value into $s0
    li $t1, 0                  # Initialize red gradient counter to 0
  exitRed:
  
  # Store the new offset into 'colorOffset'
  sw $t1, colorOffset

  jr $ra                      

  
# Set the color to blue
setColorBlue:
  # Load the base color and color offset into registers
  lw $t0, blue
  lw $t1, colorOffset
  
  add $t0, $t0, $t1            # Add the current gradient value to the base blue color

  bne $s0, $t0, setBlue        # If current color is not blue, jump to setBlue
  beq $t1, 240, exitBlue       # If blue gradient counter is 240, exit subroutine
 
    addi $t1, $t1, 30          # Increment the blue gradient counter
    addi $s0, $s0, 30          # Add 30 to the blue component of the current color

    b exitBlue
  setBlue:
    lw $s0, blue               # Load the base blue color value into $s0
    li $t1, 0                  # Initialize blue gradient counter to 0
  exitBlue:
  
  # Store the new offset into 'colorOffset'
  sw $t1, colorOffset

  jr $ra
 
  
# Set the color to green
setColorGreen:
  # Load the base color and color offset into registers
  lw $t0, green
  lw $t1, colorOffset
  
  add $t0, $t0, $t1            # Add the current gradient value to the base green color

  bne $s0, $t0, setGreen       # If current color is not green, jump to setGreen
  beq $t1, 240, exitGreen      # If green gradient counter is 240, exit subroutine

    addi $t1, $t1, 30          # Increment the green gradient counter
    addi $s0, $s0, 30          # Add 30 to the green component of the current color

    b exitGreen
  setGreen:
    lw $s0, green              # Load the base green color value into $s0
    li $t1, 0                  # Initialize green gradient counter to 0
  exitGreen:
  
  # Store the new offset into 'colorOffset'
  sw $t1, colorOffset

  jr $ra