# Subroutines

This MIPS assembly program reads a positive integer from the user, validates the input, and prints the entered integer using subroutines.

## Description

The "Subroutines" program is designed to teach the concept of subroutines in MIPS assembly language. It simulates a simple C program that reads a positive integer from the user, prints the entered integer, and terminates. The program highlights the use of jump and link (jal) instruction to call subroutines and return address register ($ra) to return to the calling routine.

The program incorporates macros to simplify and enhance readability. For more information on the macros used in this project, refer to the README file for "MyMacros.asm" [here](https://github.com/BryceVerberne/CSC230/blob/main/Procedures/Macros/README.md).

## Program Overview

The program consists of two main sections:

1. **main**: Calls the `getInt` subroutine, prints the result with the help of the included `MyMacros.asm`, and then terminates the program.
2. **getInt**: Reads a positive integer from the user and keeps asking until a positive number is entered, then returns the value in `$v0`.

## Usage

1. Ensure you have a compatible MIPS simulator installed on your system (e.g., [MARS MIPS simulator](http://courses.missouristate.edu/KenVollmar/MARS/)).
2. Load the `Subroutines.asm` and `MyMacros.asm` file into the MIPS assembly simulator.
3. Assemble and run the program.
4. Follow the prompt to enter a positive number.
5. The program will output the first positive number inputted. 

## Example

The following example demonstrates the program prompting the user to enter a positive number and displaying it once a positive number is recieved:

```plaintext
Please enter a positive number: -5
Please enter a positive number: 0
Please enter a positive number: 42
You entered 42
```

This output demonstrates the program's ability to use subroutines for user input validation and printing results in MIPS assembly.
