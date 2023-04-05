# Nested Procedures

A MIPS assembly language program demonstrating the concept of nested procedures through the use of two procedures, one of which calls the other.

## Description

This project demonstrates the concept of nested procedures in MIPS assembly language. The program increases a value stored in the `$s0` register by 30, and then calls a nested procedure to print the value before and after the addition. The program is based on the concepts explained by Amell Peralta in this YouTube video: [MIPS Assembly Nested Procedures](https://www.youtube.com/watch?v=E0PHijf0P7g&list=PL5b07qlmA3P6zUdDf-o97ddfpvPFuNa5A&index=18&ab_channel=AmellPeralta).

## Program Overview

The program consists of three main sections:

1. **main**: Initializes a value in the `$s0` register, calls the `increaseReg` procedure, prints the value before and after the addition, and then terminates the program.
2. **increaseReg**: Adds 30 to the value in the `$s0` register, saves the current values of `$s0` and `$ra` in the stack, prints the value after the addition, calls the `printVal` procedure, and then restores the values of `$s0` and `$ra` from the stack.
3. **printVal**: Prints the value stored in the `$s0` register and returns to the calling procedure.

## Usage

1. Ensure you have a compatible MIPS simulator installed on your system (e.g., [MARS MIPS simulator](http://courses.missouristate.edu/KenVollmar/MARS/)).
2. Load the `Nested Procedures.asm` file into the MIPS assembly simulator.
3. Assemble and run the program.

## Output

The following output demonstrates the program increasing the value in $s0 register by 30 and printing the value before and after the increase using nested procedures.

```plaintext
This is our value in main: 10
This is our value in the procedure: 40
```

## Acknowledgments

- Special thanks to Amell Peralta for creating the [MIPS Assembly Nested Procedures](https://www.youtube.com/watch?v=E0PHijf0P7g&list=PL5b07qlmA3P6zUdDf-o97ddfpvPFuNa5A&index=18&ab_channel=AmellPeralta) video that inspired this project.
