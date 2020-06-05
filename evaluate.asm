%include "io.inc"
section .bss
    myVect: resd 200
section .text
global CMAIN
print_arra:
    PRINT_DEC 4, [myVect + 4 * (ecx-1)]
    NEWLINE
    mov ebx, [myVect + 4 * (ecx-1)]
    dec ecx
    mov eax, [myVect + 4 * (ecx-1)]
    cmp eax, 0
    jnz print_arra
    ret
evaluate:
    mov ebx, [myVect + 4 * (ecx-1)]
    dec ecx
    cmp ecx, 0
    je print 
    cmp ebx, 43 ;+
    je adunare
    cmp ebx, 42 ;*
    je inmultire
    cmp ebx, 45 ;-
    je scadere
    cmp ebx, 47 ;/
    je inpartire
    push ebx
    cmp ecx, 0x00
    jmp evaluate
    ;jmp print
    
adunare:
    pop eax
    pop edx
    add edx, eax
    push edx 
    jmp evaluate
    
inmultire:
    pop eax
    pop edx
    imul edx, eax
    push edx 
    jmp evaluate
scadere:
    pop eax
    pop edx
    sub edx, eax
    push edx 
    jmp evaluate
    
inpartire:
    pop ebx  ; deimpartitul este pe stiva si se preia de catre ebx
    pop eax
    xchg eax, ebx  ; se pun operanzii in ordinea corecta
    cdq
    idiv ebx
    push edx 
    jmp evaluate
    
print: 
    pop eax
    PRINT_DEC 4, eax
    ret
    ;ret
CMAIN:
    mov ebp, esp; for correct debugging
    xor ecx, ecx
    mov eax, 43
    mov [myVect + 4*ecx], eax
    inc ecx
    mov eax, 43
    mov [myVect + 4*ecx], eax
    inc ecx
    mov eax, 8
    mov [myVect + 4*ecx], eax
    inc ecx
    mov eax, 8
    mov [myVect + 4*ecx], eax
    inc ecx
    mov eax, 8
    
    
    xor ecx, ecx
print_array:
    inc ecx
    mov eax, [myVect + 4 * ecx]
    cmp eax, 0
    jnz print_array
    
    ;call print_arra
    call evaluate

    
    xor eax, eax
    leave
    ret