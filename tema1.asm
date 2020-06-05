%include "/home/student/Desktop/skel/includes/io.inc"

extern getAST
extern freeAST

section .bss
    ; La aceasta adresa, scheletul stocheaza radacina arborelui
    root: resd 1
    myVect: resd 400
section .data
    myString db '  ', 0 
    string db "-13", 0 
    input dw 0

section .text
global main

Preorder:
    push ebp
    mov ebp, esp
    
    cmp word[ebp + 8], 0
    jne print
    jmp return
    
print:
    mov eax, [eax]
    ;push eax
    ;call puts
    mov ecx, 1
    mov edi, eax
    push ecx
    push edi
    call atoi
    ;mov edx, [edx]
    ;PRINT_DEC 4, [edx]
    ;NEWLINE
    mov [myVect+ebx*4], eax
    ;pop dword[+ebx*4]
    inc ebx
    
    ;PRINT_STRING myString
    push eax
    mov eax, [ebp + 8]
    mov eax, [eax + 4]
    push eax
    call Preorder
    
    mov eax, [ebp + 8]
    mov eax, [eax + 8]
    push eax
    call Preorder
    
return:
    leave
    ret 
    
atoi:
    mov eax, 0              ; Set initial total to 0
     
convert:
    movzx esi, byte [edi]   ; Get the current character
    test esi, esi           ; Check for \0
    je done
    
    cmp esi, '-'
    je sign
       
    cmp esi, 48             ; Anything less than 0 is invalid
    jl error
    
    cmp esi, 57             ; Anything greater than 9 is invalid
    jg error
     
    sub esi, 48             ; Convert from ASCII to decimal 
    imul eax, 10            ; Multiply total by 10
    add eax, esi            ; Add current digit to total
    
    inc edi                 ; Get the address of the next character
    jmp convert
    
sign:
    ;mov edx, [edi+1]
    ;inc edx
    movzx edx, byte[edi+1]
    ;PRINT_DEC 4, edi
    ;NEWLINE
    test edx, edx
    je error 
    inc edi
    mov ecx, -1
    jmp convert
    
error:
    mov eax, esi             ; Return -1 on error
 
done:
   ; PRINT_DEC 4, eax
    ;NEWLINE
    imul eax, ecx 
    ret
    
    
evaluate:
    mov ebx, [myVect + 4 * (ecx-1)]
    dec ecx
    ;cmp ecx, 0
    ;je print1 
    cmp ebx, 43 ;+
    je adunare
    cmp ebx, 42 ;*
    je inmultire
    cmp ebx, 45 ;-
    je scadere
    cmp ebx, 47 ;/
    je impartire
    push ebx
    cmp ecx, -1
    jne evaluate
    jmp print1
    
adunare:
    pop eax
    pop edx
    add edx, eax
    push edx 
    jmp evaluate
    
inmultire:
    pop edx
    pop eax
    imul edx, eax
    push edx 
    jmp evaluate
scadere:
    pop edx
    pop eax
    sub edx, eax
    push edx 
    jmp evaluate
    
impartire:
    pop eax  ; deimpartitul este pe stiva si se preia de catre ebx
    
    ;xchg eax, edx  ; se pun operanzii in ordinea corecta
    cdq
    pop esi
    idiv esi
    push eax 
    jmp evaluate
    
print1: 
    pop eax
    pop eax
    PRINT_DEC 4, eax
    ret
    ;ret
main:
    mov ebp, esp ;for correct debugging
    
    ;NU MODIFICATI
    push ebp
    mov ebp, esp
    
    ;Se citeste arborele si se scrie la adresa indicata mai sus
    call getAST
    mov [root], eax
    ;Implementati rezolvarea aici:
    ;mov ebx, 0
    ;push ecx
    push eax
    call Preorder
    ;call scoatere
    
    
    xor ecx, ecx

    mov ecx, ebx    
    call evaluate
    
    
    
    ; NU MODIFICATI
    ; Se elibereaza memoria alocata pentru arbore
    push dword [root]
    call freeAST
    
    xor eax, eax
    leave
    ret