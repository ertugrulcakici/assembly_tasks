#include <stdio.h>
#include <stdlib.h>

extern long factorial(long t_num);
extern int hex2int(const char *hexStr);

int main(int argc, char const *argv[])
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

    const char *hexString = "CAFE";
    int result = hex2int(hexString);

    printf("The hexadecimal string %s is %d in decimal.\n", hexString, result);
}