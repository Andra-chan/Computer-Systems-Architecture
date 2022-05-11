bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    s db 'Hello world'
    len equ $-s             ; lungimea sirului s
    d times len db 0        ; in d o sa avem sirul s inversat:d = 'dlrow olleH'
    
; Inversam caracterele din sirul s
segment code use32 class=code
    start:
        mov ecx, len
        jecxz final
        mov esi, 0          ; i = 0
        mov edi, len        ; j = len
        dec edi             ; j = len - 1
    repeta:
        mov al, [s+esi]     ; s[i]
        mov [d+edi], al     ; d[j]
        
        
        inc esi             ; i++
        dec edi
        loop repeta
        
    final:
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
