
    bits 64
    section .data

    section .text
    ;rdi, rsi, rdx, rcx, r8, r9 ;arguments

    global int2str
int2str:
    mov eax, edi ; t_number
    ; do { digit = t_number % 10; t_number /= 10;} while (t_number != 0);

    mov rcx, 0 
    mov r8d, 10

.back:
    cdq ; extension of eax into edx-edx
    idiv r8d ;eax /% 10
    add dl, '0' ; M -> 'M', 'M' = M + '0'
    mov [rdi + rcx], dl
    inc rcx
    cmp eax, 0
    jne .back

    mov [rsi+ rcx], byte 0 ; str[i] = 0 or str[i] = '\0' or 0x0

    mov rdi, rsi
    add rdi, rcx
    dec rdi ; rsi = *left, rdi = *right

.rotate:
    cmp rsi, rdi ; while(left < right)
    jge .done

    mov al, [rsi] ; al = *left ; swap *left <-> *right
    mov ah, [rdi] ; ah = *right
    mov [rsi], ah ; *left = *right
    mov [rdi], al ; *right = *left
    inc rsi ; left++
    dec rdi ; right

    ret 

    global max_position
max_position:
    mov rcx, 0          ; i = 0 
    movsx rsi, esi      ; len  = extension of len
    mov eax, 0
    mov edx, [rdi + 0]

.back:
    cmp rcx, rsi        ; i < len
    jge .done

    cmp edx, [rdi + rcx * 4] ; if (max < arr[i]) ?
    cmovl edx, [rdi + rcx * 4] ; max = arr[i] ?
    cmovl eax, ecx     ; pos = i


    inc rcx
    jmp .back

. done:
    ret