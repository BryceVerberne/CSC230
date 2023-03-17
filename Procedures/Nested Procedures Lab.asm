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

addi $sp, $zero, 6000   # Assume Stack memory starts at 6000. Do not modify.

# Procedure Main (Do not modify)
.text
  .globl main
main:
  add $a0, $zero, $s0
  add $a1, $zero, $s1
      
  jal Sum
      
  add $s2, $s0, $s1
  add $s2, $s2, $v0
      
  
  # Terminate Program
  li $v0, 10
  syscall


# Procedure Sum
Sum:
  # Type your code here.
      

# Procedure Dif (Do not modify)
Dif:
  sub $v0, $a1, $a0
  jr $ra
