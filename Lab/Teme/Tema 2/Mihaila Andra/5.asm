bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)

;11. (e+f)*(2*a+3*b)

segment data use32 class=data
    
    a db 10
    b db 20
    e dw 30
    f dw 40

; our code starts here
segment code use32 class=code
    start:
    
    mov ax, [a]     ;ax=a
    mov dx, 2       ;dx=2
    mul dx          ;ax:dx=ax*dx=a*2
    
    push ax
    push dx
    pop eax         ;eax=a*2
    
    mov ax, [b]     ;ax=b
    mov dx, 3       ;dx=3
    mul dx          ;ax:dx=ax*dx=b*3
    
    push ax
    push bx
    pop ebx         ;ebx=b*3
    
    add eax, ebx    ;eax=eax+ebx=a*2+b*3
    
    mov ebx, [e]    ;ebx=e
    add ebx, [f]    ;ebx=e+f
    
    mul eax         ;eax=eax*ebx=(e+f)*(a*2+b*3)
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
