# Title:  Macros
# Desc:   This file contains a collection of assembly macros for common tasks.
# Author: Bryce Verberne
# Data:   02/21/2023



.macro printString (%s)
  la $a0, %s
  li $v0, 4
  syscall
.end_macro
   
.macro readInt (%t)
  li $v0, 5     # The code to read an int is 5. 
  syscall
   
  move %t, $v0
.end_macro
   
.macro done
  li $v0, 10
  syscall
.end_macro
   
.macro printInt (%t)
  move $a0, %t
  li $v0, 1
  syscall
.end_macro
   
.macro printNewLine
  li $a0, '\n'
  li $v0, 11
  syscall
.end_macro

# Allocate %t bytes of memory & store resulting base address in %v
.macro malloc (%t) (%v)
  move $a0, %t  # Move the number of bytes to allocate into $a0
  li   $v0, 9   # 9 is used to allocate heap memory
  syscall
  move %v, $v0  # Move the resulting address into %v
.end_macro

.macro printHex (%t)
  li   $v0, 34
  move $a0, %t
  syscall 
.end_macro