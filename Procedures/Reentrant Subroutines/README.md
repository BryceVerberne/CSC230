# Reentrant Subroutines

This MIPS assembly project showcases reentrant subroutines by converting a C program to assembly.

## Description

This MIPS assembly program, which converts a C program to assembly, demonstrates reentrant subroutines by reading a positive integer from the user, printing it, and terminating. Reentrant subroutines enable multiple calls without return address issues by saving and restoring the return address register ($ra) on the stack, ensuring correct returns for getInt and printPrompt subroutines.

The program incorporates macros to simplify and enhance readability. For more information on the macros used in this project, refer to the README file for "MyMacros.asm" [here](https://github.com/BryceVerberne/CSC230/blob/main/Procedures/Macros/README.md).

## Program Overview

The program consists of three main sections:

1. **main**: Calls the getInt subroutine to read a positive integer from the user, prints the entered integer, and terminates the program.
2. **getInt**: Uses a loop to repeatedly ask the user for a positive integer until a valid input is provided. It also demonstrates reentrant subroutines by saving and restoring the return address register ($ra) on the stack.
3. **printPrompt**: A subroutine that takes the address of a string in $a0 and prints the string. This subroutine is called within the getInt section to display a prompt to the user.

## Usage

1. Ensure you have a compatible MIPS simulator installed on your system (e.g., [MARS MIPS simulator](http://courses.missouristate.edu/KenVollmar/MARS/)).
2. Load the `Nested Procedures.asm` and 'MyMacors.asm' file into the MIPS assembly simulator.
3. Assemble and run the program.
4. Follow the prompt to enter a positive number.
5. The program will output the first positive number inputted. 

## Example

The following example demonstrates the program prompting the user to enter a positive number and then displaying the entered value:

```plaintext
Please enter a positive number: -5
Please enter a positive number: 0
Please enter a positive number: 42
You entered 42
```

