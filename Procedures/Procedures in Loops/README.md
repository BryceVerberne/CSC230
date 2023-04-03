# Procedures in Loops

A MIPS assembly program that demonstrates the concept of calling a procedure within a loop.

## Description

The "Procedures in Loops" program showcases how to call a procedure within a loop in MIPS assembly. It mimics the behavior of a simple C program that initializes a variable `i` and increments it within a loop while printing the current value of `i`. The program highlights the use of jump and branch instructions and demonstrates how to create a reusable procedure for printing values.

## Program Overview

The program consists of two main sections:

1. **main**: Initializes the value of i in the $t0 register, creates a loop that increments i and calls the printNumber procedure, and then terminates the program.
2. **printNumber**: Prints the current value of i along with a descriptive string, and then returns to the calling loop.

## Usage

1. Ensure you have a compatible MIPS simulator installed on your system (e.g., [MARS MIPS simulator](http://courses.missouristate.edu/KenVollmar/MARS/)).
2. Load the `Procedures in Loops.asm` file into the MIPS assembly simulator.
3. Assemble and run the program.

## Output

Upon executing the program, the user will see the following output, showcasing the loop iteration and the procedure call to print the current value of `i`:

```plaintext
This is the current value of i: 1
This is the current value of i: 2
This is the current value of i: 3
This is the current value of i: 4
This is the current value of i: 5
This is the current value of i: 6
This is the current value of i: 7
This is the current value of i: 8
This is the current value of i: 9
This is the current value of i: 10
```

This output demonstrates the program's ability to call a procedure within a loop and perform iterations in MIPS assembly.
