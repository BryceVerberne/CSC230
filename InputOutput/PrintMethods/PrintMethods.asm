# Title:  Print Methods
# Desc:   This program converts a C program that uses print methods to assembly
# Author: Bryce Verberne
# Title:  04/13/2023


# C Main Function: 
 # include <stdio.h>

 # Global Array
 # int myInts[] = {3, -8, -9, 12, 14, -23, 32, 33, 42};

 # int main(void) {
 #
 #    printReverse(myInts);
 #    printPositive(myInts);
 #    exit();
 # }

.data


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
  
  
# C printReverse Function:
#  // Print every other # in reverse
#  void printReverse(int[] myInts) {
#    printf("[");
#    for (int i = 8; i >= 0; i -= 2) {
#       printInt(myInts[i]);
#       printf("%d",myInts[i]);
#       printf(" ");
#    }
#    printf("]\n");
# }

.text
printReverse:
  # Prolog - Save State
  
  # Logic
  
  # Epilog
   
  # Return
  # if I need to return a value, it must be in $v0
  jr $ra


# C printPositive Function: 
#  // Print positive #'s
#  void printPositive(int[] myInts) {
#    printf("[");
#    for (int i = 0; i < 9; i++) {
#      if (myInts[i] > 0) {
#        printInt(myInts[i]);
#	 printf("%d",myInts[i]);
#        printf(" ");
#      }
#    }
#    printf("]\n");
#  }

.text
printPositive:
  # Prolog - Save State
  
  # Logic
  
  # Epilog
   
  # Return
  jr $ra


# C printInt Function:
#  void printInt(int x) {
#    print(x);
#    print(' ');
#  }
 
.text
printInt:


  # Return
  jr $ra