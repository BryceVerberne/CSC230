#Title:   First Mips Program Version 2
# Desc:   Let's take our First Mips Program and expand on that significantly.
# Author: Bryce Verberne
# Date:   02/07/2023



# int x;  // Global Variable
# int y;  // Global Variable
# int main() {
#   x = 3 - x + y;  // Let's add an immediate (coefficient) value to our equation
#   // Did you notice that I didn't put the results bakc into x? I left it in $t0.
#   printf(x);
#   exit();
# }

.data                 # This tells the assembler that everything that follows is data
  # Declare variables
  x: .word 2   # int x = 2
  y: .word 3   # int y = 3

.text                 # This tells the assember that everything that follows is code
  .globl main
main:                 # This is the starting point
  # Get input
  lw $t0, x           # Move x into the register $t0
  lw $t1, y           # Move y into the register $t1
  
  # Do processing
  addi $t2, $zero, 3  # Add the value 3 to the value in the register $zero and put it in $t2.
  
  sub $t2, $t2, $t0   # Subtract the value in $t0 from the value in $t2 and put it in $t2 (3 - x)
  add $t0, $t2, $t1   # Add $t1 to the results from the previous line (3 - x) + y
  sw  $t0, x          # Store our results back into RAM at the memory location x
  
  # Output results
  move $a0, $t0       # Move is a pseudo instruction, but it makes life easier.
  li $v0, 1           # Load up the code to print a value
  syscall
  
  # Get out out of Dodge
  li $v0, 10          # Load up a code to tell the program we're done
  syscall