# Title:  Saving to Stack
# Desc:   This program demonstrates how to save register values to stack.
# Author: Bryce Verberne
# Date:   03/17/2023



# Info: 
#  - If you call a procedure, the procedure is the callee.
#  - $s0 to $s7 are stack registers. Convention says that, inside a function,
#    you always have to save the old value of $s# registers from the caller 
#    to the stack.  
#  - The callee is not allowed to modify the value in the $s# registers.
#  - $sp (stack pointer) allows us to allocate space in the stack to store 
#    $s# registers.

.data
  procedureVal: .asciiz "This is our value in the procedure: "
  mainVal:      .asciiz "This is our value in main: "

.text
  .globl main
main:
  li $s0, 10         # 10 is stored in the register $s0.
  
  jal increaseReg    # Call increaseReg procedure and prevent the 
                     # modification of an $s# register.
  
  la $a0, mainVal
  li $v0, 4
  syscall
  
  li   $v0, 1        # Print $s0 
  move $a0, $s0
  syscall
  
  
  # Terminating Program
  li $v0, 10 
  syscall
  
  
increaseReg:
  addi $sp, $sp, -4  # We use -4 since we need to allocate 4 bytes (1 word) of 
                     # space in the stack. 
                     # -4 is negative since we need to allocate space, given the 
                     # stack goes down. 
                     # If you are adding, then you are taking space from the stack.
    
  sw $s0, 0($sp)     # This saves $s0 to the first position (offset 0) in $sp.
    
  addi $s0, $s0, 30  # Perform $s0 + 30 (10 + 30).
    
  # Print value
  la $a0, procedureVal
  li $v0, 4
  syscall
    
  li   $v0, 1
  move $a0, $s0      # Move $s0 into $a0
  syscall 
    
  li $a0, '\n'
  li $v0, 11
  syscall
    
  lw $s0, 0($sp)     # Load our value stored in RAM back into $s0. This effectively 
                     # helps us retain the value of $s0.
    
  addi $sp, $sp, 4   # Restore the stack from the previous -4. 
    
  jr $ra             # Return to caller