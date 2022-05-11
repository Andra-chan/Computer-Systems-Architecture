bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf              ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    msg_1 db 'Valoarea lui ECX este: %d', 10, 13, 0
    msg_2 db 'Programul se termina...', 10, 13, 0

; our code starts here
segment code use32 class=code
    start:
        mov ecx, 5
        jecxz final
    repeta:
        push ecx
        ; afisez valoarea lui ECX
        push ecx
        push dword msg_1
        call [printf]
        add esp, 4*2
        
        loop repeta
        
    final:
    push ecx 
    push dword msg_2
    call [printf]
    add esp, 4*2
   
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
