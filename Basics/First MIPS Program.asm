#Title:   First MIPS Program
# Desc:   The first program written in class and formatted nicely
# Author: Bryce Verberne
# Date:   02/07/2023



# int x;  // Global Variable
# int y;  // Global Variable
# int main() {
#   x = x + y;
#   exit();
# }

.data                # This tells the assembler that everything that follows is data
  # Declare variables
  x: .word 2         # int x = 2
  y: .word 3         # int y = 3

.text                # This tells the assember that everything that follows is code
  .globl main
main:                # This is the starting point
  # Get input
  lw $t0, x          # Move x into the register $t0
  lw $t1, y          # Move y into the register $t1
  
  # Do processing
  add $t0, $t0, $t1  # Add $t0 and $t1 and store the results back into $t0
  
  # Output results
  move $a0, $t0
  li $v0, 1
  syscall
  
  # Get out out of Dodge
  li $v0, 10         # Load up a code to tell the program we're done
  syscall
