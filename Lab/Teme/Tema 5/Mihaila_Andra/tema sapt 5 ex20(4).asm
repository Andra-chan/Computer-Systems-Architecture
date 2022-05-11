bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; a-word; b-byte; e-doubleword; x-qword
segment data use32 class=data

    a dw 10
    b db 20
    e dd 30
    x dq 30

; 20. x-b+8+(2*a-b)/(b*b)+e  Interpretare cu semn
segment code use32 class=code
    start:
        
    mov ebx, 0
    mov ecx, 0
    mov eax, 0
    mov edx, 0
    
    ;calculez x-b+8
    mov ebx, dword[x+0] 
    mov ecx, dword[x+4] ;ebx:ecx=x
    
    mov al, byte[b]     ;ax=al+ah=b
    
    sub ebx, eax        ;ebx=x-b
    add ebx, 8          ;ebx=x-b+8
    
    ;calculez (2*a-b) 
    mov ax, 2
    imul word[a]        ;ax=2*a
    mov dl, byte[b]     ;dx=dl+dh=b
    sbb ax, dx          ;ax=ax-dx=(2*a-b)
    
    ;calculez (b*b)
    mov edx, 0
    mov edx, eax        ;edx=(2*a-b)
    mov al, byte[b]     ;al=b
    imul byte[b]        ;ax=al*b=b*b
    
    ;calculez (2*a-b)/(b*b)
    mov cx, ax          ;cx=b*b
    mov eax, edx        ;eax=2*a-b
    idiv cx             ;eax=(2*a-b)/(b*b)
    
    ;calculez (2*a-b)/(b*b)+e
    mov edx, dword[e]   ;edx=e
    add eax, edx        ;eax=edx+eax=(2*a-b)/(b*b)+e
    
    ;calculez x-b+8+(2*a-b)/(b*b)+e
    add eax, ebx        ;eax=x-b+8+(2*a-b)/(b*b)+e
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
