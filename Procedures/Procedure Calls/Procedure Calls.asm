# Title:  Procedure Calls
# Desc:   Given the C program, complete the MIPS implementation of Main. 
# Author: Bryce Verberne
# Date:   03/16/2023



# int Dif(int a, int b){
#    return a - b;
# }

# int Sum(int a, int b){
#    return a + b;
# }

# int main(){
#    int x = 5
#    int y = 10
#
#    w = Sum(x, y);
#    z = Dif(y, x);
#    return 0;   // Do not implement
# }

.text
  .globl main
main:
  li $s0, 5   # Load $a0 with 5 (our x variable)
  li $s1, 10  # Load $a1 with 10 (our y variable)
      
  # Load our arguments
  add $a0, $zero, $s0
  add $a1, $zero, $s1
      
      
  # Jump to Sum procedure and store return value in $s2
  jal Sum
  move $s2, $v0
  
  # Print value of $s2
  move $a0, $s2
  li   $v0, 1
  syscall
  
  li $a0, '\n'
  li $v0, 11
  syscall
  
  
  # Load our arguments
  add $a0, $zero, $s1
  add $a1, $zero, $s0
  
  # Jump to Dif procedure and store return value in $s3
  jal Dif
  move $s3, $v0
  
  move $a0, $s3
  li   $v0, 1
  syscall
      
      
  # Terminate Program
  li $v0, 10
  syscall
  

# Procedure Sum (Do not modify)
Sum:
  add $v0, $a0, $a1
  jr  $ra


# Procedure Dif (Do not modify)
Dif:
  sub $v0, $a0, $a1
  jr  $ra