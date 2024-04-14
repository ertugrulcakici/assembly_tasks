
    bits 64
    section .data

    section .text
    ;rdi, rsi, rdx, rcx, r8, r9 ;arguments

    global position_max
    global change_sign
    global highest_bit

; extern int position_max(int *tp_array, int t_len); // Find position of the maximum negative number in array. (return -1 if there is no negative number) (-1, -10, -100 => -1)
position_max:
    mov eax, 0 ; position
    mov edx, 0x80000000 ; MAX_INT
    mov rcx, 0 ; i
.back:
    cmp rcx, rsi ; i < t_len
    jge .done ; if not, return position

    cmp [rdi + rcx * 4], DWORD 0 ; if negative
    jge .skip ; if not, skip
    cmp [rdi + rcx * 4], edx ; if greater than MAX_INT
    jle .skip ; if not, skip
    mov edx, [rdi + rcx * 4] ; update MAX_INT
    mov eax, ecx ; update position
.skip:
    inc rcx ; i++
    jmp .back ; repeat until i < t_len
.done:
    ret

; extern void change_sign(char *tp_array, int t_len); // Change sign of all negative numbers in array char carrray[] = { -10, 20, -30, 40, -50, 60, ... };
change_sign:
    mov rcx, 0 ; i
.back:
    cmp rcx, rsi ; i < t_len
    jge .done ; if not, return position

    cmp [rdi + rcx], byte 0 ; if negative
    jge .skip ; if not, skip
    neg byte [rdi + rcx] ; change sign

.skip:
    inc rcx ; i++
    jmp .back ; repeat until i < t_len
.done:
    ret

; extern long highest_bit(long t_number);             // Find highest bit in long. // find how many time we have to shift to right to get 0. For example for decimal 5 is 101, so highest bit is 3
highest_bit:
    mov eax,0 
.back:
    cmp rdi,  0
    je .done
    SHR rdi,1
.skip:
    inc eax
    jmp .back
.done:
    ret
