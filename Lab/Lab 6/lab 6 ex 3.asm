bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    s db 12h, 15h, 14h, 17h, 19h, 22h, 25h, 29h, 30h, 31h
    len equ $-s             ; lungimea sirului s
    pare times len db 0   
    impare times len db 0
  
  
; Extrageti in 2 siruri diferite nr. pare/impare  
; segment code use32 class=code
    start:
       mov ecx, len
       jecxz final
       mov esi, 0           ; i = 0
       mov edi, 0           ; j = 0
       mov ebx, 0           ; k = 0
    repeta:
       mov al, [s+esi]      ; s[i]
       
       ; xxxxxxxx AND  (continutul lui al)
       ; 00000001
       ; 00000000 - par     -> ZF = 1
       ; 00000001 - impar   -> ZF = 0
       test al, 01h         ; testam daca numarul din al este par sau impar
       jz e_par
   
       mov [impare+ebx], al   ; numarul este impar
       inc ebx
       jmp peste
       
    e_par:                ; numarul e par
        mov [pare+edi], al
        inc edi
        
    peste:
        inc esi
        loop repeta
        
    final:
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program