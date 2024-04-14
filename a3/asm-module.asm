bits 64
section .data
section .text
;rdi, rsi, rdx, rcx, r8, r9 ;arguments
global position_max
global change_sign
global highest_bit

; extern int position_max(int *tp_array, int t_len);
; Find position of the maximum negative number in array. (return -1 if there is no negative number) (-1, -10, -100 => -1)
position_max:
    mov eax, -1 ; initialize result to -1
    xor rcx, rcx ; i = 0
.loop:
    cmp rcx, rsi ; i < t_len
    jge .end ; if not, return
    cmp dword [rdi + 4 * rcx], 0 ; if arr[i] >= 0
    jge .skip ; skip this element
    mov eax, ecx ; update result
.skip:
    inc rcx ; i++
    jmp .loop
.end:
    ret

; extern void change_sign(char *tp_array, int t_len);
; Change sign of all negative numbers in array
change_sign:
    mov rdi, rdi  ; pointer to the array
    mov rsi, rsi  ; length of the array
    mov rcx, 0    ; index counter

.back:
    cmp rcx, rsi   ; compare counter with length
    jge .done      ; if counter >= length, we're done
    mov al, [rdi + rcx] ; load current element (byte)
    test al, al    ; test if the number is negative
    jge .skip      ; if positive or zero, skip
    neg byte [rdi + rcx] ; negate the value

.skip:
    inc rcx         ; increment index
    jmp .back       ; go back to the loop start
.done:
    ret             ; return

; extern long highest_bit(long t_number);
; Find highest bit in long. 
; Find how many time we have to shift to right to get 0.
highest_bit:
    xor rax, rax ; result = 0
.loop:
    test rdi, rdi ; if t_number == 0
    jz .end ; we're done
    shr rdi, 1 ; t_number >>= 1
    inc rax ; result++
    jmp .loop
.end:
    ret