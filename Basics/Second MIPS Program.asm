#Title:   Second MIPS Program
# Desc:   This program does the following math: x = (5 - 2) + (3 + 4) and prints x to output. 
# Author: Bryce Verberne
# Date:   02/07/2023



# int x = 5;  // Global Variable
# int y = 2;  // Global Variable
# int z = 3;  // Global Variable
# int w = 4;  // Global Variable 
# int main() {
#   x = (x - y) + (z + w);
#   exit();
# }

.data                # This tells the assembler that everything that follows is data
  # Declare variables
  x: .word 5         # int x = 5
  y: .word 2         # int y = 2
  z: .word 3         # int z = 3
  w: .word 4         # int w = 4

.text                # This tells the assember that everything that follows is code
  .globl main
main:                # This is the starting point
  # Get input
  lw $t0, z          # Move z into the register $t0
  lw $t1, w          # Move w into the register $t1
  lw $t2, x          # Move x into the register $t2
  lw $t3, y          # Move y into the register $t3
  
  # Do processing
  sub $t2, $t2, $t3  # Subtract the value in $t2 and $t3 and store in $t2. (x - y)
  add $t0, $t0, $t1  # Add the value in $t0 and $t1 and store it in $t0. (z + w)
  add $t2, $t2, $t0  # Add the value in $t2 and $t0 and store it in $t2. (x - y) + (z + w)
  
  # Output results
  move $a0, $t2      # Move $t0 to $a0
  li $v0, 1          # Load up the code to print our value x
  syscall
  
  # Get out out of Dodge
  li $v0, 10         # Load up a code to tell the program we're done
  syscall
