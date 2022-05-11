bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; A: 2, 1, -3, 3, -4, 2, 6
; B: 4, 5, 7, 6, 2, 1
; R: 1, 2, 6, 7, 5, 4, -3, -4
segment data use32 class=data
    
    a db 2, 1, -3, 3, -4, 2, 6          ; declararea sirului initial a
    lena equ $-a                        ; stabilirea lungimii sirului initial lena corespunzator sirului initial a
    b db 4, 5, 7, 6, 2, 1               ; declararea sirului initial b    
    lenb equ $-b                        ; stabilirea lungimii sirului initial lenb corespunzator sirului initial b
    r times lena+lenb db 0              ; rezervarea unui spatiu de dimensiune lena+lenb pentru sirul destinatie r si intializarea acestuia

; 21. Se dau 2 siruri de octeti A si B.
; Sa se construiasca sirul R care sa contina elementele lui B in ordine inversa urmate de elementele negative ale lui A.
segment code use32 class=code
    start:
    
        mov ecx, lenb
        jecxz negativ
        mov esi, 0          ; i = 0
        mov edi, lenb       ; j = lenb
        dec edi             ; j = lenb - 1
    repeta:
        mov al, [b+esi]     ; b[i]
        mov [r+edi], al     ; r[j]
         
        inc esi             ; i++
        dec edi
        loop repeta
        
    negativ:
        mov ecx, lena         
        jecxz final
        mov esi, 0
        mov edi, lenb
    repeta2:
        mov al, [a+esi]     ; a[i]
        cmp al, 0           ; comparam nr din al cu 0(SF se va face 0 sau 1)
        js e_negativ        ; jump if sign(SF=1)
        jmp peste           ; else
       
    e_negativ:
        mov [r+edi], al     ; numarul e negativ
        inc edi
        
    peste:
        inc esi
        loop repeta2
   
    final:
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
