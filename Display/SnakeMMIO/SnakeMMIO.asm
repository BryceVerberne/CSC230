# Title:  Snake MMIO
# Desc:   This program explores MMIO with the incorporation of interrupts
# Author: Bryce Verberne
# Title:  04/18/2023



# Extended Description:
# This program allows users to create simple pixel art using keyboard inputs. The program responds to different
# keystrokes to move the current position and draw pixels on the screen. It uses a simple memory-mapped I/O (MMIO)
# scheme to interact with the display device.
#
# The program runs in an infinite loop waiting for key inputs. Once a key is pressed, an interrupt is triggered, and
# the program jumps to the exception handling code to process the input.
#
# The following keys are supported:
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
#
# The program uses the following MMIO addresses:
# THD 0xffff000c - Data to write to the display
# THR 0xffff0008 - Device ready check
# KC  0xffff0004 - Address to read key input
# KR  0xffff0000 - Key Write Request (set to enable interrupts)
#
# The program also uses a base memory address (BMD) to store the current state:
# BMD 0x10010000 - Base address for storing program state
#
# Note that some parts of the code may need to be changed to use the heap for memory allocation.

.eqv THD 0xffff000c  # this is where we write data to...
.eqv THR 0xffff0008  # This check is the device ready
  
.eqv KC 0xffff0004   # MMMI  Address that we use to read data
.eqv KR 0xffff0000   # Is it ok to write?  Key Write Request
  
.eqv BMD 0x10010000  # This needs to be changed to the heap.
  
.text
  .globl main
main:
  li $t1, KR                     # Need this to set the interrupt bit.  Which is bit 2.  
   
  # All this does is set us up to handle interrupts.  It sets a bit
  li $t5, 2		         # 2 is the bit that needs to be set in KR to enable interrupts 0x0010
  sb $t5, 0($t1)                 # Set bit 2 in KR 
  # You do need to allocate memory in the heap.
   
  loop:
    add $t8, $t8, $zero          # Do nothing.  Keep MARS happy
    b loop

  .kdata # We save state.
    color:      .word 0x000000ff #  Start with blue
    bmdAddress: .word 0x10010020
     
  .ktext 0x80000180              # Have to have that address so it can jump here
  
    # If we are here, then a key was pressed.  Let's print it.
    # We got here because an Exception Happened.  Automatically jumped to this code

    # Task!!  Please do a prolog here.
    # Make sure to do a Prolog to save any registers that you modify in the routines below.
    
    # Start of our Exception Handling Code - We need some addresses
    li $t0, KC                   # Make a note, these $t should probably be $s if we are calling other subs
    lw $s0, 0($t0)               # Get the key pressed
    move $a0, $s0                # Print it  Good for debug
    li $v0, 11
    syscall
    # Make sure to move $t0 to $a1 here and the key is pressed in $a0
    jal handleKeyInput           # That is down below.  That is where your methods will go
                                 # to handle each keystroke
    
    # Tasks Epilog
    # Don't forget the epliog
    
    # Return to the infinite loop in main
    eret
     
  # All the subroutines you write to handle key input, need to be in the 
  # .ktext area.  It is part of Exception Handling.
  
  # $a0 holds the key that was just pressed. 
  handleKeyInput:
    # Should have a prolog - You need to include one because your logic will be much
    
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    
    # more in depth. 
    # Load state
    lw $t6, color                # Load our color into $t6
    lw $t4, bmdAddress           # Load the address from RAM
       
      
    # This is going to be one large switch statement input 
    # Switch ($a0) {
    seq $t0, $a0, 'J'            # Case 'J' - Draw a pixel at the current location and move one to the left
    beq $t0, $zero, checkK       # If it is not 'J', check next ('K')
    jal handleKeyJ
    b endSwitch
      
    checkK:
      seq $t0, $a0, 'K'          # Case 'K' - Draw a pixel at the current location and move down one
      beq $t0, $zero, checkL     # If it is not 'K', check next ('L')
      jal handleKeyK
      b endSwitch
        
    checkL:
      seq $t0, $a0, 'L'          # Case 'L' - Draw a pixel at the current location and move up
      beq $t0, $zero, checkI     # If it is not 'L', check next ('I')
      jal handleKeyL
      b endSwitch
      
    checkI:
      seq $t0, $a0, 'I'          # Case 'I' - Draw a pixel at the current location and move up
      beq $t0, $zero, checkY     # If it is not 'I', check next ('Y')
      jal handleKeyI
      b endSwitch
      
    checkY:
      seq $t0, $a0, 'Y'          # Case 'Y' - Draw a pixel at the current location and up/left
      beq $t0, $zero, checkO     # If it is not 'Y', check next ('O')
      jal handleKeyY
      b endSwitch
      
    checkO:
      seq $t0, $a0, 'O'          # Case 'O' - Draw a pixel at the current location and up/right
      beq $t0, $zero, checkN     # If it is not 'O', check next ('N')
      jal handleKeyO
      b endSwitch
      
    checkN:
      seq $t0, $a0, 'N'          # Case 'N' - Draw a pixel at the current location and down/left
      beq $t0, $zero, checkM     # If it is not 'N', check next ('M')
      jal handleKeyN
      b endSwitch
      
    checkM:
      seq $t0, $a0, 'M'          # Case 'M' - Draw a pixel at the current location and down/right
      beq $t0, $zero, checkD     # If it is not 'M', check next ('D')
      jal handleKeyN
      b endSwitch
      
    checkD:
      seq $t0, $a0, 'D'          # Case 'D' - Deletes the current location, but does not move.
      beq $t0, $zero, checkQ     # If it is not 'D', check next ('Q')
      jal handleKeyD
      b endSwitch
      
    checkQ:
      seq $t0, $a0, 'Q'          # Case 'Q' - Exits the program
      beq $t0, $zero, endSwitch  # If it is not 'Q', branch to endSwitch
      jal handleKeyQ
      b endSwitch
        
    endSwitch:                   # End the switch statement
     
     # Save new state
     sw $t6, color               # Save our color back.
     sw $t4, bmdAddress          # Save our address back.
     
     lw $ra, 0($sp)
     addi $sp, $sp, 4
     
     # Should have an epilog
     jr $ra     
    
    
# ============
# Key Handling
# ============

# J says to draw a pixel at the current location and move one to the left
handleKeyJ:
  sw $t6, 0($t4)                # Write a pixel
  addi $t4, $t4, -4             # Update our pointer
  
  jr $ra
  
  
# K says to draw a pixel at the current location and move down one
handleKeyK:
  sw $t6, 0($t4)                # Write a pixel
  addi $t4, $t4, 256            # Update our pointer
  
  jr $ra


# L says to draw a pixel at the current location and move right
handleKeyL:
  sw $t6, 0($t4)                # Write a pixel
  addi $t4, $t4, 4              # Update our pointer
  
  jr $ra
  
  
# I says to draw a pixel at the current location and move up
handleKeyI:
  sw $t6, 0($t4)               # Write a pixel
  addi $t4, $t4, -256          # Update our pointer
  
  jr $ra
  
  
# Y moves to draw a pixel at the current location and up/left
handleKeyY: 

  jr $ra  
  

# O moves to draw a pixel at the current location and up/right
handleKeyO:

  jr $ra
  

# N moves to draw a pixel at the current location and down/left
handleKeyN:

  jr $ra
  
  
# M moves to draw a pixel at the current location and down/right
handleKeyM:

  jr $ra
  
  
# D deletes the current location, but does not move.
handleKeyD:

  jr $ra  
  
  
# Q exits the program
handleKeyQ:
  li $v0, 10
  syscall

  jr $ra