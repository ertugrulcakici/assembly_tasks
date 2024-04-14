#include <stdio.h>
#include <stdlib.h>

extern void power(int *tp_array, int t_N, int t_X);   // Compute sequence power of X to N. If result overflow, set result to 0.
extern void up_low(char *tp_str, int t_up_low);       // Convert string to upper or lower case optionally.
extern long factorial(long t_num);                    // Compute factorial of long. If result overflow, return 0.
extern void clean_no_prime(int *tp_array, int t_N);   // Set to zero all numbers in int array which are not prime.
extern int hex2int(const char *hexStr);               // Convert hex-string into number. // tp_str[] = "CAFE";
extern int modulo_0(int *tp_array, int t_N, int t_M); // How many numbers in array has modulo of M equal to zero?

void for_power();
void for_up_low();
void for_factorial();
void for_clean_no_prime();
void for_hex2int();
void for_modulo_0();

int main(int argc, char const *argv[])
{
    printf("Assignment 4\nFor power\n");
    for_power();
    printf("\nFor up_low\n");
    for_up_low();
    printf("\nFor factorial\n");
    for_factorial();
    printf("\nFor clean_no_prime\n");
    for_clean_no_prime();
    printf("\nFor hex2int\n");
    for_hex2int();
    printf("\nFor modulo_0\n");
    for_modulo_0();
}

void for_power()
{
    int arr[] = {1, 2, 3, 4, 5};
    int N = sizeof(arr) / sizeof(arr[0]);
    int X = 2;
    power(arr, N, X);

    for (int i = 0; i < N; i++)
    {
        printf("%d ", arr[i]);
    }
    printf("\n");
}

void for_up_low()
{
    char str[] = "Hello World";
    up_low(str, 1);
    printf("String in lower case: %s\n", str);
}

void for_factorial()
{
    long num = 5;
    long result = factorial(num);

    if (result == -1)
    {
        printf("Overflow occurred");
    }
    else
    {
        printf("Factorial of %ld is %ld\n", num, result);
    }
}

void for_clean_no_prime()
{
    int arr[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
    int N = sizeof(arr) / sizeof(arr[0]);
    clean_no_prime(arr, N);

    for (int i = 0; i < N; i++)
    {
        printf("%d ", arr[i]);
    }
    printf("\n");
}

void for_hex2int()
{
    const char *hexString = "CAFE";
    int result = hex2int(hexString);

    printf("The hexadecimal string %s is %d in decimal.\n", hexString, result);
}

void for_modulo_0()
{
    int arr[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
    int N = sizeof(arr) / sizeof(arr[0]);
    int M = 3;
    int result = modulo_0(arr, N, M);

    printf("Numbers in array that are divisible by %d: %d\n", M, result);
}
