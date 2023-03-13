# Title: Max Value
# Desc: In this program, I am creating a if-else branch that finds the maximum value
# Author: Bryce Verberne
# Date: 02/19/2023



.data
maxVal: .asciiz "This is the largest value: "

.text
  .globl main
main:

  li $s0, 5
  li $s1, 9
  li $s2, 8
  li $s3, 3

  slt $t0, $s0, $s1
  bne $t0, $zero, compare1
    j leave1                    
  compare1: move $s0, $s1
  leave1:

  slt $t0, $s0, $s2
  bne $t0, $zero, compare2
    j leave2
  compare2: move $s0, $s2
  leave2:


  slt $t0, $s0, $s3
  bne $t0, $zero, compare3
    j leave3
  compare3: move $s0, $s3
  leave3:              
                  
  la $a0, maxVal
  li $v0, 4
  syscall

  move $a0, $s0
  li $v0, 1
  syscall


  # Terminating Program
  li $v0, 10
  syscall
