# Title:  Reentrant Subroutines
# Desc:   Modify the Subroutine.asm program to use nested procedures.
# Author: Bryce Verberne
# Date:   03/21/2023



#int main() {
#  int x;  // This can just be in a register.  It doesn't need to be in RAM.
#  x = getInt();
#  printf("You entered %d\n", x);
#}

# int getInt() {
#  int x;
#  do {
#    printf("Please enter a positive number: ");
#    scanf("%d\n",&x);
#  } while (x <= 0);
#  return x;
# }

.include "MyMacros.asm"

.data
  result: .asciiz "You entered "
  
.text
  .globl main
main:
  # Let's assume that we are using $t0 as x.
  # int x is in $t0.
  # The first thing we do is call a method called getInt.
  
  jal getInt             # Jump & Link (jal) jumps to the subroutine getInt & saves the return address to $ra.
  move $t0, $v0          # When a subroutine returns a value, it si always returned in $v0 or $v1
  
  printString result     # Print "You entered "
  printInt $t0           # Print the result
  printNewLine           # Print newline
  
  
  # Terminate Program (end of main)
  done
  
  
# getInt reads a value from the user > 0 & keeps asking until you do so.
# Returns the value $v0 and receives no parameters.
.data
  prompt: .asciiz "Please enter a positive number: "

.text
getInt:                  # This label is the address of our getInt method
  addi $sp, $sp, -4      # Allocate 4 bytes of space in our stack for $ra
  
  sw $ra, 0($sp)         # Store $ra in stack

  do:
    la $a0, prompt       # Load prompt in $a0
    jal printPrompt      # Jump to the printPrompt routine
    
    readInt $t1          # Get the value from the user
    
    sgt $t2, $t1, $zero  # Set $t2 if x <= 0
    beq $t2, $zero, do   # If x <= 0 is true, ask again. Else, we're done.
  
  # We do not need a label to end the loop because we are doing a post test. 
  
  lw   $ra, 0($sp)       # Load intial value of $ra to return to main
  addi $sp, $sp, 4       # Restore the stack from the previous -4 (preserve state). 
  
  move $v0, $t1          # Move the results to $v0. 
  jr $ra                 # This updates the $pc to the value in the $ra register. 
  
  
# printPrompt
# This subroutine gets the address of a string & prints that string
# Then, it returns to the calling method.
# The address of the string is in $a0.
.data

.text
printPrompt:
  # The address is already in $a0
  li $v0, 4              # Load up the syscall
  syscall                # Call it
  
  jr $ra