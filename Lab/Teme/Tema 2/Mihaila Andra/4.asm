bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)

;11. [(d/2)*(c+b)-a*a]/b

segment data use32 class=data

    a db 10
    b db 20
    c db 30
    d dw 40
    
; our code starts here
segment code use32 class=code
    start:
    
     mov ax, [d]         ;AX=d
     mov dx, 2
     div ax              ;AL=AX/2=d/2
    
     mov ah, [c]         ;AH=c
     add ah, [b]         ;AH=c+b
     mul ah              ;AX=AH*AL=(d/2)*(c+b)
    
     mov dl, [a]         ;DL=a
     mov dh, [a]
     mul dl              ;DX=DL*a=a*a
    
     sub ax, dx          ;AX=AX-DX=[(d/2)*(c+b)-a*a]
     mov dx, [b]
     div ax
     
     mov dx, [b]
     div ax              ;AX=AX/DX=AX/b=[(d/2)*(c+b)-a*a]/b
             
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
