# Title:  Print Methods
# Desc:   This program converts a C program that uses array printing methods to MIPS assembly
# Author: Bryce Verberne
# Title:  04/13/2023



# -------------
# main Function
# -------------
# Description: Entry point of the program. Calls the printReverse and printPositive functions.
# Function in C:
#  #include <stdio.h>
#  #include <stdlib.h>
#
#  // Global Array
#  int myInts[] = {3, -8, -9, 12, 14, -23, 32, 33, 42};
#
#  // Prototypes
#  void printReverse(int myInts[]);
#  void printPositive(int myInts[]);
#  void printInt(int x);
#  
#  int main(void) {
#  
#      printReverse(myInts);
#      printPositive(myInts);
#    
#      exit(0);
#  }

.data
  myInts: .word 3 -8 -9 12 14 -23 32 33 42
  gap:    .asciiz " "
  open:   .asciiz "[ "
  close:  .asciiz "]"

.text
  .globl main
main:
  
  # Store the address of myInts into $a0 & call printReverse
  la $a0, myInts
  jal printReverse
  
  # Store the address of myInts into $a0 & call printPositive
  la $a0, myInts
  jal printPositive
  
  # Terminate Program
  li $v0, 10
  syscall
  
# End main
  
  
# ---------------------  
# printReverse Function
# ---------------------  
# Description: Prints every other number in the 'myInts' array in reverse order.
# Function in C:
#  // Print every other # in reverse
#  void printReverse(int myInts[]) {
#      printf("[ ");
#      for (int i = 8; i >= 0; i -= 2) {
#          printInt(myInts[i]);  // printf("%d ", myInts[i]);
#      }
#      printf("]\n");
#  }
 
.text
printReverse:
  # Prolog - Save State
  addi $sp, $sp, -8             # Allocate 8 bytes of space in stack
  
  sw $ra, 0($sp)                # Store $ra in stack
  sw $a0, 4($sp)                # Store $a0 in stack
  
  move $t0, $a0                 # Store value of $a0 in $t0
  
  
  # Logic
  addi $t0, $t0 32              # Add 32 to our address (8 x 4 = 32)
  li $t1, 5                     # Set our iterator (i) to 4
  
  la $a0, open                  # Print opened bracket
  li $v0, 4
  syscall
  
  reverseLoop:
    # Condition
    beq $t1, $zero, endReverse
    
    # Logic
    lw $a1, 0($t0)              # Load the current element into $a1
    jal printInt                # Call printInt & pass &a1
  
    # Prep for next iteration
    addi $t0, $t0, -8           # Shift our address down to every other element in the array
    addi $t1, $t1, -1           # Decrement $t1 (--i)
  
    b reverseLoop
  endReverse:
  
  la $a0, close                 # Print closed bracket
  li $v0, 4
  syscall
  
  li $a0, '\n'                  # Print newline
  li $v0, 11
  syscall
  
  
  # Epilog - Restore
  lw $ra, 0($sp)                # Load value back into $ra
  lw $a0, 4($sp)                # Load value back into $a0
            
  addi $sp, $sp, 8              # Restore the stack from the previous -8
   
   
  # Return - Always store return values in $v0 & $v1
  jr $ra
  
# End printReverse


# ----------------------
# printPositive Function
# ----------------------
# Description: Prints all positive numbers in the 'myInts' array.
# Function in C:
#  // Print positive #'s
#  void printPositive(int myInts[]) {
#      printf("[ ");
#      for (int i = 0; i < 9; i++) {
#          if (myInts[i] > 0) {
#              printInt(myInts[i]);  // printf("%d ", myInts[i]);
#          }
#      }
#      printf("]\n");
#  }

.text
printPositive:
  # Prolog - Save State
  addi $sp, $sp, -8             # Allocate 8 bytes of space in stack
  
  sw $ra, 0($sp)                # Store $ra in stack
  sw $a0, 4($sp)                # Store $a0 in stack
  
  move $t0, $a0                 # Store value of $a0 in $t0
  
  
  # Logic
  li $t1, 0                     # Set $t1, our iterator (i), to 0
  
  la $a0, open                  # Print opened bracket
  li $v0, 4
  syscall
  
  positiveLoop:
    # Condition
    beq $t1, 9, endPositiveLoop
    
    # Logic
    lw $a1, 0($t0)              # Load the current element into $a1
    
    # Use branching statement to determine if the element in negative
    isPositive:
      bgt $a1, $zero, printVal  # If $a1 < $zero, branch to absVal
      b endPositive
    printVal: jal printInt      # Call printInt & pass &a1
    endPositive:
  
  
    # Prep for next iteration
    addi $t0, $t0, 4            # Shift our address up to the next element in the array
    addi $t1, $t1, 1            # Increment $t1 (++i)
  
    b positiveLoop
  endPositiveLoop:
  
  la $a0, close                 # Print closed bracket
  li $v0, 4
  syscall
  
  
  
  # Epilog - Restore
  lw $ra, 0($sp)                # Load value back into $ra
  lw $a0, 4($sp)                # Load value back into $a0
  
  addi $sp, $sp, 8              # Restore the stack from the previous -8
  
  
  # Return
  jr $ra
  
# End printPositive


# -----------------
# printInt Function
# -----------------
# Description: Prints the integer value passed to it, followed by a space.
# Function in C:
#  void printInt(int x) {
#      printf("%d ", x);
#  }

.text
printInt:

  move $a0, $a1                 # Print $a1
  li   $v0, 1
  syscall
  
  la $a0, gap                   # Print a space
  li $v0, 4
  syscall

  # Return
  jr $ra
  
# End printInt
