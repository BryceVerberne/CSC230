# Procedure Basics

This program demonstrates MIPS assembly procedures by calling a `displayMessage` procedure to print a predefined message and then printing the value 5 in the main program.

## Description

The "Procedures Basics" program is designed to introduce users to the concept of procedures in MIPS assembly language. The program demonstrates how to call a procedure, perform operations within the procedure, and return to the main program after completing the procedure. This program was modeled after a tutorial by Amell Peralta, which can be found in this YouTube video: [Introduction to Functions](https://www.youtube.com/watch?v=easyXk-BUg0&list=PL5b07qlmA3P6zUdDf-o97ddfpvPFuNa5A&index=16&ab_channel=AmellPeralta).

## Program Overview

The program consists of two main sections:

1. **main**: Calls the `displayMessage` procedure and prints the value 5 after the procedure call, before terminating the program.
2. **displayMessage**: Prints a predefined message and returns to the main program.

## Usage

1. Ensure you have a compatible MIPS simulator installed on your system (e.g., [MARS MIPS simulator](http://courses.missouristate.edu/KenVollmar/MARS/)).
2. Load the `Procedures Basics.asm` file into the MIPS assembly simulator.
3. Assemble and run the program.

## Output

Upon executing the program, the user will see the following output:

```plaintext
Hi, everybody. 
My name is Bryce Verberne.
5
```

This output demonstrates the program's ability to call the displayMessage procedure and print a message within the procedure, as well as print the value 5 after the procedure call in the main program.

## Acknowledgements

Special thanks to Amell Peralta for creating the [Introduction to Functions](https://www.youtube.com/watch?v=easyXk-BUg0&list=PL5b07qlmA3P6zUdDf-o97ddfpvPFuNa5A&index=16&ab_channel=AmellPeralta) video that inspired this project.
