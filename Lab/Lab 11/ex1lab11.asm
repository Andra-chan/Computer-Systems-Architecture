bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, scanf, printf
import exit msvcrt.dll
import scanf msvcrt.dll
import printf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dd 0
    b dd 0
    sum dd 0
    format db "%d",0
    format_p db "a + b = %d",0
    msg_a db "a = ",0
    msg_b db "b = ",0

; a + b
; a si b sunt citite de la tastatura
segment code use32 class=code
    ; eax = suma_1(a,b)
    ; eax = a
    ; ebx = b
    suma_1:
        add eax, ebx
        ret
        

    start:
        push dword msg_a
        call [printf]
        add esp, 4*1
        push dword a
        
        push dword format
        call [scanf]
        add esp, 4*2
        
        push dword msg_b
        call [printf]
        add esp, 4*1
        push dword b
        push dword format
        call [scanf]
        add esp, 4*2
        
        mov eax, [a]
        mov ebx, [b]
        
        ;add eax, ebx  
        call suma_1
        mov [sum], eax
        
        push dword [sum]
        push dword format_p
        call [printf]
        add esp, 4*2
        
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
