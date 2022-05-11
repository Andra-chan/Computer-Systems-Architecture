bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
; our data is declared here (the variables needed by our program)

;11.(b-c)+(d-a)

segment data use32 class=data

    a dw 10
    b dw 30
    c dw 20
    d dw 40

; our code starts here
segment code use32 class=code
    start:
        
        mov ax, [a]     ;AX=a
        mov bx, [b]     ;BX=b
        mov cx, [c]     ;CX=c
        mov dx, [d]     ;DX=d
        sub bx, cx      ;BX=BX-CX=b-c
        sub dx, ax      ;DX=DX+AX=d+a
        add bx, dx      ;BX=BX+AX=(b-c)+(d-a)
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
