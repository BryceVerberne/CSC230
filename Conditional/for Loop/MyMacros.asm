# Title:  My Macros
# Desc:   Keep all your really kool nifty difty macros here
# Author: Bryce Verberne
# Data:   02/21/2023



.macro printString (%s)
  la $a0, %s
  li $v0, 4
  syscall
.end_macro
   
.macro readInt (%t)
  li $v0, 5   # The code to read an int is 5. 
  syscall
   
  move %t, $v0
.end_macro
   
.macro done
  li $v0, 10
  syscall
.end_macro
   
.macro printInt (%t)
  move $a0, $t0
  li $v0, 1
  syscall
.end_macro
   
.macro printNewLine
  li $a0, '\n'
  li $v0, 11
  syscall
.end_macro
