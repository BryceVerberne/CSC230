# Title:  Seven Segment Display
# Desc:   This program demonstrates how to use the seven segment display & timer
# Author: Bryce Verberne
# Title:  04/11/2023



# Info:
#   - Sleep: Can be repeatedly called for short periods of time to slow the 
#     execution of a running program.
    
.eqv LEFT_SEG    0xFFFF0010
.eqv RIGHT_SEF   0xFFFF0011
.eqv COUNTER_INT 0xFFFF0013  # This byte is used to enable the interrupt

.eqv ZERO 0x3f  #b'00111111'
.eqv ONE  0x06  #b'00000110'


.text
  .globl main
main:
  
  li $s4, 1
  
  # Base address for each segment
  li $s0, LEFT_SEG
  li $s1, RIGHT_SEF
  li $s2, ZERO
  li $s3, ONE
  
  # Enable Interrupts
  li $t0, COUNTER_INT
  li $t1, 1
  sb $t1, 0($t0)    # Write a 1 to our Interrupt Byte
  
  loop:
    # Sleep
    li $v0, 32
    li $a0, 1000
    syscall
    
    sb $s2, 0($s0)  # Store a zero to the left side
    sb $s3, 0($s1)  # Store a one to the right side
    
    # Sleep
    li $v0, 32
    li $a0, 1000
    syscall
    
    sb $s3, 0($s0)  # Store a zero to the left side
    sb $s2, 0($s1)  # Store a one to the right side
    
    
    move $a0, $s4
    li $v0, 1
    syscall
    b loop
  
  # Terminating Program
  li $v0, 10
  syscall
  
  
# Interrupt Code
.ktext 0x80000180
  # If we do anything here, we can mess with the real time program.
  
  addi $s4, $s4, 1
  eret
