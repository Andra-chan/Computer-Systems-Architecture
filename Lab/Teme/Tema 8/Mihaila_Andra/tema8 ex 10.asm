bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; Se da un sir A de cuvinte. Construiti doua siruri de octeti:
;  - B1: contine ca elemente partea superioara a cuvintelor din A
;  - B2: contine ca elemente partea inferioara a cuvintelor din A
segment data use32 class=data
    a dw 1122h, 3344h, 5566h, 7788h
    len equ ($-a)/2
    b1 times len db 0
    b2 times len db 0

; our code starts here
segment code use32 class=code
    start:
        mov ecx, len        ; numarul de elemente in sir
        jecxz sir2          ; daca ECX = 0, sare la sir2
        
        cld                 ; setam directia dreapta
        mov esi, a          ; incarcare offset a
        mov edi, b1         ; incarcare offset b1
        
    extrageb1:
        lodsb               ; AL = 22h + ESI = ESI + 2 (daca DF = 0)
        lodsb               ; AL = 11h + ESI = ESI + 2 (daca DF = 0)
        
        stosb               ; b1 <- AL +inc EDI (daca DF = 0)
    
        loop extrageb1      
        
    sir2:
        mov ecx, len        ; numarul de elemente in sir
        jecxz final         ; daca ECX = 0, sare la final
        
        cld                 ; setam directia dreapta
        mov esi, a          ; incarcare offset a
        mov edi, b2         ; incarcare offset b2
        
    extrageb2:
        lodsb             ; AL = 22h + ESI = ESI + 2 (daca DF = 0)
        inc esi           ; sare peste partea superioara 
        
        stosb             ; b2 <- AL +inc EDI (daca DF = 0)
        
        loop extrageb2
        
    final:
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
