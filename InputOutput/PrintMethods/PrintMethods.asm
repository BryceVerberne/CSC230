# Complete the following program in Assembly.  Call that program
# PrintMethods.asm.
# You CANNOT USE any macro's for this assignment.
#
#include <stdio.h>

# Global Array
#int myInts[] = {3, -8, -9, 12, 14, -23, 32, 33, 42};

#int main(void) {
#
#    printReverse(myInts);
#    printPositive(myInts);
#    exit();
#}
.text
  .globl main
main:
  
  # always pass values in $a0 thru $a3
  la $a0, myInts			# Put the address of our array into $a0
  jal printReverse
  la $a0, myInts			# I don't know if printReverse modifies $a0...
  jal printPositive
  
  #Exit
  li $v0, 10
  syscall
  
# end main
  
#// Print every other # in reverse
#void printReverse(int[] myInts) {
#    printf("[");
#    for (int i = 8; i >= 0; i -= 2)
#    {
#        printInt(myInts[i]);
#        //printf("%d",myInts[i]);
#        //printf(" ");
#    }
#    printf("]\n");
#}
# This IS a reentrant subroutine
.text
printReverse:
  # prolog - Save State
  
  # logic
  
  # epilog
   
  # return
  # if I need to return a value, it must be in $v0
  jr $ra

# End printReverse

#// Print positive #'s
#void printPositive(int[] myInts) {
#    printf("[");
#    for (int i = 0; i < 9; i++)
#    {
#      if (myInts[i] > 0) {
#          printInt(myInts[i]);
#	        //printf("%d",myInts[i]);
#          //printf(" ");
#      }
#    }
#    printf("]\n");
#}

.text
printPositive:
  # prolog - Save State
  
  # logic
  
  # epilog
   
  # return
# endPrintPositive

#void printInt(int x) {
#  print(x);
#  print(' ');
#}
# This is NOT a reentrant subroutine.  
.text
printInt:


# end printInt