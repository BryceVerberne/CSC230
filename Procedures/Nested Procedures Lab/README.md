# Nested Procedures Lab

A MIPS assembly program that demonstrates nested procedures by converting a C program with nested functions into MIPS assembly code.

## Description

The Nested Procedures Lab illustrates nested procedure implementation in MIPS assembly, featuring a C program with nested functions and its equivalent MIPS assembly code. The lab highlights stack and register usage for nested procedures, common in low-level programming, and calculates variable `z` using nested functions/procedures, outputting the result.

## Program Overview

The program consists of three main sections:

1. **main**: Initializes the values of `x` and `y` in the `$s0` and `$s1` registers, calls the Sum procedure, calculates the value of `z` as `x + y + Sum(x, y)`, outputs the result, and terminates the program.
2. **Sum**: Allocates space in the stack for `$ra`, `$s0`, and `$s1`, calculates two differences using the `Dif` procedure, stores the results in `$v1` and `$v0`, deallocates the stack space, adds the two differences to get the sum, and returns to the main procedure.
3. **Dif**: Computes the difference between two input values passed in `$a0` and `$a1`, stores the result in `$v0`, and returns to the calling procedure.

## Usage

1. Ensure you have a compatible MIPS simulator installed on your system (e.g., [MARS MIPS simulator](http://courses.missouristate.edu/KenVollmar/MARS/)).
2. Load the `Nested Procedures Lab.asm` file into the MIPS assembly simulator.
3. Assemble and run the program.

## Output

Upon executing the program, the user will receive a single integer value as output, which represents the calculated value of `z` using the given input values for `x` and `y` and the nested procedures `Sum` and `Dif`:
```plaintext
11
```
This output conveys the result of the calculation `z = x + y + Sum(x, y)` and showcases the program's ability to perform arithmetic operations and handle nested procedure calls in MIPS assembly. 
