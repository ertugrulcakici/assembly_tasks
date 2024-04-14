
int max_position(int *tp_array, int t_len);
void int2str(int t_num, char *tp_str);
int main(int argc, char const *argv[])
{

    int iarray[10] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
    printf("max position: %d\n", max_position(iarray, 10));
    char num[64];
    int2str(65535, num);
    printf("int2str: %s\n", num);

    return 0;
}
