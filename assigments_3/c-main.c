extern int position_max(int *tp_array, int t_len);  // Find position of the maximum negative number in array. (return -1 if there is no negative number) (-1, -10, -100 => -1)
extern void change_sign(char *tp_array, int t_len); // Change sign of all negative numbers in array char carrray[] = { -10, 20, -30, 40, -50, 60, ... };
extern int highest_bit(long t_number);              // Find highest bit in long. // find how many time we have to shift to right to get 0
void for_position_max();
void for_change_sign();
void for_highest_bit();
int main(int argc, char const *argv[])
{
    for_position_max();
    for_change_sign();
    for_highest_bit();
}
void for_position_max()
{
    int arr[] = {-3, -1, -4, -2, -5, 3, 1, 4, 2, 5};
    int len = sizeof(arr) / sizeof(arr[0]);
    int result = position_max(arr, len);
    printf("Position of the lowest negative number: %d\n", result);
}
void for_change_sign()
{
    char carr[] = {-10, 20, -30, 40, -50, 60};
    int len = sizeof(carr) / sizeof(carr[0]);
    change_sign(carr, len);
    for (int i = 0; i < len; i++)
    {
        printf("%d ", carr[i]);
    }
}
void for_highest_bit()
{
    // 0b101 -> 3
    long result = highest_bit(5);
    printf("Highest bit: %d\n", result);
}
