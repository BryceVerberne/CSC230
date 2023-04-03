# Title:  Nested Procedures
# Desc:   This program demonstrates how to create nested procedures.
# Author: Bryce Verberne
# Date:   03/17/2023



# Info:
#  - $s# registers are caller saved and $t# are callee saved.
#  - When we perform nested procedures, we need a way to remember the address from main.
#    We do this by storing the value of the main address in the stack.

.data
  procedureVal: .asciiz "This is our value in the procedure: "
  mainVal:      .asciiz "This is our value in main: "

.text
  .globl main
main:
  li $s0, 10         # 10 is stored in the register $s0.
  
  jal increaseReg    # Call increaseReg 
  
  la $a0, mainVal
  li $v0, 4
  syscall
  
  # Call printVal to print $s0
  jal printVal
  
  # Terminate Program
  li $v0, 10 
  syscall
  

# increaseReg adds 30 to $s0
increaseReg:
  addi $sp, $sp, -8  # Allocate 8 bytes of space in stack for $s0 and $ra
    
  sw $s0, 0($sp)     # Save $s0 to $sp.
  sw $ra, 4($sp)     # Store the main address in the stack
    
  addi $s0, $s0, 30  # Perform $s0 + 30 (10 + 30).
    
  # Print value
  la $a0, procedureVal
  li $v0, 4
  syscall
    
  # Call the printVal procedure. This will store a new address in $ra.   
  jal printVal
    
  li $a0, '\n'
  li $v0, 11
  syscall
    
  lw $s0, 0($sp)     # Load value back into $s0 to retain initial value.
  lw $ra, 4($sp)     # Load value back into $ra so we can return to main.
    
  addi $sp, $sp, 8   # Restore the stack from the previous -8. 
    
  jr $ra             # Return to main
  

# printVal outputs the value of $s0
printVal:
  li   $v0, 1
  move $a0, $s0
  syscall 
  
  jr $ra             # Return back to increaseReg