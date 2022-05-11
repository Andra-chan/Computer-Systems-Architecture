bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)

;a - byte, b - word, c - double word, d - qword
segment data use32 class=data

    a db 10
    b dw 20
    c dd 30
    d dq 40  

;20. a-b-(c-d)+d Interpretare cu semn
segment code use32 class=code
    start:
    
    mov eax, 0
    mov edx, 0
    
    ;calculez a-b
    mov dl, byte[a]     ;dx=a(dx=dl+dh=a+0=a)
    mov ax, word[b]     ;ax=b
    sbb dx, ax          ;dx=dx-ax=a-b
    
    ;calculez c-d
    mov eax, dword[c]   ;eax=c
    
    mov ebx, 0
    mov ecx, 0
    
    mov ebx, dword[d+0] 
    mov ecx, dword[d+4] ;ebx:ecx=d
    
    sub eax, ebx        ;eax=c-d
    
    ;calculez a-b-(c-d)
    sub edx, eax        ;edx=a-b-(c-d)
    
    ;calculez a-b-(c-d)+d
    add edx, ebx
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
