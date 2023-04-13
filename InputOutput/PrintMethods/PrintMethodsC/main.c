#include <stdio.h>
#include <stdlib.h>

// Global Array
int myInts[] = {3, -8, -9, 12, 14, -23, 32, 33, 42};

// Prototypes
void printReverse(int myInts[]);
void printPositive(int myInts[]);
void printInt(int x);

int main(void) {

    printReverse(myInts);
    printPositive(myInts);

    exit(0);
}

// Print every other # in reverse
void printReverse(int myInts[]) {
    printf("[ ");
    for (int i = 8; i >= 0; i -= 2) {
        printInt(myInts[i]);  // printf("%d ", myInts[i]);
    }
    printf("]\n");
}

// Print positive #'s
void printPositive(int myInts[]) {
    printf("[ ");
    for (int i = 0; i < 9; i++) {
        if (myInts[i] > 0) {
            printInt(myInts[i]);  // printf("%d ", myInts[i]);
        }
    }
    printf("]\n");
}

void printInt(int x) {
    printf("%d ", x);
}