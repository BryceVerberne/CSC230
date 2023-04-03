#Title:   Memory Manipulation
# Desc:   This program demonstrates how to create a manipulate data in memory.
# Author: Bryce Verberne
# Date:   02/14/2023



.data  # This means everthing moving forward goes into the Data Segment
  var1: .byte 0x0a
  var2: .half 0x0b
  var3: .word 0x0c
  var4: .word 0x00     # Let's define a label but not give it any data.
  var5: .word 0x0d
  
  lst1: .byte 1, 2, 3, 4, 5
  lst2: .word 10, 11, 12, 13, 14
  
  lst3: .space 10      # This allocates ten bytes of memory. Doesn't need to be initialized. 
  
  var6: .byte 0x20     # Let's find our data!
  
  str1: .asciiz "Enter a String up to 20 characters"
  str2: .ascii "You Entered"
  str3: .asciiz "Cheers"
  
  userStr: .space 21   # I'm going to allocate 21 spaces for the user String
  deadData: .word 86
  
.text                  # Now we're talking code
  .globl main
main:                  # This is also a memory location. Methods are named memory location.

  # Let's add two words together.
  lw  $t0, var3
  lw  $t1, var4
  add $t1, $t0, $t1
  sw  $t1, var5
  
  # Let's ask the user for a String, get it, and echo it back.
  
  la $a0, str1         # Strings start at an address.
  li $v0, 4            # Let's print the string
  syscall
  
  la $a0, userStr      # Load the address of the buffer we created to hold the string
  li $a1, 21           # The maximum length of the string
  li $v0, 8
  syscall
  
  la $a0, userStr
  li $v0, 4
  syscall
 
 
# String heapStr;
# printf("How big is your String?");
# scanf("%d", len);
# heapStr = new String(x);
# heapStr = strdin.nextLine();

.data 
  prompt2: .asciiz "How big is your string? "
  prompt3: .asciiz "Enter your string "
  len:     .word 0   # This will be the length of the string.
  heapStr: .word 0   # This will hold the address of the string
  
  
.text
  la $a0, prompt2
  li $v0, 4
  syscall
  
  li $v0, 5          # Read an Integer
  syscall
  
  sw   $v0, len      # Save the length to the varible len
  move $a0, $v0      # $v0 is always the register used for returning data
  li   $v0, 9
  syscall
  
  sw $v0, heapStr    # Store the address of our String Location in RAM
  
  la $a0, prompt3    # Prompt for the string
  li $v0, 4
  syscall
  
  lw $a0, heapStr    # We have to load the value in heapStr, which is the address. 
  lw $a1, len
  li $v0, 8
  syscall
  
  lw $a0, heapStr    # Echo's it back
  li $v0, 4
  syscall


  # Terminate Program
  li $v0, 10
  syscall
