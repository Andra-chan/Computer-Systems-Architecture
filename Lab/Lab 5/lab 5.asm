bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    
    a dw 100
    b dd 200
    c dq 300

; Calculati valoarea expresiei: c-b+a
segment code use32 class=code
    start:
    ;a. fara semn
    
    mov eax, 0     
    mov edx, 0    
    mov eax, dword[c+0]
    mov edx, dword[c+4]     ;eax:edx=c
    
    mov ebx, 0   
    mov ebx, dword[b]       ;ebx=b
    sub eax, ebx            
    sbb edx, 0              ;eax:edx=c-b
    
    
    mov cx, word[a]         ;cx=a
    add eax, ecx   
    adc edx, 0              ;eax:ebx=c-b+a
   
    ;b. cu semn

    mov ebx, 0
    mov ecx, 0 
    mov ebx, dword[c+0]
    mov ecx, dword[c+4]
    
    mov eax, 0
    mov edx, 0
    mov eax, dword[b]
    cdq
    sub ebx, eax
    sbb ecx, edx
    
    mov ax, word[a]
    cwde
    cdq
    
    add ebx, eax
    adc ecx, edx
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
