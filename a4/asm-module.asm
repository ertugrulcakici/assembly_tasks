bits 64

section .text
global hex2int
global factorial
global clean_no_prime
global modulo_0
global power
global up_low

; long factorial(long t_num)
; Compute factorial of long. If result overflow, return 0.
factorial:
    mov rax, 1 ; Initialize result to 1
    mov rcx, rdi ; Initialize counter to the input value
.back:
    cmp rcx, 0 ; Check if the counter has reached 0
    je .done ; If yes, jump to the done label
    IMUL rcx ; Multiply the result by the counter
    dec rcx ; Decrement the counter
    cmp rdx, 0 ; Check if the multiplication overflowed
    jne .overflow ; If yes, jump to the overflow label
    jmp .back ; Loop back
.overflow:
    mov rax, 0 ; Set the result to 0 to indicate overflow
.done:
    ret ; Return the final result

; int hex2int(const char *hexStr)
; Convert hex-string into number.
; hex2int:
;     mov rbp, rsp ; establish new base pointer
;     mov rdx, rdi ; load pointer to the hex string into rdx
;     xor eax, eax ; clear EAX for the result
;     xor ecx, ecx ; clear ECX, will use it to hold the character

; .next_char:
;     mov cl, byte [rdx] ; Load the next byte (character) of the string into CL
;     cmp cl, 0 ; Test if it's the null terminator (0)
;     je .done ; If zero, we're done

;     ; Convert ASCII to hex value
;     sub cl, '0' ; Subtract ASCII '0' to get the actual numeric value
;     cmp cl, 9
;     jbe .is_digit ; Jump if it's 0-9
;     sub cl, 7 ; Adjust for 'A'-'F' and 'a'-'f'
;     sub cl, 32 ; Adjust for lowercase letters
;     and cl, 0xF ; Ensure we only have a 4-bit value

; .is_digit:
;     shl eax, 4 ; Shift the current result left by 4 bits to make room
;     or eax, ecx ; OR it with the new digit to add it to the result
;     inc rdx ; Move to the next character in the string
;     jmp .next_char ; Repeat the loop

; .done:
;     mov rsp, rbp ; restore old base pointer
;     ret ; Return with the result in EAX

; up_low:
;     push rbp
;     mov rbp, rsp
    
;     mov r8, rdi ; r8 = tp_str
;     mov r9d, esi ; r9d = t_up_low
;     xor r10, r10 ; r10 = i = 0
    
; .loop:
;     mov cl, [r8 + r10] ; cl = current character
;     test cl, cl
;     jz .end
    
;     cmp r9d, 0 ; t_up_low == 0
;     je .to_lower
    
; .to_upper:
;     cmp cl, 'a'
;     jb .next
;     cmp cl, 'z'
;     ja .next
;     sub cl, 32
;     jmp .update
    
; .to_lower:
;     cmp cl, 'A'
;     jb .next
;     cmp cl, 'Z'
;     ja .next
;     add cl, 32
    
; .update:
;     mov [r8 + r10], cl
    
; .next:
;     inc r10
;     jmp .loop
    
; .end:
;     pop rbp
;     ret


; ; void power(int *tp_array, int t_N, int t_X)
; ; Compute sequence power of X to N. If result overflow, set result to 0.

; power:
;     push rbp
;     mov rbp, rsp
    
;     mov r8, rdi ; r8 = tp_array
;     mov r9d, esi ; r9d = t_N
;     mov r10d, edx ; r10d = t_X
;     xor r11, r11 ; r11 = i = 0
    
; .loop:
;     cmp r11d, r9d
;     je .end
    
;     mov eax, [r8 + 4*r11] ; eax = tp_array[i]
;     mov ecx, r10d ; ecx = t_X
    
;     ; Compute power
;     xor edx, edx
; .power_loop:
;     test ecx, 1
;     jz .next
;     imul eax, [r8 + 4*r11] ; eax *= tp_array[i]
;     jo .overflow
    
; .next:
;     shl dword [r8 + 4*r11], 1 ; tp_array[i] <<= 1
;     jo .overflow
;     shr ecx, 1
;     jnz .power_loop
    
;     mov [r8 + 4*r11], eax ; tp_array[i] = eax
;     inc r11
;     jmp .loop
    
; .overflow:
;     mov dword [r8 + 4*r11], 0 ; tp_array[i] = 0
;     inc r11
;     jmp .loop
    
; .end:
;     pop rbp
;     ret

; void clean_no_prime(int *tp_array, int t_N)
; Set to zero all numbers in int array which are not prime.
clean_no_prime:
    push rbp
    mov rbp, rsp

    mov r8, rdi        ; r8 = tp_array
    mov r9d, esi       ; r9d = t_N
    xor r10, r10       ; r10 = i = 0

.loop:
    cmp r10d, r9d
    je .end

    mov eax, [r8 + 4*r10] ; eax = tp_array[i]
    cmp eax, 1
    je .set_to_zero        ; 1 is not a prime
    cmp eax, 2
    je .is_prime
    cmp eax, 3
    je .is_prime

    ; Check divisibility by 2 and 3 first
    mov edx, 0
    mov ecx, 2
    div ecx
    cmp edx, 0
    je .set_to_zero
    mov edx, 0
    mov ecx, 3
    mov edx, eax
    div ecx
    cmp edx, 0
    je .set_to_zero

    ; Check if number is prime for numbers greater than 3
    mov ecx, 5
.is_prime_loop:
    mov edx, 0
    mov eax, [r8 + 4*r10]
    cmp ecx, eax
    jge .is_prime
    div ecx
    cmp edx, 0
    je .set_to_zero
    add ecx, 2
    jmp .is_prime_loop

.set_to_zero:
    mov dword [r8 + 4*r10], 0 ; tp_array[i] = 0

.is_prime:
    inc r10
    jmp .loop

.end:
    pop rbp
    ret
; int modulo_0(int *tp_array, int t_N, int t_M)
; How many numbers in array has modulo of M equal to zero?
modulo_0:

    push rbp
    mov rbp, rsp
    mov r8, rdi       ; r8 = tp_array
    mov r9d, esi      ; r9d = t_N
    mov r10d, edx     ; r10d = t_M
    test r10d, r10d   ; Check if M is zero
    je .end           ; If M is zero, exit to avoid division by zero
    xor eax, eax      ; eax = count = 0
    xor r11, r11      ; r11 = i = 0

.loop:
    cmp r11d, r9d
    je .end
    mov ecx, [r8 + 4*r11] ; ecx = tp_array[i]
    mov edx, 0            ; Clear edx for division
    mov eax, ecx          ; Load current array element into eax
    div r10d              ; Divide eax by r10d (M)
    cmp edx, 0            ; Check if remainder is zero
    jne .continue
    inc eax               ; Increment count if divisible

.continue:
    inc r11
    jmp .loop

.end:
    pop rbp
    ret
