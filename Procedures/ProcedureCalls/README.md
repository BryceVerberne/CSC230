# Procedure Calls

A MIPS assembly program that demonstrates the concept of procedure calls in MIPS assembly language.

## Description

The "Procedure Calls" program is designed to teach the concept of procedure calls in MIPS assembly language. It simulates a simple C program that takes two integers, x and y, and calculates their sum and difference using two procedures, Sum and Dif. The program highlights the use of jump and link (jal) instruction to call procedures and return address register ($ra) to return to the calling routine.

## Program Overview

The program consists of three main sections:

1. **main**: Initializes the values of x and y, calls the Sum and Dif procedures with these values, prints the results, and then terminates the program.
2. **Sum**: Receives two integers as arguments and returns their sum.
3. **Dif**: Receives two integers as arguments and returns their difference.

## Usage

1. Ensure you have a compatible MIPS simulator installed on your system (e.g., [MARS MIPS simulator](http://courses.missouristate.edu/KenVollmar/MARS/)).
2. Load the `Procedure Calls.asm` file into the MIPS assembly simulator.
3. Assemble and run the program.

## Output

Upon executing the program, the user will see the following output, showcasing the sum and difference of x and y:

```plaintext
15
5
```

This output demonstrates the program's ability to call procedures and perform arithmetic operations in MIPS assembly.
