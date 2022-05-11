bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)


; a - byte, b - word, c - double word, d - qword
segment data use32 class=data
    
    a db 10
    b dw 20
    c dd 30
    d dq 40
    
; 20. (a+c)-b+a+(d-c) Interpretare fara semn
segment code use32 class=code
    start:
    
    ;calculez a+c
    mov eax, 0          
    mov eax, dword[c]   
    mov edx, 0          
    mov dl, byte[a]     ;dx=ah+al=a
    add eax, edx        ;eax=a+c
    
    ;calculez (a+c)-b
    mov edx, 0          ;edx=0
    mov dx, word[b]     ;dx=b
    sub eax, edx        ;eax=(a+c)-b
  
    ;calculez (a+c)-b+a  
    mov edx, 0          ;edx=0
    mov dl, byte[a]     ;dx=dh+dl=a
    add eax, edx        ;eax=eax+edx=(a+c)-b+a
    
    ;calculez d-c
    mov ebx, 0
    mov ecx, 0
    
    mov ebx, dword[d+0] 
    mov ecx, dword[d+4] ;ebx:ecx=d
    
    sub ebx, dword[c]   ;ebx=d-c
    
    ;calculez (a+c)-b+a+(d-c)
    add eax, ebx        ;eax=(a+c)-b+a+(d-c)
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program