bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)

;11. (a + c - d) + d - (b + b - c)

segment data use32 class=data
    
    a db 10
    b db 20
    c db 30
    d db 40

; our code starts here
segment code use32 class=code
    start:
    
    mov ax, [a]       ;AX=a
    mov bx, [b]       ;BX=b
    mov cx, [c]       ;CX=c
    mov dx, [d]       ;DX=d
    add ax, cx        ;AX=AX+CX=a+c
    sub ax, dx        ;AX=AX-DX=a+c-d
    add ax, dx        ;AX=AX+DX=(a+c-d)+d
    add bx, [b]       ;BX=BX+b=b+b 
    sub bx, cx        ;BX=BX-CX=b+b-c
    sub ax, bx        ;AX=AX-BX=(a+c-d)+d -(b+b-c)
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
