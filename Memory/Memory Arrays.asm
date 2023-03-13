#Title:   Memory Arrays
# Desc:   This program demonstrates how to manipulate arrays.
# Author: Bryce Verberne
# Date:   02/14/2023



.data
  nums1: .word 1, 2, 3, 4
  nums2: .word 0, 0, 0, 0
  nums3: .word 0, 0, 0, 0, 0, 0, 0, 0
  
  
.text
  .globl main
main:

  # How can we store the values in nums1 into nums2 in reverse order?
  
  la $s0, nums1   # Load the address of nums1 into $s0. $s0 is our base address
  la $s1, nums2   # $s2 is the base address of nums2
  
  # When you deal with arrays you must deal with a base address and an offset.
  # You are used to the array name and an index. I use offset.
  
  lw $t0, 0($s0)  # x1 = nums1[0]; x = nums1[0];  nums1 is the base, 0 is the offset
  lw $t1, 4($s0)  # x2 = nums1[1]; Remember that MIPS does byte addressing.
  lw $t2, 8($s0)  # x3 = nums1[2];
  lw $t3, 12($s0) # x4 = nums1[3];
  
  sw $t0, 12($s1) # nums2[3] = x1
  sw $t1, 8($s1)  # nums2[2] = x2
  sw $t2, 4($s1)  # nums2[1] = x3
  sw $t3, 0($s1)  # nums2[0] = x4
  
  # Write nums1 to nums using Pointers.
  
  la $s2, nums3
  sw $t0, 0($s2)
  addi $s2, $s2, 4
  sw $t1, 0($s2)
  addi $s2, $s2, 4
  sw $t2, 0($s2)
  addi $s2, $s2, 4
  sw $t3, 0($s2)
  
  li $v0, 10
  syscall
  
  
  # Terminate Program
  li $v0, 10
  syscall
