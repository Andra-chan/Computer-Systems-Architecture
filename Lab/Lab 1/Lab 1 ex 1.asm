bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 8
    b dw 75
    c dd 125

; our code starts here
segment code use32 class=code
    start:
    
        ;1000 0000+
        ;1000 0000
        ;---------
      ;1 0000 0000
        
        mov eax, 0
        ;128 + 128 = 256
        mov al, 10000000b
        add al, 128         ;AL = 128 + 128 si CF = 1
        adc ah, 0           ;AX = AH:AL + CF
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
