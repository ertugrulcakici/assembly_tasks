bits 64

section .text
global hex2int
global factorial
global clean_no_prime
global modulo_0
global power
global up_low

factorial:
    push rbp                
    mov rbp, rsp            
    mov rax, rdi            
    cmp rdi, 0              
    je .if_zero
    mov rcx, 1              

._loop:
    cmp rdi, rcx            
    jle .end_loop           
    imul rax, rcx           
    jo .overflow            
    inc rcx                 
    jmp ._loop

.end_loop:
    mov rsp, rbp            
    pop rbp                 
    ret                     

.if_zero:
    mov rax, 1              
    jmp .end_loop

.overflow:
    mov rax, -1             
    jmp .end_loop

hex2int:
    push rbp                ; save old base pointer
    mov rbp, rsp            ; establish new base pointer
    mov rdx, rdi            ; load pointer to the hex string into rdx

    xor eax, eax            ; clear EAX for the result
    xor ecx, ecx            ; clear ECX, will use it to hold the character

.next_char:
    movzx ecx, byte [rdx]   ; Load the next byte (character) of the string into ECX
    test ecx, ecx           ; Test if it's the null terminator (0)
    jz .done                ; If zero, we're done

    ; Convert ASCII to hex value
    sub ecx, '0'            ; Subtract ASCII '0' to get the actual numeric value
    cmp ecx, 9
    jbe .is_digit           ; Jump if it's 0-9
    sub ecx, 7              ; Adjust for 'A'-'F' and 'a'-'f'
    sub ecx, 32             ; Adjust for lowercase letters
    and ecx, 0xF            ; Ensure we only have a 4-bit value

.is_digit:
    shl eax, 4              ; Shift the current result left by 4 bits to make room
    or eax, ecx             ; OR it with the new digit to add it to the result

    inc rdx                 ; Move to the next character in the string
    jmp .next_char          ; Repeat the loop

.done:
    pop rbp                 ; restore old base pointer
    ret                     ; Return with the result in EAX

clean_no_prime:
    push rbp
    mov rbp, rsp
    
    mov r8, rdi ; r8 = tp_array
    mov r9d, esi ; r9d = t_N
    xor r10, r10 ; r10 = i = 0
    
.loop:
    cmp r10d, r9d
    je .end
    
    mov eax, [r8 + 4*r10] ; eax = tp_array[i]
    cmp eax, 2
    je .is_prime
    
    ; Check if number is prime
    mov ecx, 2
.is_prime_loop:
    cmp ecx, eax
    je .is_prime
    test eax, ecx
    jz .set_to_zero
    inc ecx
    jmp .is_prime_loop
    
.set_to_zero:
    mov dword [r8 + 4*r10], 0
    
.is_prime:
    inc r10
    jmp .loop
    
.end:
    pop rbp
    ret

modulo_0:
    push rbp
    mov rbp, rsp
    
    mov r8, rdi ; r8 = tp_array
    mov r9d, esi ; r9d = t_N
    mov r10d, edx ; r10d = t_M
    xor eax, eax ; eax = count = 0
    xor r11, r11 ; r11 = i = 0
    
.loop:
    cmp r11d, r9d
    je .end
    
    mov ecx, [r8 + 4*r11] ; ecx = tp_array[i]
    xor edx, edx
    div r10d
    cmp edx, 0
    je .increment
    
.continue:
    inc r11
    jmp .loop
    
.increment:
    inc eax
    jmp .continue
    
.end:
    pop rbp
    ret

; void power(int *tp_array, int t_N, int t_X)
; Compute sequence power of X to N. If result overflow, set result to 0.
power:
    push rbp
    mov rbp, rsp
    
    mov r8, rdi ; r8 = tp_array
    mov r9d, esi ; r9d = t_N
    mov r10d, edx ; r10d = t_X
    xor r11, r11 ; r11 = i = 0
    
.loop:
    cmp r11d, r9d
    je .end
    
    mov eax, [r8 + 4*r11] ; eax = tp_array[i]
    mov ecx, r10d ; ecx = t_X
    
    ; Compute power
    xor edx, edx
.power_loop:
    test ecx, 1
    jz .next
    imul eax, [r8 + 4*r11]
    jo .overflow
    
.next:
    shl dword [r8 + 4*r11], 1
    jo .overflow
    shr ecx, 1
    jnz .power_loop
    
    mov dword [r8 + 4*r11], eax
    inc r11
    jmp .loop
    
.overflow:
    mov dword [r8 + 4*r11], 0
    inc r11
    jmp .loop
    
.end:
    pop rbp
    ret

; void up_low(char *tp_str, int t_up_low)
; Convert string to upper or lower case optionally.
up_low:
    push rbp
    mov rbp, rsp
    
    mov r8, rdi ; r8 = tp_str
    mov r9d, esi ; r9d = t_up_low
    xor r10, r10 ; r10 = i = 0
    
.loop:
    mov cl, [r8 + r10] ; cl = current character
    test cl, cl
    jz .end
    
    cmp r9d, 0 ; t_up_low == 0
    je .to_lower
    
.to_upper:
    cmp cl, 'a'
    jb .next
    cmp cl, 'z'
    ja .next
    sub cl, 32
    jmp .update
    
.to_lower:
    cmp cl, 'A'
    jb .next
    cmp cl, 'Z'
    ja .next
    add cl, 32
    
.update:
    mov [r8 + r10], cl
    
.next:
    inc r10
    jmp .loop
    
.end:
    pop rbp
    ret