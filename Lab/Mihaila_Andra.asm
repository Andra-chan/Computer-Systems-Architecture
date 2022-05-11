bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    s1 dw 1, 2, 3, 4, 5, 6, 7, 8, 9
    len equ $-s1
	s2 times len db 0


; Completati programul urmator astfel incat sirul s2 obtinut
; sa contina aceleasi valori ca sirul s1 si in aceeasi ordine
; (s2: 1, 2, 3, 4, 5, 6, 7, 8, 9)
segment code use32 class=code
    start:
        mov esi, 0
        mov ebx, len
        
    repeta:
    mov ax, [s1+esi]
    mov [s2+esi], ax
    inc esi
    
    loop repeta
    
    

        push dword 0
        call [exit]
