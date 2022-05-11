bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    
     a dw 0111011101010111b
     b dw 1001101110111110b
     c dw 0

; Se dau cuvintele A si B. Se cere cuvantul C format astfel:
;- bitii 0-2 ai lui C coincid cu bitii 10-12 ai lui B
;- bitii 3-6 ai lui C au valoarea 1
;- bitii 7-10 ai lui C coincid cu bitii 1-4 ai lui A
;- bitii 11-12 au valoarea 0
;- bitii 13-15 ai lui C concid cu inverul bitilor 9-11 ai lui B
segment code use32 class=code
    start:
    
        mov bx, 0
        
        ;- bitii 0-2 ai lui C coincid cu bitii 10-12 ai lui B
        mov ax, [b]
        and ax, 0001110000000000b
        mov cl, 10
        ror ax, cl                  ;rotim 10 pozitii catre dreapta
        or bx, ax
        
        ;- bitii 3-6 ai lui C au valoarea 1
        or bx, 0000000001111000b
        
        ;- bitii 7-10 ai lui C coincid cu bitii 1-4 ai lui A
        mov ax, [a]
        and ax, 0000000000011110b
        mov cl, 6
        rol ax, cl
        or bx, ax
        
        ;- bitii 11-12 au valoarea 0
        and bx, 1110011111111111b
        
        ;- bitii 13-15 ai lui C concid cu inversul bitilor 9-11 ai lui B
        mov ax, [b]
        not ax
        and ax, 0000111000000000b
        rol ax, 4
        or bx, ax
        
        mov [c], bx 
        
    
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
