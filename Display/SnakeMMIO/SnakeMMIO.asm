# Title:  Snake MMIO
# Desc:   This program explores MMIO with the incorporation of interrupts
# Author: Bryce Verberne
# Title:  04/18/2023



.eqv THD 0xffff000c  # this is where we write data to...
.eqv THR 0xffff0008  # This check is the device ready
  
.eqv KC 0xffff0004   # MMMI  Address that we use to read data
.eqv KR 0xffff0000   # Is it ok to write?  Key Write Request
  
.eqv BMD 0x10010000  # This needs to be changed to the heap.
  
.text
  .globl main
main:
  li $t1, KR                      # Need this to set the interrupt bit.  Which is bit 2.  
   
  # All this does is set us up to handle interrupts.  It sets a bit
  li $t5, 2		          # 2 is the bit that needs to be set in KR to enable interrupts 0x0010
  sb $t5, 0($t1)                  # Set bit 2 in KR 
  # You do need to allocate memory in the heap.
   
  loop:
    add $t8, $t8, $zero           # Do nothing.  Keep MARS happy
    b loop

  .kdata # We save state.
    color:      .word 0x000000ff  #  Start with blue
    bmdAddress: .word 0x10010020
     
  .ktext 0x80000180               # Have to have that address so it can jump here
  
    # If we are here, then a key was pressed.  Let's print it.
    # We got here because an Exception Happened.  Automatically jumped to this code

    # Task!!  Please do a prolog here.
    # Make sure to do a Prolog to save any registers that you modify in the routines below.
    
    # Start of our Exception Handling Code - We need some addresses
    li $t0, KC                    # Make a note, these $t should probably be $s if we are calling other subs
    lw $s0, 0($t0)                # Get the key pressed
    move $a0, $s0                 # Print it  Good for debug
    li $v0, 11
    syscall
    # Make sure to move $t0 to $a1 here and the key is pressed in $a0
    jal handleKeyInput            # That is down below.  That is where your methods will go
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
    lw $t6, color                 # Load our color into $t6
    lw $t4, bmdAddress            # Load the address from RAM
       
      
    # This is going to be one large switch statement input 
    # Switch ($a0) {
    seq $t0, $a0, 'J'             # Case 'J'
    beq $t0, $zero, checkK        # If it is not 'J', check next
      jal handleKeyJ
      b endSwitch
      
    checkK:
      seq $t0, $a0, 'K'           # Check if 'K'
      beq $t0, $zero, checkW
        jal handleKeyK
        b endSwitch
        
    checkW:
        
    endSwitch:
    
       
     # Save new state
     sw $t6, color                # Save our color back.
     sw $t4, bmdAddress           # Save our address back.
     
     lw $ra, 0($sp)
     addi $sp, $sp, 4
     
     # Should have an epilog
     jr $ra     
    
#  J says to draw a pixel at the current location and move one to the left
#  K says to draw a pixel at the current location and move down one
#  L says to draw a pixel at the current location and move right
#  I says to draw a pixel at the current location and move up
#  Y moves to draw a pixel at the current location and up/left
#  O moves to draw a pixel at the current location and up/right
#  N moves to draw a pixel at the current location and down/left
#  M moves to draw a pixel at the current location and down/right
#  D deletes the current location, but does not move.
#  Q exits the program
handleKeyJ:  # Move left
 # Update Screen
  sw $t6, 0($t4)                # Write a pixel
  addi $t4, $t4, -4             # Update our pointer
  
  jr $ra
  
handleKeyK:  # Move down
  # Update Screen
  sw $t6, 0($t4)                # Write a pixel
  addi $t4, $t4, 128            # Update our pointer
  
  jr $ra

handleKeyW:
  
  jr $ra
  
handleKeyS:
  
  jr $ra
  
handleKeyA: 

  jr $ra  