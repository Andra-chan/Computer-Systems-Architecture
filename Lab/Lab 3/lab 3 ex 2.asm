bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
-*-
; our data is declared here (the variables needed by our program)

; a - doubleword ; b, c - byte; c - word; e - qword
segment data use32 class=data
    
    a dd 25
    b db 2
    c dw 15
    d db 200
    e dq 80

; Interpretare fara semn
; a + b/c - d*2 - e
segment code use32 class=code
    start:
        ; calculez b/c
        mov al, [b]
        mov ah, 0                    ; AX = b
        mov dx, 0                    ; DX = 0000000000000000 00000000 b 
        
        div word[c]                  ; AX= DX:AX/c = b/c, DX=DX:AX%c
        
        ; calculez d*2
        
        mov bx, ax                   ; stochez temporal b/c in bx
        mov al, 2
        mul byte [d]                 ; AX = AL * d = 2*d
        
        ; calculez b/c - d*2
        sub bx, ax                   ; BX = BX - AX = b/c - d*2
        mov cx, 0                    ; CX:BX = b/c - d*2
        
        ; calculez a + b/c - d*2
        mov ax, word [a]
        mov dx, word [a+2]           ; DX:AX = a
        add ax, bx                   ;
        adc dx, cx                   ; DX:AX + CX:BX = a + b/c - d*2
        
        push dx
        push ax
        pop eax                      ; EAX = a + b/c - d*2
        
        ; calculez a + b/c - d*2 - e 
        mov edx, 0                   ; EDX:EAX = a + b/c - d*2
        sub eax, dword [e]
        sbb edx, dword [e+4]         ; EDX:EAX = EDX:EAX - e = a + b/c - d*2 - e
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
