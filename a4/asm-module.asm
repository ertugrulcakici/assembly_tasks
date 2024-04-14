bits 64

section .text
global hex2int
global factorial

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
    push ebp                ; save old base pointer
    mov ebp, esp            ; establish new base pointer
    mov edx, [ebp + 8]      ; load pointer to the hex string into edx

    xor eax, eax            ; clear EAX for the result
    xor ecx, ecx            ; clear ECX, will use it to hold the character

.next_char:
    movzx ecx, byte [edx]   ; Load the next byte (character) of the string into ECX
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

    inc edx                 ; Move to the next character in the string
    jmp .next_char          ; Repeat the loop

.done:
    pop ebp                 ; restore old base pointer
    ret                     ; Return with the result in EAX

; ==============================================================================

; void clean_no_prime(int *tp_array, int t_N)
; Set to zero all numbers in int array which are not prime.
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

; int modulo_0(int *tp_array, int t_N, int t_M)
; How many numbers in array has modulo of M equal to zero?
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

; long factorial(long t_num)
; Compute factorial of long. If result overflow, return 0.
factorial:
    push rbp
    mov rbp, rsp
    
    mov rax, rdi ; rax = t_num
    cmp rax, 0
    je .zero
    
    mov rcx, 1 ; rcx = 1
    
.loop:
    cmp rax, rcx
    jle .end
    
    ; Multiply rax and rcx, check for overflow
    mul rcx
    jo .overflow
    
    inc rcx
    jmp .loop
    
.end:
    pop rbp
    ret
    
.zero:
    mov rax, 1
    pop rbp
    ret
    
.overflow:
    xor rax, rax
    dec rax ; rax = -1
    pop rbp
    ret

; int hex2int(const char *hexStr)
; Convert hex-string into number.
hex2int:
    push rbp
    mov rbp, rsp
    
    mov rdx, rdi ; rdx = hexStr
    xor eax, eax ; eax = result = 0
    
.loop:
    movzx ecx, byte [rdx] ; ecx = current character
    test cl, cl
    jz .end
    
    ; Convert ASCII to hex value
    sub ecx, '0'
    cmp ecx, 9
    jbe .is_digit
    sub ecx, 7
    sub ecx, 32
    and ecx, 0xF
    
.is_digit:
    shl eax, 4 ; Shift result left by 4 bits
    or eax, ecx ; Add current digit to result
    inc rdx ; Move to next character
    jmp .loop
    
.end:
    pop rbp
    ret