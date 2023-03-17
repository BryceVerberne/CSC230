# Title:  Nested Procedures Lab
# Desc:   Given the C program, complete the implementation of procedure Sum
# Author: Bryce Verberne
# Date:   03/17/2023



# int dif(int a, int b) {
#    return b - a;
# }
#
# int Sum(int m, int n) {
#    int p = Dif(n+1, m-1);
#    int q = Dif(m+1, n-1);
#    return p + q;
# }
#
# int main() {
#    int x = 5;
#    int y = 10;
#    
#    z = x + y + Sum(x, y);
#    return 0;
# }

# Procedure Main
.text
  .globl main
main:
  li $s0, 5            # Load 5 into $s0 (int x = 5;)
  li $s1, 10           # Load 10 into $s1 (int y = 10;)

  # Load both arguments ($a0(x) & $a1(y))
  add $a0, $zero, $s0
  add $a1, $zero, $s1
      
  # Call Sum procedure
  jal Sum
      
  # z = x + y + Sum(x, y)
  add $s2, $s0, $s1
  add $s2, $s2, $v0
  
  # Output result (z)
  li $v0, 1
  move $a0, $s2
  syscall
      
  
  # Terminate Program
  li $v0, 10
  syscall


# Procedure Sum
Sum:
  addi $sp, $sp, -12   # Allocate 12 bytes of space in stack
  
  sw   $ra, 0($sp)     # Store main return address in stack
  sw   $s0, 4($sp)     # Store $s0 in stack
  sw   $s1, 8($sp)     # Store $s1 in stack
  
  # Concept: 
  #   sub $v0, $a1, $a0 <- z = x-1 - y+1
  addi $a0, $s1, 1     # a = n + 1
  subi $a1, $s0, 1     # b = m - 1
  
  
  # Jump to Dif Class
  jal Dif              # return b - a
  
  
  add $v1, $zero, $v0  # Store the result of Dif call in $v1
  
  # Restore original values of arguments
  add $a0, $zero, $s0
  add $a1, $zero, $s1
  
  # Concept: 
  #   sub $v0, $a1, $a0 <- z = y-1 - x+1
  addi $a0, $s0, 1     # a = m + 1
  subi $a1, $s1, 1     # b = n - 1
  
      
  # Jump to Dif Class
  jal Dif              # return b - a
  
  
  lw $ra, 0($sp)       # Load value back into $ra so we can return to main
  lw $s0, 4($sp)       # Load value back into $s0
  lw $s1, 8($sp)       # Load value back into $s1
  
  addi $sp, $sp, 12    # Restore the stack from the previous -12
  
  add $v0, $v1, $v0    # p + q
  
  jr $ra               # Return to main
  

# Procedure Dif
Dif:
  sub $v0, $a1, $a0
  jr  $ra
