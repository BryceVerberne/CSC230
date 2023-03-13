#Title:   First Mips Program Version 3
# Desc:   Let's take our First Mips Program and expand on that significantly.
# Author: Bryce Verberne
# Date:   02/07/2023



# int x;  // Global Variable
# int y;  // Global Variable
# int main() {
#   printf("Enter a number and I will add 3 to it ");
#   scanf("%d", &x);
#   x = 3 + x;  // Let's add an immediate (coefficient) value to our equation
#   printf("Here is your results");
#   printf(x);  // Let's print the results
#   printf("\n");
#   exit();
# }

.data                # This tells the assembler that everything that follows is data
  # Declare variables
  # I don't need any integers for this version but I do need strings.
  prompt: .asciiz "Enter a number and I will add 3 to it "
  result: .asciiz "Here is your result: "

.text                # This tells the assember that everything that follows is code
  .globl main
main:                # This is the starting point
  # Get input
  la $a0, prompt     # Load the address of our string in RAM into the register $a0
  li $v0, 4          # The code to print a string
  syscall            # Print the string
  
  li $v0, 5          # The code to request the system to read an integer
  syscall            # Make the request
  move $t0, $v0      # Move the value entered by the user to $t0
  
  li $t1, 3
  add $t0, $t0, $t1  # Add 3 to the value entered by the user
  
  la $a0, result     # Load up the result string and print it
  li $v0, 4
  syscall
  
  move $a0, $t0      # Move x to $a0 and print it
  li $v0, 1
  syscall
  
  li $a0, '\n'       # Print a return characters so it looks good! 
  li $v0, 11
  syscall
  
  
  # Get out out of Dodge
  li $v0, 10         # Load up a code to tell the program we're done
  syscall