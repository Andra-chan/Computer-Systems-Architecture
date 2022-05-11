bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; M, N, P - double word
segment data use32 class=data
    
    m dd 10011011101111100111011101010111b
    n dd 01110111010101111001101110111110b
    p dd 0
    
; bitii 0-6 din P coincid cu bitii 10-16 a lui M
; bitii 7-20 din P concid cu bitii obtinuti 7-20 in urma aplicarii M AND N.
; bitii 21-31 din P coincid cu bitii 1-11 a lui N.
segment code use32 class=code
    start:
    
    mov ebx, 0
        
    ; bitii 0-6 din P coincid cu bitii 10-16 a lui M
    mov eax, [m]
    and eax, 00000000000000011111110000000000b
    mov cl, 10
    ror eax, cl                ; rotim 10 pozitii catre dreapta
    or ebx, eax                ; se afla in ebx
    
    ; bitii 7-20 din P concid cu bitii obtinuti 7-20 in urma aplicarii M AND N.     
    mov eax, [m]
    and eax, [n]                ; in eax se afla m and n
    
    and eax, 00000000000111111111111110000000b
    or ebx, eax
    
    ; bitii 21-31 din P coincid cu bitii 1-11 a lui N.   
    mov eax, [n]
    and eax, 00000000000000000000111111111110b
    mov cl, 20
    rol eax, cl                 ; rotim 20 pozitii catre stanga
    or ebx, eax                 ; in edx se afla p
     
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
