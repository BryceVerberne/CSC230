# Saving to Stack

This program showcases register value preservation in MIPS assembly using the stack to save `$s0` before calling `increaseReg`, maintaining its original value post-execution.

## Description

This project illustrates the concept of saving values to the stack when using procedures in MIPS assembly language. It demonstrates how to save and restore the values of stack registers `$s0` to `$s7` when calling a procedure, following the convention that a callee should not modify the values in the `$s#` registers. The program is based on the explanations provided by Amell Peralta in this YouTube video: [Saving Registers to Stack](https://www.youtube.com/watch?v=3napwKvocSU&list=PL5b07qlmA3P6zUdDf-o97ddfpvPFuNa5A&index=17&ab_channel=AmellPeralta).

## Program Overview

The program consists of two main sections:

1. **main**: Initializes a value in the `$s0` register, calls the increaseReg procedure while ensuring that the `$s0` register value is preserved, prints the value in `$s0`, and terminates the program.
2. **increaseReg**: Allocates space in the stack for the `$s0` register, saves its value to the stack, adds 30 to the value in the `$s0` register, prints the new value, restores the initial value of `$s0` from the stack, and returns to the main procedure.

## Usage

1. Ensure you have a compatible MIPS simulator installed on your system (e.g., [MARS MIPS simulator](http://courses.missouristate.edu/KenVollmar/MARS/)).
2. Load the `Saving to Stack.asm` file into the MIPS assembly simulator.
3. Assemble and run the program.

## Output

The following output shows how the program preserves the initial value of `$s0` by saving it to the stack before an operation, ensuring its original value remains unaltered after the procedure finishes.

```plaintext
This is our value in the procedure: 40
This is our value in main: 10
```

## Acknowledgements

- Special thanks to Amell Peralta for creating the [Saving Registers to Stack](https://www.youtube.com/watch?v=3napwKvocSU&list=PL5b07qlmA3P6zUdDf-o97ddfpvPFuNa5A&index=17&ab_channel=AmellPeralta) video that inspired this project.
