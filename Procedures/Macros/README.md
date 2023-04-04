# Macros

A MIPS assembly language program that defines a set of macros for common operations.

## Description

This project showcases the use of macros in MIPS assembly language. Macros are reusable pieces of code that can be used to simplify repetitive tasks or improve code readability. The provided program contains macros for common tasks such as printing strings or integers, reading integers, and printing newlines without rewriting the same assembly code multiple times. 

## Program Overview

1. **printString**: Accepts a string argument and prints it to the console.
2. **readInt**: Accepts a register argument, reads an integer from the user, and stores it in the specified register.
3. **done**: Terminates the program.
4. **printInt**: Accepts a register argument and prints the integer value stored in that register.
5. **printNewLine**: Prints a newline character to the console.

## Usage

1. Include the macro definitions at the beginning of your program (e.g., `.include "MyMacros.asm"`).
2. You can then use the macro names with the required arguments as needed throughout your code.

## Example

The following example showcases using macros in a MIPS assembly program to simplify user input reading and integer printing tasks while improving code readability.

```assembly
.include "MyMacros.asm"

.data
  prompt: .asciiz "Enter an integer: "

.text
  .globl main
main:
  printString(prompt)   # Print prompt
  readInt($t0)          # Read integer from user and store it in $t0
  printNewLine          # Print a newline character
  printInt($t0)         # Print the integer stored in $t0
  printNewLine          # Print another newline character
  done                  # Terminate the program
```

Given this example, if the user inputs the integer `42`, the output would look like this:

```plaintext
Enter an integer: 42
42
```

