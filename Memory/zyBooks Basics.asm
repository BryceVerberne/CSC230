# Title:  zyBooks Basics
# Desc:   This program takes a value from memory & stores it in a different location.
# Author: Bryce Verberne
# Date:   02/10/2023



# The assignment is to load the value of variable X
# from a memory location and save the value in 
# variable Y. Assume the value of X is stored at memory
# address 4000, the value of Y is stored at memory 
# address 4004, and registers $s0 and $s1 contain 
# the memory addresses 4000 and 4004:

# int x = 10;
# int y;
# int main() {
#  y = x;
#  exit();
# }

.data
  x: .word 10      # x stored memory location
  y: .word  0      # y stored memory location

.text
  .globl main
main:

  la $s0, x        # This will load the address of x into $s0
  la $s1, y        # This loads the address of y

  lw $t0, 0($s0)   # We are going to enter the memory location
  sw $t0, 0($s1)   # Move the value in $t0 to the memory location addressed by $s1
  
  
  # Terminate Program
  li $v0, 10
  syscall
