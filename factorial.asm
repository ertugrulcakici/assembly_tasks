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