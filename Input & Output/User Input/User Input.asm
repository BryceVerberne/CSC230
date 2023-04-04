# Title:  User Input
# Desc:   This program demonstrates how to take input from the user.
# Author: Bryce Verberne
# Date:   04/04/2023



.data
  # Integer Section
  prompt:   .asciiz "Enter your age: "
  message1: .asciiz "You are "
  message2: .asciiz " years old!"
  
  # Float Section
  message3:     .asciiz "\n\nEnter the value of PI: "
  zeroAsFloat: .float 0.0  # The float section (Coproc 1) doesn't have a $zero register. So we make one.
  
  # Double Section
  prompt1: .asciiz "\n\nEnter the value of e: "
  
  # Text Section
  prompt2:  .asciiz "\n\nEnter your name: "
  message4: .asciiz "Hello, "
  input:    .space  20     # We need to specify how many characters the user is allowed to enter

.text
  .globl main
main:

  # ------------------
  # Getting an Integer
  # ------------------
  
  # Prompt the user to enter age - "Enter your age: "
  li $v0, 4
  la $a0, prompt
  syscall
  
  
  # Get the user's age
  li $v0, 5      # 5 is the code to tell the system that we want to read an integer from the user
  syscall
  
  # Store the result in $t0
  move $t0, $v0  # We need to store the user's value in a different register since we need $v0
  
  
  # Display 'message1' - "You are"
  li $v0, 4
  la $a0, message1
  syscall
  
  # Display the user's integer - "You are <user's number>"
  li $v0, 1
  move $a0, $t0
  syscall 
  
  # Display the final message ('message2') - "You are <user's number> years old!
  li $v0, 4
  la $a0, message2
  syscall
  
  
  # ------------------
  # Getting a Float
  # ------------------
  # Floats are in Coproc 1 (Coprocessor 1) 
  
  lwc1 $f4, zeroAsFloat  # We are loading the value zero into $f0
  
  # Display 'message3' - "Enter the value of PI: "
  li $v0, 4
  la $a0, message3
  syscall
  
  
  # Read user's input
  li $v0, 6              # 6 is the code to tell the system that we want to read a float from the user
  syscall
  
  
  # Display the user's value
  li $v0, 2              # 2 is the code to display a float
  add.s $f12, $f0, $f4   # $f12 is for the argument. Similar to $a0 with our normal registers.
                         # We use add.s for floats
  syscall
  
  
  # ------------------
  # Getting a Double
  # ------------------
  # Doubles are in Coproc 1 (Coprocessor 1) 
  
  # Display 'prompt1' - "Enter the value of e: "
  li $v0, 4
  la $a0, prompt1
  syscall
  
  
  # Get the double from the user.
  li $v0, 7  # 7 is the code to tell the system that we want to read a double from the user
  syscall
  
  
  # Display the user's value
  li $v0, 3
  add.d $f12, $f0, $f10  # $f12 is for the argument. Similar to $a0 with our normal registers.
                         # We use add.d for doubles
                         # We can use any empty $f# register for zero since this is their default value.
  syscall
  
  
  # ------------------
  # Getting Text
  # ------------------
   
  # Display 'prompt2' - "What is your name?"
  li $v0, 4
  la $a0, prompt2
  syscall
   
   
  # Get text from the user
  li $v0, 8      # 8 is the code to tell the system that we want to read text from the user
  la $a0, input  # We always have to pass the address of the variable where we want to store the users text. 
  li $a1, 20     # We have to tell the system the maximum length of the string (20 bytes)
  syscall
  
  
  # Display 'message4' - "Hello, "
  li $v0, 4
  la $a0, message4
  syscall
  
  # Display the user's name - "Hello, <User name>
  # We treat this like printing any other string.
  li $v0, 4
  la $a0, input  # The text entered was inputted into our 'input' variable
  syscall
  

  # Terminating Program
  li $v0, 10
  syscall