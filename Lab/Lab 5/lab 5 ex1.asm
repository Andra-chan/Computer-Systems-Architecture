bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    
    a dd 24
    b dd 22

; our code starts here
segment code use32 class=code
    start:
    
    mov eax, [a]
    sub eax, 2              ;eax = 22 -> ZF = 0
    
    cmp eax, [b]            ; scadere fictiva eax - b  -> ZF = 1
    ; if b > a
    ja mai_mare
    ...
    jmp final               ;b > a  

    mai_mare:
        ...                 ;a > b
        
    final:
    
    
    ;SAU
    
    mov eax, [a]
    sub eax, 2              ;eax = 22 -> ZF = 0
    
    cmp eax, [b]            ; scadere fictiva eax - b  -> ZF = 1
    ; if b > a
    ja mai_mare
    ; if a > b
    jb mai_mic
    ...

    mai_mare:
        ...                 
    mai_mic:
        ...
        jmp final
    final:
    
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
